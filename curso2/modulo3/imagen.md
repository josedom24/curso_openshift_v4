# Despliegue de aplicaciones desde imágenes

El esquema para ver los recursos que se crean en OpenShift al realizar un despliegue desde una imagen es el siguiente:

![esquema](img/imagen.png)

Para crear un despliegue desde la imagen `josedom24/test_web:v1` que se llame `test-web` ejecutamos el comando:

    oc new-app josedom24/test_web:v1 --name test-web

    --> Found container image 4b01a27 (12 days old) from Docker Hub for "josedom24/test_web:v1"

        * An image stream tag will be created as "test-web:v1" that will track this image

    --> Creating resources ...
        imagestream.image.openshift.io "test-web" created
        deployment.apps "test-web" created
        service "test-web" created
    --> Success
        Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
         'oc expose service/test-web' 
        Run 'oc status' to view your app.

Como vemos se han creado varios recursos:

1. Ha encontrado una imgen llamada `josedom24/test_web:v1` en Docker Hub.
2. Ha creado un recurso **ImageStream** que ha llamado igual que la imagen y la ha etiquetado con la misma etiqueta y que referencia a la imagen original.
3. Ha creado un recurso **Deployment** responsable de desplegar los recursos necesario para ejecutar los pods.
4. Ha creado un recurso **Service** que nos posibilita el acceso a la aplicación.
5. No ha creado un recurso **Route** para el acceso por medio de una URL, pero nos ha indicado el comando necesario para crearlo: `oc expose service/test-web`.

