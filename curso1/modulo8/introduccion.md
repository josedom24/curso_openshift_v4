# Otros recursos para manejar nuestras aplicaciones

En este apartado vamos a poner un ejemplo de distintos recursos que podemos usar en nuestro clúster de OpenShift. Vamos a estudiar los recursos que son comunes a Kubernetes y OpenShift, dejando para el próximo curso los recursos propios de OpenShift para desplegar aplicaciones.

## StatefulSet

Una característica de una aplicación que es muy importante para su despliegue en OpenShift es si se trata de una aplicación con estado (**stateful**) o sin estado (**stateless**). 

* Una **aplicación sin estado** es aquella en la que las peticiones son totalmente independientes unas de otras y no necesita ninguna referencia de una petición anterior. 
* Por contra, las **aplicaciones con estado** son aquellas en las que una petición puede verse afectada por el resultado de las anteriores y a su vez puede afectar a las posteriores (por eso se dice que tiene estado). 

Mientras los recursos **Deployments** nos permite el despliegue de aplicaciones sin estado, los recursos StatefulSet en Kubernetes están diseñados para manejar aplicaciones con estado. Para ello este recurso nos ofrece algunas características:

* Los StatefulSets permiten que **cada Pod tenga un nombre y un estado únicos y estables** en todo momento. Tienen un **identificado de red estable** (nombre DNS), por ejemplo un clúster de servidores mongodb necesitan tener una identidad de red persistente.
* Nos ofrece **almacenamiento persistente**, es decir, a cada Pod se le asocia un volumen de almacenamiento persistente. Si el Pod falla y debe ser recreado en otro nodo, el nuevo Pod aún puede acceder al mismo volumen de almacenamiento persistente que el Pod anterior. Por ejemplo, un clúster de Zookeeper, cada nodo necesita almacenamiento único y estable, ya que el identificador de cada nodo se guarda en un fichero.
También nos proporciona **un orden determinado para la creación y eliminación de Pods**, lo que es importante en aplicaciones que dependen del orden de los eventos o que deben ser inicializadas en un orden específico, por ejemplo en un clúster de redis **necesita que el master esté corriendo antes de que podamos configurar las réplicas.**.

## DaemonSet

El objeto **DaemonSet** nos asegura que en todos (o en algunos) nodos de nuestro cluster vamos a tener un Pod ejecutándose. Si añadimos nuevos
nodos al clúster se crearán nuevo Pods. Para que podemos necesitar esta característica:
* Monitorización del cluster (Prometheus)
* Recolección y gestión de logs (fluentd)
* Cluster de almacenamiento (glusterd o ceph)

## Jobs y cronJobs

El recurso **Job** nos permite ejecutar una acción y asegurarse que se finaliza correctamente. Por ejemplo: rellenar una base de datos, descargar datos,...). Un **Job** crea uno o más Pods y se asegura que un número determinado de ellos ha terminado de forma adecuada.
Si necesita que un **Job** se repita periódicamente usamos un cronJob, por ejemplo para hacer backup de base de datos, ...

## Horizontal Pod AutoScaler

El recurso **Horizontal Pod AutoScaler** nos permite variar el número de Pods desplegados mediante un deployment en función de diferentes métricas: por ejemplo el uso de la CPU o la memoria.

## PodDisruptionBudgets

El recurso **PodDisruptionBudgets** (PDB) se utiliza para garantizar la disponibilidad y la y la continuidad del servicio ofrecida por los servicios de las aplicaciones que se ejecutan en un clúster de Kubernetes o OpenShift.

En esencia, un PDB es un objeto que limita el número de Pods de una aplicación que se pueden eliminar simultáneamente del clúster. Esto es importante porque la eliminación simultánea de múltiples Pods de una aplicación puede provocar interrupciones en el servicio o, peor aún, la pérdida total del servicio.

Un PDB se define para un conjunto de réplicas de un deployment, un statefulset o un daemonset y establece un mínimo de Pods disponibles (disruption-minimum) que deben permanecer en funcionamiento durante un proceso de actualización, reemplazo o eliminación. Si al realizar una actualización del clúster, se determina que la acción violaría el PDB, la acción se pospone hasta que se pueda garantizar la disponibilidad del número mínimo de Pods especificados.


