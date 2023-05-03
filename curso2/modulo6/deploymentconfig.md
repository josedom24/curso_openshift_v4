# Definición de un recurso DeploymentConfig

Podemos ver la definición del recurso **DeploymentConfig** que hemos creado, ejecutando:

    oc get dc/test-web -o yaml

Si eliminamos algunas líneas que no son importantes, nos queda una definición similar a esta:

```yaml
apiVersion: apps.openshift.io/v1
kind: DeploymentConfig
metadata:
  labels:
    app: test-web
    app.kubernetes.io/component: test-web
    app.kubernetes.io/instance: test-web
  name: test-web
  namespace: test-web
spec:
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    deploymentconfig: test-web
  strategy:
    type: Rolling
  template:
    metadata:
      labels:
        deploymentconfig: test-web
    spec:
      containers:
      - image: josedom24/test_web@sha256:99db6f7fdcd6aa338d80b5cd926dff8bae50062c49f82c79a3d67d048efb13a4
        imagePullPolicy: IfNotPresent
        name: test-web
        ports:
        - containerPort: 8080
          protocol: TCP
        - containerPort: 8443
          protocol: TCP
        resources: {}
  triggers:
  - type: ConfigChange
  - imageChangeParams:
      automatic: true
      containerNames:
      - test-web
      from:
        kind: ImageStreamTag
        name: test-web:v1
        namespace: test-web
      lastTriggeredImage: josedom24/test_web@sha256:99db6f7fdcd6aa338d80b5cd926dff8bae50062c49f82c79a3d67d048efb13a4
    type: ImageChange
```

Podemos indicar algunos detalles importantes:

* La sección `metadata` define el nombre y las etiquetas para el objeto **DeploymentConfig**. 
* La sección `spec` define el recurso **ReplicationController** que se creará, donde se incluye  el número deseado de réplicas (`replicas`)(en este caso, 1), el límite de historial de revisiones (`revisionHistoryLimit`) y las etiquetas que seleccionan los Pods que se controlan (`selector`).
* La sección `template` describe la plantilla de Pod que se utilizará para crear nuevas réplicas. Como hemos creado el recurso **DeploymentConfig** con la instrucción `oc new-app` se ha creado un recurso **Image Stream** que es el que se utiliza para indicar la imagen desde la que se creará el contenedor.
* La sección `triggers` define las condiciones bajo las cuales se desencadenará una nueva implementación. En este caso, se definen dos disparadores. 
    * El primer disparador es de tipo `ConfigChange`, que provocará que se desencadene una nueva implementación si cambian alguno de los parámetros de configuración del **DeploymentConfig**. 
    * El segundo disparador es de tipo `ImageChange`, que provocará que se desencadene una nueva implementación si cambia la imagen utilizada por el contenedor. El campo `from` especifica la fuente de la nueva imagen, en este caso un **ImageStreamTag** llamado `test-web:v1`. El campo `automatic` especifica si el cambio de imagen debe detectarse automáticamente o no.


## Escalado de los Deployments

Como ocurría con los **Deployments** los **DeploymentConfig** también se pueden escalar, aumentando o disminuyendo el número de Pods asociados. Al escalar un **DeploymentConfig** estamos escalando el **ReplicationController** asociado en ese momento:

    oc scale dc/test-web --replicas=4

## Otras operaciones

Si queremos ver los logs generados en los Pods de un **DeploymentConfig**:

    oc logs dc/test-web

Si queremos obtener información detallada del recurso **DeploymentConfig** que hemos creado:

    oc describe dc/test-web

Si eliminamos el **DeploymentConfig** se eliminarán el **ReplicationController** asociado y los Pods que se estaban gestionando.

    oc delete dc/test-web

