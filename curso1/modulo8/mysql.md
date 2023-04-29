# Despliegue de la base de datos mysql

La versión del microservicio `citas-backend` obtiene la información de las citas de una tabla de una base de datos en un servidor mysql, por lo tanto lo primero será el despliegue de la base de datos.


Veamos los distintos recursos que vamos a crear para el despliegue de la base de datos:

* Un recurso ConfigMap donde guardamos el usuario (que hemos llamado `usuario`) y el nombre de la base de datos (que hemos llamado `citas`) que se van a crear.
* Un recurso Secret donde guardamos las contraseñas: la del usuario `usuario` (`usuario_pass`) y la del usuario `root` de la base de datos (`admin`).
* Un recurso VolumenPersistentClaim donde solicitamos un volumen de 5Gb para montar el directorio `/bitnami/mysql/data` del servidor mysql y por lo tanto hacerla persistente.
* Un recurso service de tipo ClusterIP para poder acceder internamente a la base de datos.
* Un recurso deployment para desplegar la base de datos.

El despliegue estará definido en el fichero `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  labels:
    app: citas
    type: database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: citas
      type: database
  template:
    metadata:
      labels:
        app: citas
        type: database
    spec:
      containers:
        - name: contenedor-mysql
          image: bitnami/mysql
          ports:
            - containerPort: 3306
              name: db-port
          env:
            - name: MYSQL_USER
              valueFrom:
                configMapKeyRef:
                  name: bd-datos
                  key: bd_user
            - name: MYSQL_DATABASE
              valueFrom:
                configMapKeyRef:
                  name: bd-datos
                  key: bd_dbname
            - name: MYSQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: bd-passwords
                  key: bd_password
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: bd-passwords
                  key: bd_rootpassword
          volumeMounts:
            - name: mysql-vol
              mountPath: /bitnami/mysql/data
      volumes:
        - name: mysql-vol
          persistentVolumeClaim:
            claimName: mysql-pvc
```

El servicio está definido en el fichero `service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app: citas
    type: database
spec:
  selector:
    app: citas
    type: database
  ports:
  - port: 3306
    targetPort: db-port
  type: ClusterIP
```

El recurso VolumenPersistentClaim lo definimos en el fichero `pvc.yaml`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    name: mysql-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```

El recurso ConfigMap está definido en el fichero `configmap.yaml`:

```yaml
apiVersion: v1
data:
  bd_dbname: citas
  bd_user: usuario
kind: ConfigMap
metadata:
  creationTimestamp: null
  name: bd-datos
```

Y por último el recurso Secret, lo encontramos en el fichero `secret.yaml`:

```yaml
apiVersion: v1
data:
  bd_password: dXN1YXJpb19wYXNz
  bd_rootpassword: YWRtaW4=
kind: Secret
metadata:
  creationTimestamp: null
  name: bd-passwords
```


Por lo tanto para realizar todo el despliegue ejecutamos:

    oc apply -f configmap.yaml 
    oc apply -f secret.yaml 
    oc apply -f pvc.yaml 
    oc apply -f deployment.yaml 
    oc apply -f service.yaml 

Vemos todos los recursos creados hasta ahora:

    oc get all,pvc
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/citas-6b98bb97f9-7p6tk      1/1     Running   0          38m
    pod/citas-6b98bb97f9-ndgdn      1/1     Running   0          38m
    pod/citas-6b98bb97f9-vr4dx      1/1     Running   0          3h30m
    pod/citasweb-7c5469486c-5slwn   1/1     Running   0          41m
    pod/mysql-5f8c89c98b-czw6k      1/1     Running   0          19s

    NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                               AGE
    service/citas               ClusterIP   172.30.140.203   <none>        10000/TCP                             3h30m
    service/citasweb            ClusterIP   172.30.184.208   <none>        5000/TCP                              41m
    service/modelmesh-serving   ClusterIP   None             <none>        8033/TCP,8008/TCP,8443/TCP,2112/TCP   12d
    service/mysql               ClusterIP   172.30.223.174   <none>        3306/TCP                              18s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/citas      3/3     3            3           3h30m
    deployment.apps/citasweb   1/1     1            1           41m
    deployment.apps/mysql      1/1     1            1           19s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/citas-6b98bb97f9      3         3         3       3h30m
    replicaset.apps/citasweb-7c5469486c   1         1         1       41m
    replicaset.apps/mysql-5f8c89c98b      1         1         1       20s

    NAME                                HOST/PORT                                                          PATH   SERVICES   PORT       TERMINATION   WILDCARD
    route.route.openshift.io/citasweb   citasweb-josedom24-dev.apps.sandbox-m3.1530.p1.openshiftapps.com          citasweb   5000-tcp                 None

    NAME                              STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
    persistentvolumeclaim/mysql-pvc   Bound    pvc-c8bd6778-c60e-4411-b595-1f82849379de   5Gi        RWO            gp3            21s


A continuación nos queda inicializar la base de datos, para ello vamos a copiar el fichero `citas.sql` al pod. Para facilitar el copiado de ficheros vamos a guardar el nombre del pod en una variable de entorno:

    export PODNAME="mysql-5f8c89c98b-czw6k"


En el fichero `citas.sql` tenemos las instrucciones para crear la tabla con los registros que necesitamos:

```sql
use citas;
CREATE TABLE quotes (
	Id int AUTO_INCREMENT NOT NULL,
	quotation varchar(255) NULL,
	author varchar(50) NULL,
	PRIMARY KEY ( Id )
);
INSERT INTO `quotes` VALUES
(1,'Yeah, well, that\'s just like, your opinion, man.','The Dude'),
(2,'It is not only what you do but also the attitude you bring to it, that makes you a success.','Don Schenck'),
(3,'Knowledge is power.','Sir Francis Bacon'),
(4,'Life is really simple, but we insist on making it complicated.','Confucius'),
(5,'This above all: To thine own self be true.','William Shakespeare'),
(6,'I got a fever, and the only prescription is more cowbell.','Will Ferrell'),
(7,'Anyone who has ever made anything of importance was disciplined.','Andrew Hendrixson'),
(8,'Strive not to be a success, but rather to be of value.','Albert Einstein'),
(9,'The greatest glory in living lies not in never falling, but in rising every time we fall.','Nelson Mandela'),
(10,'The way to get started is to quit talking and begin doing.','Walt Disney'),
(11,'Your time is limited so don\'t waste it living someone else\'s life. Don\'t be trapped by dogma – which is living with the results of other people\'s thinking.','Steve Jobs'),
(12,'If life were predictable it would cease to be life, and be without flavor.','Eleanor Roosevelt'),
(13,'If you look at what you have in life you\'ll always have more. If you look at what you don\'t have in life you\'ll never have enough.','Oprah Winfrey'),
(14,'If you set your goals ridiculously high, and it\'s a failure, you will fail above everyone else\'s success.','James Cameron'),
(15,'Life is what happens when you\'re busy making other plans.','John Lennon'),
(16,'The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.','Helen Keller');
```

A continuación copiamos el fichero:

    oc cp citas.sql $PODNAME:/tmp/


Y finalmente ejecutamos el fichero sql:

    oc exec deploy/mysql -- bash -c "mysql -uroot -padmin < /tmp/citas.sql"

finalmente comprobamos que hemos guardado las citas en la tabla `quotes`:

    oc exec -it deploy/mysql -- bash -c "mysql -u root -padmin -h 127.0.0.1 citas"
    ...
    mysql> select * from quotes;
    +----+---------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------+
    | Id | quotation                                                                                                                                                     | author              |
    +----+---------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------+
    |  1 | Yeah, well, that's just like, your opinion, man.                                                                                                              | The Dude            |
    |  2 | It is not only what you do but also the attitude you bring to it, that makes you a success.                                                                   | Don Schenck         |
    ...