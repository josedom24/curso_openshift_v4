# Variables de entorno

Para añadir alguna configuración específica a la hora de lanzar un contenedor, se usan variables de entorno  del contenedor cuyos valores se especifican al crear el contenedor para realizar una configuración concreta del mismo.

Por ejemplo, si estudiamos la documentación de la imagen `bitnami/mysql` en Docker Hub](https://hub.docker.com/r/bitnami/mysql), podemos comprobar que podemos definir un conjunto de variables de entorno como `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`,
`MYSQL_PASSWORD`, etc., que nos permitirán configurar de alguna forma determinada nuestro servidor de base de datos (indicando la contraseña
del usuario root, creando una determinada base de datos o creando un usuario con una contraseña por ejemplo.

De la misma manera, al especificar los contenedores que contendrán los Pods que se van a crear desde un Deployment, también se pondrán inicializar las variables de entorno necesarias.

## Configuración de aplicaciones usando variables de entorno

Utilizaremos el fichero `mysql-deployment-env.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: contenedor-mysql
          image: bitnami/mysql
          ports:
            - containerPort: 3306
              name: db-port
          env:
            - name: MYSQL_ROOT_PASSWORD
              value: my-password
```

En el apartado `containers` hemos incluido la sección `env` donde vamos indicando, como una lista, el nombre de la variable (`name`) y
su valor (`value`). 

Vamos a trabajar con el usuario `developer`, creando un nuevo proyecto:

    oc new-project mysql

Vamos a comprobar si realmente se ha creado el servidor de base de datos con esa contraseña del root:

    oc apply -f mysql-deployment-env.yaml

    oc get all
    ...
    NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/mysql-env            1/1     1            1           5s

  Comprobamos que se ha creado una variable del entorno en el contenedor:

    oc exec -it deployment.apps/mysql-env -- env
    ...
    MYSQL_ROOT_PASSWORD=my-password

Y finalmente realizamos un acceso a la base de datos:
    
    oc exec -it deployment.apps/mysql-env -- bash -c "mysql -u root -p -h 127.0.0.1"
    Enter password:
    ...
    mysql>

