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

