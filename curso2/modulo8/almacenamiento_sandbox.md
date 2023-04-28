# Almacenamiento en RedHat OpenShift Dedicated Developer Sandbox

Al usar RedHat OpenShift Dedicated Developer Sandbox, estamos usando un clúster compartido, multitenant, en que accedemos con un usuario sin privilegios administrativos.

* La primera consecuencia, en relación con el almacenamiento es que no tendremos acceso directo a los recursos **PersistentVolumen (PV)**.

        oc get pv
        Error from server (Forbidden): persistentvolumes is forbidden: User "josedom24" cannot list resource "persistentvolumes" in API group "" at the cluster scope

    Por la tanto, usaremos **aprovisionamiento dinámico** para obtener almacenamiento.

* Por otro lado hay que tener en cuenta que la plataforma RedHat OpenShift Dedicated Developer Sandbox está mostrada sobre una infraestructura cloud en el proveedor Amazon Web Service (AWS) por lo tanto el tipo de volúmenes que vamos  a poder usar será **AWS Elastic Block Store (EBS)**. Y tendremos a nuestra disposición 4 recursos **StorageClass** que de forma dinámica nos proporcionarán este tipo de volúmenes:

        oc get storageclass
        NAME            PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
        gp2             kubernetes.io/aws-ebs   Delete          WaitForFirstConsumer   true                   143d
        gp2-csi         ebs.csi.aws.com         Delete          WaitForFirstConsumer   true                   143d
        gp3 (default)   ebs.csi.aws.com         Delete          WaitForFirstConsumer   true                   143d
        gp3-csi         ebs.csi.aws.com         Delete          WaitForFirstConsumer   true                   143d

    En realidad son muy similares los cuatro, aunque el que está por defecto es `gp3`, que nos ofrece volúmenes EBS de tipo gp3 (para más [información sobre la diferencia entre los tipos gp2 y gp3 en AWS](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-storage-compare-volume-types.html)). Por otro lado, tenemos diferenciados **SorageClass** según el controlador de almacenamiento interno que se usa para la gestión de volúmenes: `gp3` usa el controlador de almacenamiento nativo de Kubernetes , y `gp3-sci` usa el controlador de almacenamiento CSI (Container Storage Interface), que tiene alguna más [funcionalidades](https://docs.openshift.com/container-platform/4.12/storage/container_storage_interface/persistent-storage-csi.html).

    Podemos observar que la configuración de los recursos **Storage Class** tiene los siguientes parámetros:

    * Política de reciclaje `Delete`, es decir cuando el volumen se desasocie de su solicitud, se borrará.
    * Modo de asociación `WaitForFirstConsumer`, es decir no se crea el objeto **PersistentVolumen (PV)** hasta que no se utilice el volumen por el contenedor.
