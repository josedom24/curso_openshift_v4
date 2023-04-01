# Introducción al almacenamiento

Lo primero que hay que recordar es que **los Pods son efímeros**, es decir, cuando un Pod se elimina se pierde toda la información que tenía. Evidentemente, cuando creamos un nuevo Pod no contendrá ninguna información adicional a la propia aplicación.

es necesario usar un mecanismo que nos permita guardar la información con la que trabajan los Pods para que no se pierda en caso de que el Pod se elimine. Al sistema de almacenamiento persistente que nos ofrece Kubernetes/OpenShift lo llamamos **volúmenes**. Con el uso de dichos volúmenes vamos a conseguir varias cosas:

1. Si un Pod guarda su información en un volumen, está no se perderá. Por lo que podemos eliminar el Pod sin ningún problema y cuando volvamos a crearlo mantendrá la misma información. En definitiva, los volúmenes proporcionan almacenamiento adicional o secundario al disco que define la imagen.
2. Si usamos volúmenes, y tenemos varios Pods que están ofreciendo un servicio y se están ejecutando en nodos distintos del clúster, estos Pods tendrán la información compartida y por tanto todos podrán leer y escribir la misma información.
3. También podemos usar los volúmenes dentro de un Pod, para que los contenedores que forman parte de él puedan compartir información.

## Fuente de almacenamiento 

OpenShift soporta varios tipos de almacenamiento que nos ofrecen distintas características:

* Proporcionados por proveedores de cloud: AWS Elastic Block Store (EBS), Azure, Disk, OpenStack Cinder, ...
* Propios de Kubernetes:
    * emptyDir: Volumen efímero con la misma vida que el Pod. Usado como almacenamiento secundario o para compartir entre contenedores del mismo Pod. (**Almacenamiento efímero**).
    * hostPath: Monta un directorio del host en el Pod (usado excepcionalmente, pero es el que nosotros vamos a usar con minikube).
    * ...
* Habituales en despliegues "on premises": iscsi, nfs, ...

## Tipos de almacenamiento

Según como usemos el almacenamiento en el contenedor, tendremos dos tipos:

* **Filesystem**: El almacenamiento es tipo sistema de fichero, con lo que podremos montar un directorio compartido.
* **Block**: El almacenamiento se comparte con un dispositivo de bloque. El contenedor verá el almacenamiento como un nuevo disco. 

## Modos de acceso

Tenemos tres modos de acceso, que dependen del backend que vamos a utilizar:

* ReadWriteOnce: read-write solo para un nodo (RWO)
* ReadOnlyMany: read-only para muchos nodos (ROX)
* ReadWriteMany: read-write para muchos nodos (RWX)

## Políticas de reciclajes

Las políticas de reciclaje de volúmenes también dependen del backend y son:

* Retain: El PV no se elimina, aunque el PVC se elimine. El administrador debe borrar el contenido para la próxima asociación.
* Recycle: Reutilizar contenido. Se elimina el contenido y el volumen es de nuevo utilizable.
* Delete: Se borra después de su utilización.

## Resumen de tipo de almacenamiento

|Plugin |ReadWriteOnce |ReadOnlyMany| ReadWriteMany|
|:---:|:---:|:---:|:---:|
|AWS EBS| ✓ | - | - |
|Azure File|	✓ |	✓ |	✓ |
|Azure Disk|	✓ | - |	- |
|Cinder |	✓ |	- |	-|
|Fibre Channel | ✓ | ✓ | - |
|GCP PersistentDisk |	✓ |	- |	- |
|GCP Filestore |	✓ |	✓ |	✓ |
|HostPath |	✓ |	- |	- |
|iSCSI |	✓ |	✓ |	- |
|Local volume |	✓ |	- |	- |
|NFS |	✓ |	✓ |	✓ |
|OpenStack Manila | - | - | ✓ |
|Red Hat OpenShift Data Foundation | ✓ | - | ✓ |
|VMware vSphere | ✓ | - | ✓ |

## Recursos de openshift para trabajar con almacenamiento

* Un **PersistentVolumen (PV)** es un objeto que representa los volúmenes disponibles en el cluster. En él se van a definir los detalles del backend de almacenamiento que vamos a utilizar, el tamaño disponible, los modos de acceso, las políticas de reciclaje, etc.
* Cuando necesitamos usar almacenamiento en nuestro despliegue crearemos un recurso **PersistentVolumenClaim (PVC)**, donde se solicita el tamaño de almacenamiento que necesitamos, modos de acceso, ...

## Tipos de aprovisionamiento

* **Aprovisionamiento estático**: En este caso, es el administrador del cluster el responsable de ir definiendo los distintos volúmenes disponibles en el cluster creando manualmente los distintos recursos **PersistentVolumen (PV)**. Cuando un desarrollador necesita usar almacenamiento lo solicitará, creando un objeto **PersistentVolumenClaim (PVC)**. Si existe un PV que cumpla los requisitos solicitados en el PVC, el PV se asociará con el PVC (estado **bound**).
* **Aprovisionamiento dinámico**: El administrador del clúster es el responsable de configurar distintos "aprovisionadores" de almacenamiento que se definen en los objetos **StorageClass**. En este caso, cuando un desarrollador necesita almacenamiento para su aplicación, hace una petición de almacenamiento creando un recurso **PersistentVolumenClaim (PVC)** y de forma dinámica se crea el recurso **PersistentVolume** que representa el volumen y se asocia con esa petición. 




