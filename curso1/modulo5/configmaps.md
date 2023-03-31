# ConfigMaps

En el apartado anterior hemos estudiado como podemos definir las
variables de entorno de los contenedores que vamos a desplegar. Sin
embargo, la solución que presentamos puede tener alguna limitación:

* Los valores de las variables de entorno están escritos directamente
  en el fichero yaml. Estos ficheros yaml suelen estar en repositorios
  git y lógicamente no es el sitio más adecuado para ubicarlos.
* Por otro lado, escribiendo los valores de las variables de entorno
  directamente en los ficheros, hacemos que estos ficheros no sean
  reutilizables en otros despliegues y que el procedimiento de cambiar
  las variables sea tedioso y propenso a errores, porque hay que
  hacerlo en varios sitios.

Para solucionar estas limitaciones, podemos usar un nuevo recurso de
Kubernetes llamado ConfigMap.

## Configuración de aplicaciones usando ConfigMaps

[ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)
permite definir un diccionario (clave,valor) para guardar información
que se puede utilizar para configurar una aplicación.

Aunque hay distintas formas de indicar el conjunto de claves-valor de
nuestro ConfigMap, en este caso vamos a usar literales, por ejemplo:

    oc create cm mysql --from-literal=root_password=my-password \
                              --from-literal=mysql_usuario=usuario     \
                              --from-literal=mysql_password=password-user \
                              --from-literal=basededatos=test

En el ejemplo anterior, hemos creado un ConfigMap llamado `mysql`
con cuatro pares clave-valor. Para ver los ConfigMap que tenemos
creados, podemos utilizar:

    oc get cm

Y para ver los detalles del mismo:

    oc describe cm mariadb

Si queremos crear un fichero yaml para declarar el objeto ConfigMap, podemos ejecutar:

    oc create cm mysql --from-literal=root_password=my-password \
                              --from-literal=mysql_usuario=usuario     \
                              --from-literal=mysql_password=password-user \
                              --from-literal=basededatos=test \
                              - o yaml --dry-run=client > configmap.yaml

  
Una vez que creado el ConfigMap se puede crear un despliegue donde las
variables de entorno se inicializan con los valores guardados en
el ConfigMap. Por ejemplo, un despliegue de una base de datos lo
podemos encontrar en el fichero
`mysql-deployment-configmap.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql2
  labels:
    app: mysql
    type: database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql2
  template:
    metadata:
      labels:
        app: mysql2
        type: database
    spec:
      containers:
        - name: contenedor-mysql
          image: registry.redhat.io/rhscl/mysql-57-rhel7
          ports:
            - containerPort: 3306
              name: db-port
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: mysql
                  key: root_password
            - name: MYSQL_USER
              valueFrom:
                configMapKeyRef:
                  name: mysql
                  key: mysql_usuario
            - name: MYSQL_PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: mysql
                  key: mysql_password
            - name: MYSQL_DATABASE
              valueFrom:
                configMapKeyRef:
                  name: mysql
                  key: basededatos
```

Observamos como al indicar las variables de entorno (sección
`env`) seguimos indicado el nombre (`name`) pero el valor se indica
con una clave de un ConfigMap (`valueFrom: - configMapKeyRef:`), para
ello se indica el nombre del ConfigMap (`name`) y el valor que tiene
una determinada clave (`key`). De esta manera, no guardamos en los
ficheros yaml los valores específicos de las variables de entorno, y
además, estos valores se pueden reutilizar para otros despliegues, por
ejemplo, al desplegar un CMS indicar los mismos valores para las
credenciales de acceso a la base de datos.

Creamos el despliegue, comprobamos que las variables se han creado y accedemos a la base de datos con el usuario que hemos creado:

    oc apply -f mysql-deployment-configmap.yaml

    oc exec -it deplo/mysql2 -- env
    ...
    MYSQL_ROOT_PASSWORD=my-password
    MYSQL_USER=usuario
    MYSQL_PASSWORD=password-user
    MYSQL_DATABASE=test

    oc exec -it deployment.apps/mysql2 -- bash -c "mysql -u usuario -p -h 127.0.0.1"
    Enter password: 
    ...
    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | test               |
    +--------------------+


    