# Crear objetos desde un Template

Una vez que tenemos nuestro objeto **Template**, podemos utilizarlo para crear de manera muy sencilla los objetos que tiene definido. A ese proceso se le llama "instanciar" una plantilla y para ello utilizamos el comando `process`. Veamos algunos ejemplos de como usarlo.

Si queremos ver los parámetros que podemos configurar en la plantilla, ejecutamos:

    oc process --parameters mysql-plantilla
    NAME                DESCRIPTION                                    GENERATOR           VALUE
    REPLICAS            Número de pods creados                                             1
    NOMBRE_APP          Nombre del pod que se va a crear               expression          mysql[0-9]{2}
    NOMBRE_CONTENEDOR   Nombre del contenedor que se va a crear                            contenedor-mysql
    ROOT_PASSWORD       Contraseña del root de mysql                   expression          [A-Z0-9]{8}
    USER                Nombre del usuario mysql que se va acrear                          usuario
    PASSWORD            Contraseña del usuario de mysql                expression          [A-Z0-9]{8}
    DATABASE            Nombre de la base de datos que se va a crear                       nueva_bd

Donde vemos el nombre, la descripción y los valores por defecto de los parámetros.

Podemos generar la definición de los objetos que crea un **Template**. La generación de la definición de los objetos no implica su creación. Veamos algunos ejemplos:

1. Genero la definición en formato YAML de los objetos sin indicar ningún parámetro (se cogen los valores por defecto):

        oc process mysql-plantilla -o yaml

2. Podemos indicar algunos parámetros en la generación de la definición. Los parámetros que no indiquemos cogerán sus valores por defecto:

        oc process mysql-plantilla -o yaml -p REPLICAS=2 -p NOMBRE_APP=mimysql -p ROOT_PASSWORD=asdasd1234

3. Si tenemos muchos parámetros podemos guardar los parámetros en un fichero, por ejemplo en `parametros-mysql.txt`:

        REPLICAS=3
        NOMBRE_APP=otra_mysql
        NOMBRE_CONTENEDOR=contenedor1
        ROOT_PASSWORD=asdasd1234
        USER=usuario
        PASSWORD=mypassword
        DATABASE=mi_bd

    Podemos usar este fichero para indicar los parámetros de la siguiente forma:

        oc process mysql-plantilla -o yaml --param-file=parametros-mysql.txt

4. Además, de los parámetros, al generar la definición de los objetos podemos indicar las `labels` que tendrán todos los objetos generados:

        oc process mysql-plantilla -o yaml -l type=database

    Evidentemente, podemos definir parámetros y etiquetas:

        oc process mysql-plantilla -o yaml -p REPLICAS=2 -l type=database


Una vez que sabemos como generar la definición de los objetos que están definido en una plantilla, tenemos varias formas para crearlos:

1. Generar la definición de los objetos de la plantilla (si es necesario indicado parámetros y etiquetas) y ejecutando `oc apply` sobre la definición generada, por ejemplo:

        oc process mysql-plantilla -o yaml -p REPLICAS=2 -p NOMBRE_APP=mimysql | oc apply -f -

2. Guardar la generación de la definición de los objetos en un fichero YAML, y utilizar este fichero para crear los objetos. Esta opción tiene dos ventajas: que podemos reproducir el despliegue y que podemos eliminar los objetos utilizando el fichero YAML. Por ejemplo:

        oc process mysql-plantilla -o yaml -p NOMBRE_APP=app1 -p REPLICAS=3 -l type=database > deploy_mysql.yaml        
        oc apply -f deploy_mysql.yaml

3. Utilizando el comando `oc new-app`:

        oc new-app mysql-plantilla -p NOMBRE_APP=new-mysql

## Prueba de funcionamiento

Creamos un **Deployment** a partir del **Template**. Para ello, indicamos sólo dos parámetros:

    oc process mysql-plantilla -p NOMBRE_APP=mysql -p PASSWORD=asdasd | oc apply -f -

A continuación intentamos acceder a la base de datos, ejecutando:

    oc exec -it deploy/mysql -- mysql -u usuario -pasdasd nueva_bd -h localhost
    ...
    mysql>
