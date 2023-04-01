# Introducción al almacenamiento

Lo primero que hay que recordar es que **los Pods son efímeros**, es decir, cuando un Pod se elimina se pierde toda la información que tenía. Evidentemente, cuando creamos un nuevo Pod no contendrá ninguna información adicional a la propia aplicación.

es necesario usar un mecanismo que nos permita guardar la información con la que trabajan los Pods para que no se pierda en caso de que el Pod se elimine. Al sistema de almacenamiento persistente que nos ofrece Kubernetes/OpenShift lo llamamos **volúmenes**. Con el uso de dichos volúmenes vamos a conseguir varias cosas:

1. Si un Pod guarda su información en un volumen, está no se perderá. Por lo que podemos eliminar el Pod sin ningún problema y cuando volvamos a crearlo mantendrá la misma información. En definitiva, los volúmenes proporcionan almacenamiento adicional o secundario al disco que define la imagen.
2. Si usamos volúmenes, y tenemos varios Pods que están ofreciendo un servicio y se están ejecutando en nodos distintos del clúster, estos Pods tendrán la información compartida y por tanto todos podrán leer y escribir la misma información.
3. También podemos usar los volúmenes dentro de un Pod, para que los contenedores que forman parte de él puedan compartir información.

## Tipos de volúmenes 

OpenShift soporta varios tipos de almacenamiento que nos ofrecen distintas características:

* Proporcionados por proveedores de cloud: AWS Elastic Block Store (EBS), Azure, Disk, OpenStack Cinder, ...
* Propios de Kubernetes:
    * emptyDir: Volumen efímero con la misma vida que el Pod. Usado como almacenamiento secundario o para compartir entre contenedores del mismo Pod. (**Almacenamiento efímero**).
    * hostPath: Monta un directorio del host en el Pod (usado excepcionalmente, pero es el que nosotros vamos a usar con minikube).
    * ...
* Habituales en despliegues "on premises": iscsi, nfs, ...

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
|GCP PersistentDisk |	✓ |	✓ |	- |
|GCP Filestore |	✓ |	✓ |	✓ |
|HostPath |	✓ |	- |	- |
|iSCSI |	✓ |	✓ |	- |
|Local volume |	✓ |	- |	- |
|NFS |	✓ |	✓ |	✓ |
|OpenStack Manila | - | - | ✓ |
|Red Hat OpenShift Data Foundation | ✓ | - | ✓ |
|VMware vSphere | ✓ | - | ✓ |




