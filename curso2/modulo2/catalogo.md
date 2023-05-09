# Despliegue de aplicaciones desde el catálogo con oc

En los apartados anteriores hemos usado distintas **Builder Images** para construir nuevas imágenes que queremos desplegar. Las **Builder Images** la encontramos almacenadas en el **catálogo de aplicaciones** de OpenShift. Además, en el catálogo encontramos otros elementos, por ejemplo, los **Templates** que nos permiten crear un conjunto de recursos en OpenShift de manera sencilla.

## Despliegue de Templates en OpenShift

Los **Templates** que nos ofrece OpenShift y que están guardados en el **catálogo de aplicaciones**, lo podemos encontrar en el proyecto `openshift`, para listar los que tenemos a nuestra disposición:

    oc get templates -n openshift

Por ejemplo, vamos a desplegar una base de datos mariadb sin almacenamiento persistente, por lo tanto, vamos a usar el **Template** `mariadb-ephemeral`.

Los **Templates** tienen definidos una serie de parámetros que podemos utilizar para configurar el despliegue. Al instanciar un **Template** algunos parámetros hay que indicarlos de forma obligatoria, y otros, si no se ponen, se inicializan con valores por defecto.

Para ver todas las características de un **Template**, incluso los parámetros podemos ejecutar:

    oc describe template mariadb-ephemeral -n openshift

Si queremos ver en particular los parámetros, ejecutamos:

	oc process --parameters mariadb-ephemeral -n openshift

    NAME                    DESCRIPTION                                                               GENERATOR           VALUE
    MEMORY_LIMIT            Maximum amount of memory the container can use.                                               512Mi
    NAMESPACE               The OpenShift Namespace where the ImageStream resides.                                        openshift
    DATABASE_SERVICE_NAME   The name of the OpenShift Service exposed for the database.                                   mariadb
    MYSQL_USER              Username for MariaDB user that will be used for accessing the database.   expression          user[A-Z0-9]{3}
    MYSQL_PASSWORD          Password for the MariaDB connection user.                                 expression          [a-zA-Z0-9]{16}
    MYSQL_ROOT_PASSWORD     Password for the MariaDB root user.                                       expression          [a-zA-Z0-9]{16}
    MYSQL_DATABASE          Name of the MariaDB database accessed.                                                        sampledb
    MARIADB_VERSION         Version of MariaDB image to be used (10.3-el7, 10.3-el8, or latest).                          10.3-el8

Donde observamos el valor de los parámetros, su descripción y su valor por defecto, si no se indican.

Para crear la aplicación desde el **Template** ejecutamos:

	oc new-app mariadb-ephemeral -p MYSQL_USER=jose -p MYSQL_PASSWORD=asdasd -p MYSQL_ROOT_PASSWORD=asdasd -p MYSQL_DATABASE=blog

    --> Deploying template "josedom24-dev/mariadb-ephemeral" to project josedom24-dev
    ...
    
         The following service(s) have been created in your project: mariadb.
         
                Username: jose
                Password: asdasd
           Database Name: blog
          Connection URL: mysql://mariadb:3306/
         
       ...

         * With parameters:
            * Memory Limit=512Mi
            * Namespace=openshift
            * Database Service Name=mariadb
            * MariaDB Connection Username=jose
            * MariaDB Connection Password=asdasd
            * MariaDB root Password=asdasd
            * MariaDB Database Name=blog
            * Version of MariaDB Image=10.3-el8
    
    --> Creating resources ...
        secret "mariadb" created
        service "mariadb" created
        deploymentconfig.apps.openshift.io "mariadb" created
    ...

Como vemos se han creado tres recursos: un **Secret**, un **Service** y un **DeploymentConfig**, con los valores de configuración que hemos indicado:

    oc get secret,service,dc,rc,pod
    NAME                              TYPE                                  DATA   AGE
    ...
    secret/mariadb                    Opaque                                4      2m19s

    NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                               AGE
    service/mariadb             ClusterIP   172.30.112.15   <none>        3306/TCP                              2m19s
    service/modelmesh-serving   ClusterIP   None            <none>        8033/TCP,8008/TCP,8443/TCP,2112/TCP   68m

    NAME                                         REVISION   DESIRED   CURRENT   TRIGGERED BY
    deploymentconfig.apps.openshift.io/mariadb   1          1         1         config,image(mariadb:10.3-el8)

    NAME                              DESIRED   CURRENT   READY   AGE
    replicationcontroller/mariadb-1   1         1         1       2m18s

    NAME                   READY   STATUS      RESTARTS   AGE
    pod/mariadb-1-deploy   0/1     Completed   0          2m18s
    pod/mariadb-1-pb49r    1/1     Running     0          2m17s

Vamos a comprobar que podemos acceder a la base de datos:

    oc exec pod/mariadb-1-pb49r -it pod/mariadb-1-pb49r -- mysql -u jose -pasdasd -h mariadb blog
    ...
    MariaDB [blog]> 
