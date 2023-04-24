# Descripción de un objeto Template

Vamos a crear un objeto **Template** desde su definición en un fichero yaml. En este ejmplo vamos a hacer un **Template** muy sencillo, que sólo va a crear un objeto de tipo pod. Nos va a permitir crear pods desde la imagen `bitnami/mysql` y como veremos posteriormente hemos creados varios parámetros para permitir su configuración. Partimos del fichero `mysql-plantilla.yaml` con el siguiente contenido:

```yaml
apiVersion: template.openshift.io/v1
kind: Template
labels:
  app: deployment-mysql
metadata:
  name: mysql-plantilla
  annotations:
    description: "Plantilla para desplegar un deployment de mysql"
    iconClass: "icon-mysql-database"
    tags: "database,mysql"
objects:
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: ${NOMBRE_APP}
  spec:
    replicas: ${{REPLICAS}}
    selector:
      matchLabels:
        app: mysql
    template:
      metadata:
        labels:
          app: mysql
      spec:
        containers:
          - name: ${NOMBRE_CONTENEDOR}
            image: bitnami/mysql  
            env:
            - name: MYSQL_ROOT_PASSWORD
              value: ${ROOT_PASSWORD}
            - name: MYSQL_USER
              value: ${USER}
            - name: MYSQL_PASSWORD
              value: ${PASSWORD}
            - name: MYSQL_DATABASE
              value: ${DATABASE}
            ports:
            - containerPort: 6379
              protocol: TCP
parameters:
- name: REPLICAS
  description: Número de pods creados
  value: "1"
- name: NOMBRE_APP
  description: Nombre del pod que se va a crear
  from: 'mysql[0-9]{2}'
  generate: expression
- name: NOMBRE_CONTENEDOR
  description: Nombre del contenedor que se va a crear
  value: contenedor-mysql
- name: ROOT_PASSWORD
  description: Contraseña del root de mysql
  from: '[A-Z0-9]{8}'
  generate: expression
- name: USER
  description: Nombre del usuario mysql que se va acrear
  value: usuario
- name: PASSWORD
  description: Contraseña del usuario de mysql
  from: '[A-Z0-9]{8}'
  generate: expression
- name: DATABASE
  description: Nombre de la base de datos que se va a crear
  value: nueva_bd
```

Veamos cada uno de los apartados que tiene la configuración:

* `labels`: Indicamos las etiquetas que tendrán todos los objetos que vamos aa crear.
* `metadata`: Tiene las secciones que normalmente tiene esta sección en la definición de cualquier objeto. En este caso nos vamos a ficjar en las anotaciones (`annotations`):
    * `description`: Definimos una descripción de lo que hace la plantilla.
    * `iconClass`: Indicamos el icono que se mostrará en el catálogo de aplicaciones. [Más iconos](https://rawgit.com/openshift/openshift-logos-icon/master/demo.html).
    * `tags`: Etiquetas asignadas a la plantilla, que facilita su búsqueda en el catálogo.
    * Hay más posibles anotaciones que puedes estudiar en la [documentación](https://docs.openshift.com/container-platform/4.12/openshift_images/using-templates.html).
* `objects`: Define la definición de los objetos que va a crear la plantilla.
* `parameters`: Define los parámetros que hemos indicado en la definición de los objetos. A la hora de instanciar la plantilla estos parámetros se pueden sobreescribir. Algunos de los atributos que podemos poner de cada parámetro:
    * `name`: Nombre del parámetro.
    * `description`: descripción del parámetro.
    * `value`: Valor por defecto. Si no indico el parámetro al crear los objetos del **Template** tomará el valor por defecto.
    * `from`: Expresión regular que se usa para generar un valor aleatorio, si no indicamos el valor del parámetro. Va a compañdo del atributo `generate: expression`.

Como vemos los parámetros se pueden indicar de dos formas:

* `${NOMBRE_PARÁMETRO}`: El valor se proporciona como una cadena de caracteres. Normalmente usamos esta forma.
* `${{NOMBRE_PARÁMETRO}}`: El valor se puede proporcionar como un valor que no sea una cadena de caracteres. Lo hemos usado para indicar el número de replicas, que en la definición tiene que ser un número entero (no se entrecomilla).


Por último para crear el objeto **Template** a partir de su definición, ejecutamos:

    oc apply -f mysql-plantilla.yaml

Y podemos ver que realmente la hemos creado, desde la línea de comandos:

    oc get templates
    NAME              DESCRIPTION                                       PARAMETERS        OBJECTS
    mysql-plantilla   Plantilla para desplegar un deployment de mysql   7 (3 generated)   1

Y desde el catálogo de aplicaciones:

![mysql](img/mysql.png)