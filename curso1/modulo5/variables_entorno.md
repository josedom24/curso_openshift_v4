# Variables de entorno

Para añadir alguna configuración específica a la hora de lanzar un
contenedor, se usan variables de entorno  del contenedor
cuyos valores se especifican al crear el contenedor para realizar una configuración concreta del mismo.

Por ejemplo, si estudiamos la documentación de la imagen `mysql` en
[Docker Hub](https://hub.docker.com/_/mysql), podemos comprobar que
podemos definir un conjunto de variables de entorno como
`MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`,
`MYSQL_PASSWORD`, etc., que nos permitirán configurar de alguna forma
determinada nuestro servidor de base de datos (indicando la contraseña
del usuario root, creando una determinada base de datos o creando un
usuario con una contraseña por ejemplo.

De la misma manera, al especificar los contenedores que contendrán los
Pods que se van a crear desde un Deployment, también se pondrán
inicializar las variables de entorno necesarias.

## Configuración de aplicaciones usando variables de entorno

Vamos a hacer un despliegue de un servidor de base de datos
mysql. Vamos a usar la imagen `registry.redhat.io/rhscl/mysql-57-rhel7` para que funcione de manera adecuada en OpenShift, aunque se siguen utilizando las mismas variables que hemos estudiado anteriormente (Para [más información](https://docs.openshift.com/online/pro/using_images/db_images/mysql.html)). Utilizaremos el fichero `mysql-deployment-env.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  labels:
    app: mysql
    type: database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
        type: database
    spec:
      containers:
        - name: contenedor-mysql
          image:  registry.redhat.io/rhscl/mysql-57-rhel7
          ports:
            - containerPort: 3306
              name: db-port
          env:
            - name: MYSQL_ROOT_PASSWORD
              value: my-password
```

En el apartado `containers` hemos incluido la sección `env` donde
vamos indicando, como una lista, el nombre de la variable (`name`) y
su valor (`value`). 

Vamos a comprobar si realmente se ha creado el servidor de base de
datos con esa contraseña del root:

    oc apply -f mysql-deploymen-env.yaml

    oc get all
    ...
    NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/mysql                1/1     1            1           5s

  Comprobamos que se ha creado una variable del entorno en el contenedor:

    oc exec -it deployment.apps/mysql -- env
    ...
    MYSQL_ROOT_PASSWORD=my-password

Y finalmente realizamos un acceso a la base de datos:
    
    oc exec -it deployment.apps/mysql -- bash -c "mysql -u root -p -h 127.0.0.1"
    Enter password:
    ...
    mysql>

