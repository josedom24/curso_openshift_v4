# Gestión de OpenShift Pipeline desde el terminal

## Disparar el pipeline

Como hemos indicado anteriormente, para que las distintas tareas del pipeline compartan información en el **Workspaces**, necesitamos asociar un volumen para que se guarde la información de manera compartida entre los distintos Pods que ejecutan las tareas. Para crear el volumen vamos a usar un objeto **PersistentVolumeClaim** que esta definido en el fichero `03_persistent_volume_claim.yaml` y que tiene este [contenido](https://raw.githubusercontent.com/josedom24/pipelines-tutorial/master/01_pipeline/03_persistent_volume_claim.yaml).

Para disparar la primera ejecución del **Pipeline** que creará el primer **PipelineRun** vamos a usar la herramienta `tk`, ejecutando la siguiente instrucción para la aplicación `backend`:

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

Vemos el **Pipeline** que hemos creado:

    tkn pipeline list
    NAME               AGE           LAST RUN                     STARTED        DURATION   STATUS
    build-and-deploy   2 hours ago   build-and-deploy-run-4hkdh   1 minute ago   ---        Running


Si queremos ver las ejecuciones que se han realizado, es decir los objetos **PipelineRun**:

    tkn pipelinerun list
    NAME                            STARTED          DURATION   STATUS
    build-and-deploy-run-4rp64      27 seconds ago   ---        Running
    build-and-deploy-run-4hkdh      3 minutes ago    2m10s      Succeeded

Y sus logs, lo podemos ver:

    tkn pipeline logs -f
    ? Select pipelinerun:  [Use arrows to move, type to filter]
    > build-and-deploy-run-4rp64 started 1 minute ago
      build-and-deploy-run-4hkdh started 4 minutes ago

Podemos ver los recursos que hemos creado:

![pipeline](img/pipeline3.png)

Y si accedemos a la aplicación, vemos que está funcionando:

![pipeline](img/pipeline4.png)

Si haces algún cambio en las aplicaciones y quieres volver a lanzar el despliegue, tendrías que ejecutar:

    tkn pipeline start build-and-deploy --last
