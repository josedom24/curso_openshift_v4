# Recursos que nos ofrece OpenShift para desplegar aplicaciones

## Pods

**La unidad mínima de ejecución en OpenShift es el Pod**. De forma genérica, un Pod representa un conjunto de contenedores que comparten almacenamiento y una única IP. Al ejecutar un Pod, se ejecutan uno o varios contenedores, según las necesidades:

* En la mayoría de los casos y siguiendo el principio de un proceso por contenedor, un pod ejecutará un contenedor que ejecuta un sólo proceso.
* En determinadas circunstancias será necesario ejecutar más de un proceso en el mismo "sistema", como en los casos de procesos
  fuertemente acoplados, en esos casos, tendremos más de un   contenedor dentro del Pod. Cada uno de los contenedores ejecutando
  un solo proceso, pero pudiendo compartir almacenamiento y una misma dirección IP como si se tratase de un sistema ejecutando múltiples
  procesos. Ejemplo: servidor web nginx con un servidor de aplicaciones PHP-FPM.

Un aspecto muy importante que hay que ir asumiendo es que los Pods son **efímeros**, se lanzan y en determinadas circunstancias se paran o se destruyen, creando en muchos casos nuevos Pods que sustituyan a los anteriores. Esto tiene importantes ventajas a la hora de realizar modificaciones en los despliegues en producción, pero tiene una consecuencia directa sobre la información que pueda tener almacenada el Pod, por lo que tendremos que utilizar algún mecanismo adicional cuando necesitemos que la información sobreviva a un Pod.

## ReplicaSet

**ReplicaSet** es un recurso de Kubernetes que asegura que siempre se ejecuta un número de réplicas concreto de un Pod determinado. Por lo tanto, nos garantiza que un conjunto de Pods siempre están funcionando y disponibles.

Un recurso ReplicaSet controla un conjunto de Pods y es el responsable de que estos Pods siempre estén ejecutándose (**Tolerancia a fallos**) y de aumentar o disminuir las réplicas de dicho Pod (**Escalabilidad dinámica**). Estas réplicas de los Pods se ejecutarán en nodos distintos del clúster.

El ReplicaSet va a hacer todo lo posible para que el conjunto    de Pods que controla siempre se estén ejecutando. Por ejemplo: si el nodo del cluster donde se están ejecutando una serie de Pods se apaga, el ReplicaSet crearía nuevos Pods en otro nodo para tener siempre ejecutando el número que hemos indicado. Si un Pod se para por cualquier problema, el ReplicaSet intentará que vuelva a ejecutarse  para que siempre tengamos el número de Pods deseado.

## Deployment

El despliegue o **Deployment** es la unidad de más alto nivel que podemos gestionar en OpenShift.

¿Qué ocurre cuando creamos un nuevo recurso Deployment?

* La creación de un Deployment conlleva la creación de un ReplicaSet que controlará un conjunto de Pods creados a partir de la versión de la imagen que se ha indicado.
* Si hemos desarrollado una nueva versión de la aplicación y hemos creado una nueva imagen con la nueva versión, podemos modificar el Deployment indicando la nueva versión de la imagen. En ese momento se creará un nuevo ReplicaSet que controlará un nuevo conjunto de Pods creados a partir de la nueva versión de la imagen (habremos desplegado una nueva versión de la aplicación).
* Por lo tanto podemos decir que un Deployment va guardando un historial con los ReplicaSet que se van creando al ir cambiado la versión de la imagen. El ReplicaSet que esté activo en un determinado momento será el responsable de crear los Pods con la versión actual de la aplicación.
* Si tenemos un historial de ReplicaSet según las distintas versiones de la imagen que estamos utilizando, podemos, de una manera sencilla, volver a una versión anterior de la aplicación (**Rollback**).

Por la manera de trabajar de un Deployment, podemos indicar las funciones que nos aporta:

* Control de réplicas
* Escalabilidad de pods
* Actualizaciones continuas
* Despliegues automáticos
* Rollback a versiones anteriores

## Otros recursos para el despliegue de aplicaciones

* OpenShift nos permite desplegar aplicaciones con dos recursos propios: **DeploymentConfig** y **Deployment Serverless**. Estos recursos no lo estudiaremos en este curso.
* Además para desplegar aplicaciones que requieren de otras características veremos más adelante el uso de recursos como el **StatefulSet**, **DaemonSet**, **Job**,...

