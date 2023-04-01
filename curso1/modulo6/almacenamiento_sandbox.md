# Almacenamiento en RedHat OpenShift Dedicated Developer Sandbox

Como hemos indicado anteriormente al usar RedHat OpenShift Dedicated Developer Sandbox, estamos usando un clúster compartido, multitenant, en que accedemos con un usuario sin privilegios administrativos.

* La primera consecuencia, en relación con el almacenamiento es que no tendremos acceso directo a los recursos **PersistentVolumen (PV)**.

    oc get pv
    Error from server (Forbidden): persistentvolumes is forbidden: User "josedom24" cannot list resource "persistentvolumes" in API group "" at the cluster scope

* 

