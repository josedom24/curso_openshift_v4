# Definición de un recurso DeploymentConfig

Podemos ver la definción del recurso **DeploymentConfig** que hemos creado, ejecutando:

    oc get dc/test-web -o yaml

Podemos indicar algunos detalles importantes:

* La sección `metadata` define el nombre y las etiquetas para el objeto **DeploymentConfig**. 
* La sección `spec` define el recurso **ReplicationController** que se creará, donde se incluye  el número deseado de réplicas (`replicas`)(en este caso, 1), el límite de historial de revisiones (`revisionHistoryLimit`) y las etiquetas que seleccionan los pods que se controlan (`selector`).
* La sección `template` describe la plantilla de pod que se utilizará para crear nuevas réplicas. Como hemos creado el recurso **DeploymentConfig** con la instrucción `oc new-app` se ha creado un recurso **Image Stream** que es el que se utiliza para indicar la imagen desde la que se creará el contenedor.
* La sección `triggers` define las condiciones bajo las cuales se desencadenará una nueva implementación. En este caso, se definen dos disparadores. 
    * El primer disparador es un disparador de `ConfigChange`, que provocará que se desencadene una nueva implementación si cambian alguno de los parámetros de configuración del **DeploymentConfig**. 
    * El segundo disparador es un disparador de `ImageChange`, que provocará que se desencadene una nueva implementación si cambia la imagen Docker utilizada por el contenedor. El campo `from` especifica la fuente de la nueva imagen, en este caso un **ImageStreamTag** llamado "nginx:latest". El campo `automatic` especifica si el cambio de imagen debe detectarse automáticamente o no.

