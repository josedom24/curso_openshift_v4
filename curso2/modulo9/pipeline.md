# OpenShift Pipelines

**OpenShift Pipelines** es una solución de integración y entrega continuas (CI/CD) nativa de la nube para crear pipelines con Tekton. **Tekton** es un framework CI/CD flexible, nativo de Kubernetes y de código abierto que permite automatizar despliegues en distintas plataformas.

## Tekton CLI 

Vamos a usar una herramienta de línea de comandos llamada `tkn`, puedes seguir las siguientes [instrucciones](https://github.com/tektoncd/cli#installing-tkn) para su instalación. En Linux Debian:

    curl -LO https://github.com/tektoncd/cli/releases/download/v0.30.1/tektoncd-cli-0.30.1_Linux-64bit.deb
    sudo dpkg -i tektoncd-cli-0.30.1_Linux-64bit.deb

## Conceptos

Tekton define una serie de recursos de Kubernetes/OpenShift con el fin de estandarizar los conceptos de de IC/DC:

* `Task`: un número de pasos reutilizables que realizan una tarea específica (por ejemplo, construir una imagen de contenedor).
* `Pipeline`: la definición del pipeline y las tareas que debe realizar.
* `TaskRun`: la ejecución y el resultado de ejecutar una instancia de tarea.
* `PipelineRun`: la ejecución y el resultado de ejecutar una instancia de pipeline, que incluye un número de TaskRuns.

![tekton](img/tekton-architecture.svg)]

En resumen, para crear un Pipeline, se hace lo siguiente:

* Crear tareas (**Task**) personalizadas o instalar tareas reutilizables existentes.
* Crear un **Pipeline** y PipelineResources para definir el pipeline de entrega de su aplicación.
* Crear un **PersistentVolumeClaim** para proporcionar el volumen/sistema de archivos para la ejecución del pipeline.
* Crear un PipelineRun para instanciar e invocar el pipeline.
* Podemos crear distintos disparadores (triggers) que ejecutan el Pipeline con algún evento determinado.

## Despliegue de una aplicación de ejemplo con pipeline

Vamos a desplegar una aplicación muy sencilla de votaciones:

* [frontend](https://github.com/josedom24/pipelines-vote-ui): Aplicación construida con Python Flask que nos permite votar.
* [backend](https://github.com/josedom24/pipelines-vote-api): Aplicación escrita en Go que nos permite guardar la votaciones.

En el directorio `k8s` del repositorio se encuentran los ficheros yaml que posibilitan el despliegue de la aplicación.

### Instalación de Tasks

Las **Tasks** consisten en una serie de pasos que se ejecutan secuencialmente. Las tareas se ejecutan mediante la creación de **TaskRuns**. Un **TaskRun** creará un Pod y cada paso se ejecuta en un contenedor independiente dentro del mismo pod. Podemos definir entradas y salidas para interactuar con otras tareas en el pipeline.

Vamos a instalar dos tareas:

1. `apply-manifests`: responsable de ejecutar los ficheros yaml que se encuentran en el directorio`k8s` y por lo tanto aplicar los posibles cambios en los recurso que estamos creando.
2. `update-deployment`: responsable de actualizar el objeto **Deployment**, en concreto cambiar el nombre y la imagen.

Para ello tenemos el fichero `01_apply_manifest_task.yaml` con el siguiente [contenido](https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/01_apply_manifest_task.yaml) y el fichero `02_update_deployment_task.yaml` con este [contenido](https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/02_update_deployment_task.yaml)

Creamos las tareas ejecutando:

    oc create -f https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/01_apply_manifest_task.yaml
    oc create -f https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/02_update_deployment_task.yaml

Puedes ver la lista de tareas creadas, ejecutando una de estas dos instrucciones:

    oc get tasks
    tkn task ls

Hay tareas predefinidas en el clúster de OpenShift, para obtener la lista podemos ejecutar una de estas dos instrucciones:

    oc get clustertasks
    tkn clustertasks ls

### Creando el pipeline

En este ejemplo, vamos a crear un pipeline que toma el código fuente de la aplicación de GitHub y luego lo construye y despliega en OpenShift.

![pipeline](img/pipeline-diagram.png)

El fichero `04_pipeline.yaml` tiene la definición yaml del pipeline:

```yaml
apiVersion: tekton.dev/v1beta1
kind: Pipeline
metadata:
  name: build-and-deploy
spec:
  workspaces:
  - name: shared-workspace
  params:
  - name: deployment-name
    type: string
    description: name of the deployment to be patched
  - name: git-url
    type: string
    description: url of the git repo for the code of deployment
  - name: git-revision
    type: string
    description: revision to be used from repo of the code for deployment
    default: master
  - name: IMAGE
    type: string
    description: image to be build from the code
  tasks:
  - name: fetch-repository
    taskRef:
      name: git-clone
      kind: ClusterTask
    workspaces:
    - name: output
      workspace: shared-workspace
    params:
    - name: url
      value: $(params.git-url)
    - name: subdirectory
      value: ""
    - name: deleteExisting
      value: "true"
    - name: revision
      value: $(params.git-revision)
  - name: build-image
    taskRef:
      name: buildah
      kind: ClusterTask
    params:
    - name: IMAGE
      value: $(params.IMAGE)
    workspaces:
    - name: source
      workspace: shared-workspace
    runAfter:
    - fetch-repository
  - name: apply-manifests
    taskRef:
      name: apply-manifests
    workspaces:
    - name: source
      workspace: shared-workspace
    runAfter:
    - build-image
  - name: update-deployment
    taskRef:
      name: update-deployment
    params:
    - name: deployment
      value: $(params.deployment-name)
    - name: IMAGE
      value: $(params.IMAGE)
    runAfter:
    - apply-manifests
```

Veamos las diferentes tareas que se ejecutan en el pipeline:

* Clona el código fuente de la aplicación desde un repositorio git (`git-url` y `git-revision param`) usando el **ClusterTask** `git-clone`.
* Construye la imagen del contenedor de la aplicación utilizando la **ClusterTask** `buildah` que utiliza Buildah para construir la imagen.
* La imagen de la aplicación se envía a un registro de imágenes (parámetro `image`).
* La nueva imagen de la aplicación se despliega en OpenShift utilizando las tareas `apply-manifests` y `update-deployment`.

Es posible que haya notado que no hay referencias al repositorio git o el registro de imágenes que se utiliza en el pipeline. Esto se debe a que los pipelines en Tekton están diseñados para ser genéricos y reutilizables. Al activar un pipeline, puedes proporcionar diferentes repositorios git y registros de imágenes para ser utilizados durante la ejecución del pipeline. 

En concreto los parámetros que hay que proporcionar son:

* `deployment-name`: Nombre del despliegue que tiene que coincidir con el que se ha indicado como nombre del **Deployment** en el fichero yaml correspondiente en el repositorio `k8s`.
* `git-url`: URL del repositorio GitHub que queremos desplegar.
* `git-revision`: Rama del repositorio GitHub, pode defecto es `master`.
* `IMAGE`: Nombre de la imagen que vamos a construir. En nuestro caso indicaremos el registro interno de OpenShift. Recuerda que el registro interno tiene la siguiente URL, donde hay que indicar el nombre del proyecto, en mi caso: 

        `image-registry.openshift-image-registry.svc:5000/josedom24-dev`

El orden de ejecución de las tareas está determinado por las dependencias que se definen entre las tareas a través de las entradas y salidas, así como las órdenes explícitas que se definen a través de `runAfter`.

El campo `Workspaces` permite especificar uno o más volúmenes que cada **Task** en el **Pipeline** requiere durante la ejecución para intercambiar información. 

Para crear el pipeline, ejecutamos:

    oc create -f https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/04_pipeline.yaml

Y puedes ver los objetos **Pipelines** que has creado, ejecutando una de estas dos instrucciones:

    oc get pipelines
    tkn pipelines ls

Si accedemos a la sección **Pipeline** de la consola web podemos ver la lista de  **Pipelines**:

![pipeline](img/pipeline1.png)

Y si pulsamos sobre el **Pipeline** obtenemos información detallada del mismo:

![pipeline](img/pipeline2.png)

### Disparar el pipeline

Como indicado anteriormente, para que las distintas tareas del pipeline compartan información en el **Workspaces**, necesitamos asociar un volumen para que se guarde la información de manera compartida entre los distintos pods que ejecutan las tareas. Para crear el volumen vamos a usar un objeto **PersistentVolumeClaim** que esta definido en el fichero `03_persistent_volume_claim.yaml` y que tiene este [contenido](https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/03_persistent_volume_claim.yaml).

Para disparar la primera ejecución del **Pipeline** que creara el primer **PipelineRun** vamos a usar la herramienta `tk`, ejecutando la siguiente instrucción para la aplicación `backend`:

    tkn pipeline start build-and-deploy \
        -w name=shared-workspace,volumeClaimTemplateFile=https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/03_persistent_volume_claim.yaml \
        -p deployment-name=pipelines-vote-api \
        -p git-url=https://github.com/josedom24/pipelines-vote-api.git \
        -p IMAGE=image-registry.openshift-image-registry.svc:5000/josedom24-dev/pipelines-vote-api \
        --use-param-defaults

Y ejecutando la siguiente instrucción indicando el nombre del **PipelineRun** podemos ver los logs de las distintas tareas:

    tkn pipelinerun logs build-and-deploy-run-85whr -f -n josedom24-dev

De forma similar, para desplegar el `frontend`:

    tkn pipeline start build-and-deploy \
        -w name=shared-workspace,volumeClaimTemplateFile=https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/03_persistent_volume_claim.yaml \
        -p deployment-name=pipelines-vote-ui \
        -p git-url=https://github.com/josedom24/pipelines-vote-ui.git \
        -p IMAGE=image-registry.openshift-image-registry.svc:5000/josedom24-dev/pipelines-vote-ui \
        --use-param-defaults