#  Secrets

Cuando en un variable de entorno indicamos una información sensible,
como por ejemplo, una contraseña o una clave ssh, es mejor utilizar un
nuevo recurso de Kubernetes llamado Secret.

Los
[Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
permiten guardar información sensible que será **codificada** o
**cifrada**.

Hay distintos tipos de Secret, en este curso vamos a usar los
genéricos y los vamos a crear a partir de un literal. Por ejemplo para
guardar la contraseña del usuario root de una base de datos,
crearíamos un Secret de la siguiente manera:

    oc create secret generic mysql --from-literal=password=my-password

Podemos obtener información de los Secret que hemos creado con las instrucciones:

    oc get secret
    oc describe secret mysql
    ...

    Type:  Opaque

    Data
    ====
    password:  11 bytes


Si queremos crear un fichero yaml para declarar el objeto Secret, podemos ejecutar:

    oc create secret generic mysql --from-literal=password=my-password \
                              - o yaml --dry-run=client > secret.yaml

Veamos a continuación cómo quedaría un despliegue que usa el valor de
un Secret para inicializar una variable de entorno. Vamos a usar el
fichero `mysql-deployment-secret.yaml`:


```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-secret
  labels:
    app: mysql3
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql3
  template:
    metadata:
      labels:
        app: mysql3
    spec:
      containers:
        - name: contenedor-mysql
          image:  bitnami/mysql
          ports:
            - containerPort: 3306
              name: db-port
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql
                  key: password
```
Observamos como al indicar las variables de entorno (sección
`env`) seguimos indicado el nombre (`name`) pero el valor se indica
con un valor de un Secret (`valueFrom: - secretKeyRef:`), indicando el
nombre del Secret (`name`) y la clave correspondiente. (`key`).

