# Almacenamiento en CRC

Al usar la instalación local de OpenShift realizada con la herramienta CRC, tenemos todo el control del clúster, y con el usuario administrador tendremos acceso a todos los recursos relacionados con el almacenamiento.

Por lo tanto, el usuario administrador podrá gestionar los recursos **PersitentVolumen** y **storageClass**, mientras que los usuarios sin privilegios gestionarán los recursos **PersistentVolumenClaim** para realizar la petición de los volúmenes. Veamos esto con un ejemplo:

        oc login -u developer -p developer https://api.crc.testing:6443'.
        oc get pv
        Error from server (Forbidden): persistentvolumes is forbidden: User "developer" cannot list resource "persistentvolumes" in API group "" at the cluster scope

        No resources found in wordpress namespace.
        oc get pv
        No resources found in...

Podemos configurar los dos tipos de aprovisionamiento:

* **Aprovisionamiento estático**: En este caso, es el administrador del cluster el responsable de ir definiendo los distintos volúmenes disponibles en el cluster creando manualmente los distintos recursos **PersistentVolumen (PV)**. Cuando un usuario sin privilegios necesita usar almacenamiento lo solicitará, creando un objeto **PersistentVolumenClaim (PVC)**. Si existe un PV que cumpla los requisitos solicitados en el PVC, el PV se asociará con el PVC (estado **bound**).
* **Aprovisionamiento dinámico**: El administrador del clúster es el responsable de configurar distintos "aprovisionadores" de almacenamiento que se definen en los objetos **StorageClass**. En este caso, cuando un desarrollador necesita almacenamiento para su aplicación, hace una petición de almacenamiento creando un recurso **PersistentVolumenClaim (PVC)** y de forma dinámica se crea el recurso **PersistentVolume** que representa el volumen y se asocia con esa petición. 

En el caso de nuestra instalación con CRC tenemos disponible un **StorageClass** de tipo `hostpath`, es decir cada volumen corresponde con un directorio en el host (al tener un sólo nodo en el clúster con este tipo de almacenamiento tenemos almacenamiento compartido entre todas las réplicas de un Pod):

        oc get storageclass
        NAME                                     PROVISIONER                        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
        crc-csi-hostpath-provisioner (default)   kubevirt.io.hostpath-provisioner   Delete          WaitForFirstConsumer   false                  36d


Podemos observar que la configuración del recurso **Storage Class** tiene los siguientes parámetros:

* Política de reciclaje `Delete`, es decir cuando el volumen se desasocie de su solicitud, se borrará.
* Modo de asociación `WaitForFirstConsumer`, es decir no se crea el objeto **PersistentVolumen (PV)** hasta que no se utilice el volumen por el contenedor.