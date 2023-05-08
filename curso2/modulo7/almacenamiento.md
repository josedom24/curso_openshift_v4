# Introducción al almacenamiento en OpenShift

El uso de volúmenes en OpenShift nos proporciona la capacidad de que los Pods puedan guardar información, y que los datos de nuestras aplicaciones no se pierdan cuando un Pod se elimina.

Tenemos distintos tipos de fuentes de almacenamiento, que dependerá de la implementación del clúster de OpenShift:

* Proporcionados por proveedores de cloud: AWS Elastic Block Store (EBS), Azure, Disk, OpenStack Cinder, ...
* Propios de Kubernetes/OpenShift:
    * emptyDir: Volumen efímero con la misma vida que el Pod. Usado como almacenamiento secundario o para compartir entre contenedores del mismo Pod. (**Almacenamiento efímero**).
    * hostPath: Monta un directorio del host en el Pod.
    * ...
* Habituales en despliegues "on premises": iscsi, nfs, ...

Cada una de las fuentes de almacenamiento nos pueden dar distintas características:

* Almacenamiento que ofrece: **Filesystem**: El almacenamiento es tipo sistema de fichero; **Block**: El almacenamiento se comparte con un dispositivo de bloque. 
* Modos de acceso: **ReadWriteOnce**: read-write solo para un nodo (RWO); **ReadOnlyMany**: read-only para muchos nodos (ROX) y **ReadWriteMany**: read-write para muchos nodos (RWX).
* Políticas de reciclajes: **Retain**: El volumen no se elimina; **Recycle**: Reutilizar contenido y **Delete**: Se borra después de su utilización.

## Recursos de OpenShift para trabajar con almacenamiento

* Un **PersistentVolumen (PV)** es un objeto que representa los volúmenes disponibles en el clúster. En él se van a definir los detalles del backend de almacenamiento que vamos a utilizar, el tamaño disponible, los modos de acceso, las políticas de reciclaje, etc.
* Cuando necesitamos usar almacenamiento en nuestro despliegue crearemos un recurso **PersistentVolumenClaim (PVC)**, donde se solicita el tamaño de almacenamiento que necesitamos, modos de acceso, ...

## Tipos de aprovisionamiento

* **Aprovisionamiento estático**: En este caso, es el administrador del cluster el responsable de ir definiendo los distintos volúmenes disponibles en el cluster creando manualmente los distintos recursos **PersistentVolumen (PV)**. Cuando un desarrollador necesita usar almacenamiento lo solicitará, creando un objeto **PersistentVolumenClaim (PVC)**. Si existe un PV que cumpla los requisitos solicitados en el PVC, el PV se asociará con el PVC (estado **bound**).
* **Aprovisionamiento dinámico**: El administrador del clúster es el responsable de configurar distintos "aprovisionadores" de almacenamiento que se definen en los objetos **StorageClass**. En este caso, cuando un desarrollador necesita almacenamiento para su aplicación, hace una petición de almacenamiento creando un recurso **PersistentVolumenClaim (PVC)** y de forma dinámica se crea el recurso **PersistentVolume** que representa el volumen y se asocia con esa petición.
