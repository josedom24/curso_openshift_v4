# Gestión de las etiquetas en un ImageStream

En el apartado anterior hemos visto como crear objetos **ImageStream** que nos referencias a imágenes externas o internas. Realmente un **ImageStream** es un conjunto de etiquetas, y cada un a de ella puede apuntar a una imagen distinta o a la misma imagen.

En este apartado vamos a trabajar con la gestión de etiquetas de los **ImageStream**.

## Crear nuevas etiquetas en un ImageStream

Para hacer este ejercicio vamos a crear una **ImageStream** que tendrá dos etiquetas que apuntan a las dos versiones de la imagen `josedom24/citas-backend`. Para ello, ejecutamos:

    oc create is citas
    oc import-image citas:v1 --from=docker.io/josedom24/citas-backend:v1
    oc import-image citas:v2 --from=docker.io/josedom24/citas-backend:v2

Si comprobamos la descripción del **ImageStream** `citas` podemos comprobar que tenemos dos etiquetas que apuntan a dos imágenes distintas:

    oc describe is citas
    ...
    Unique Images:		2
    Tags:			    2

    v1
      tagged from docker.io/josedom24/citas-backend:v1

      * docker.io/josedom24/citas-backend@sha256:42b6ff31b8a86e292f5d4aec63eb074144fc134a427d465c77c641e836467a85
          17 seconds ago

    v2
      tagged from docker.io/josedom24/citas-backend:v2

      * docker.io/josedom24/citas-backend@sha256:eae3f65c7760f3834cd08affead4c8972534948b4c73156485e89ea8b9d6ed2d
          7 seconds ago

Puede ser muy útil tener varias etiquetas que apunten a la misma imagen, ya que vamos a hacer referencia al nombre del **ImageStream** y su etiqueta, por lo tanto si posteriormente cambiamos la referencia de una etiqueta y la hacemos apuntar a otra imagen podemos decir que el **ImageStream** ha cambiado, con lo que podemos provocar un despliegue nuevo de la aplicación, lo veremos en el siguiente ejemplo.

Podemos, por ejemplo, crear una etiqueta que nos permita apuntar a la imagen más nueva:

    oc tag citas:v2 citas:latest

Otro ejemplo, podemos crear una etiqueta para indicar la versión que queremos desplegar en producción:

    oc tag citas:v1 citas:prod

Ahora tendríamos un **ImageStream** con 4 etiquetas a puntando a 2 imágenes distintas:


    oc describe is citas
    ...
    Unique Images:		2
    Tags:   			4

    latest
      tagged from citas@sha256:eae3f65c7760f3834cd08affead4c8972534948b4c73156485e89ea8b9d6ed2d

      * docker.io/josedom24/citas-backend@sha256:eae3f65c7760f3834cd08affead4c8972534948b4c73156485e89ea8b9d6ed2d
          About a minute ago

    prod
      tagged from citas@sha256:42b6ff31b8a86e292f5d4aec63eb074144fc134a427d465c77c641e836467a85

      * docker.io/josedom24/citas-backend@sha256:42b6ff31b8a86e292f5d4aec63eb074144fc134a427d465c77c641e836467a85
          54 seconds ago

    v1
      tagged from docker.io/josedom24/citas-backend:v1

      * docker.io/josedom24/citas-backend@sha256:42b6ff31b8a86e292f5d4aec63eb074144fc134a427d465c77c641e836467a85
          6 minutes ago

    v2
      tagged from docker.io/josedom24/citas-backend:v2

      * docker.io/josedom24/citas-backend@sha256:eae3f65c7760f3834cd08affead4c8972534948b4c73156485e89ea8b9d6ed2d
          6 minutes ago

Para eliminar una etiqueta de un **ImageStream** podemos hacerlo de dos formas:

    oc tag citas:latest -d
    oc delete istag citas:latest

## Ejemplo: Actualización de despliegue por cambio de imagen

Vamos a crear un despliegue utilizando el **ImageStream** `citas:prod` (que actualmente apunta a la versión 1 de la imagen). Hay que tener en cuenta que la imagen usa el puerto TCP/10000 para ofrecer el servicio:

    oc new-app citas:prod --name=app-citas
    oc expose service app-citas --port=10000

Se ha creado un despliegue:

    oc get deploy,rs,pod
    NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/app-citas   1/1     1            1           33s

    NAME                                   DESIRED   CURRENT   READY   AGE
    replicaset.apps/app-citas-5f56fcf9cf   1         1         1       33s
    replicaset.apps/app-citas-6c9c5d5f9    0         0         0       33s

    NAME                             READY   STATUS    RESTARTS   AGE
    pod/app-citas-5f56fcf9cf-gr9sh   1/1     Running   0          33s

Y comprobamos que hemos desplegado la versión 1 de la aplicación:

    curl http://app-citas-josedom24-dev.apps.sandbox-m3.1530.p1.openshiftapps.com/version
    v1

¿Qué ocurrirá si hacemos que la etiqueta `prod` del **ImageStream** referencia a la segunda versión de la imagen?. Habrá un cambio en la imagen que se ha utilizado en el despliegue, y esto hará que se actualice el despliegue creando un nuevo **ReplicaSet** que creará un nuevo pod con la nueva versión de la imagen:

    oc tag citas:prod -d
    oc tag citas:v2 citas:prod

Comprobamos que se ha actualizado el despliegue:

    oc get deploy,rs,pod
    NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/app-citas   1/1     1            1           4m14s

    NAME                                   DESIRED   CURRENT   READY   AGE
    replicaset.apps/app-citas-5f56fcf9cf   0         0         0       4m14s
    replicaset.apps/app-citas-6c9c5d5f9    0         0         0       4m14s
    replicaset.apps/app-citas-757777cfd8   1         1         1       9s

    NAME                             READY   STATUS    RESTARTS   AGE
    pod/app-citas-757777cfd8-7mklv   1/1     Running   0          9s

Y que ahora tenemos la segunda versión de la imagen:

    curl http://app-citas-josedom24-dev.apps.sandbox-m3.1530.p1.openshiftapps.com/version
    v2
