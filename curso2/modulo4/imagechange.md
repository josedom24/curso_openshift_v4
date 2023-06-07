# Actualización automática de un build

Vamos a crear un nuevo objeto **BuildConfig** y nos vamos a centrar en su definición en la sección de **triggers**, donde se definen los distintos eventos que disparan la construcción de forma automática.

En primer lugar vamos a crear un objeto **ImageStream** que apuntará a una imagen constructora de PHP, que luego utilizaremos para explicar el trigger `ImageChange`.

    oc import-image mi-php:v1 --from=registry.access.redhat.com/ubi8/php-74 --confirm
    oc new-build mi-php:v1~https://github.com/josedom24/osv4_php --strategy=source --name=app9

    oc get build
    NAME   TYPE     FROM   LATEST
    app9   Source   Git    1
    
    oc get build
    NAME     TYPE     FROM          STATUS    STARTED          DURATION
    app9-1   Source   Git@4cca4f9   Running   12 seconds ago   

Si comprobamos la definición del objeto y nos centramos en la sección `triggers`:

    oc get bc app9 -o yaml
    ...
    triggers:
      - github:
          secret: -EPtf1InRvdMAwKLd-wY
        type: GitHub
      - generic:
          secret: ys1E_7ah4ghQYY_wUbI0
        type: Generic
      - type: ConfigChange
      - imageChange: {}
        type: ImageChange

También lo podríamos ver obteniendo información del objeto:

    oc describe bc app9
    ...
    Triggered by:		Config, ImageChange
    Webhook GitHub:
    	URL:	https://api.sandbox-m3.1530.p1.openshiftapps.com:6443/apis/build.openshift.io/v1/namespaces/josedom24-dev/buildconfigs/app9/webhooks/<secret>/github
    Webhook Generic:
    	URL:		https://api.sandbox-m3.1530.p1.openshiftapps.com:6443/apis/build.openshift.io/v1/namespaces/josedom24-dev/buildconfigs/app9/webhooks/<secret>/generic
    	AllowEnv:	false


Vemos que tenemos tres posibles disparadores:

* `ConfigChange`: Permite que se cree una nueva construcción de forma automática cuando se crea el objeto **BuildConfig**.
* `ImageChange`: Permite que se cree una nueva construcción de forma automática cuando está disponible una nueva versión de la imagen constructora.
* `Webhook`: Nos permite disparar una nueva construcción de forma automática cuando ocurre un evento (por ejemplo un `push`) en un servicio externo (por ejemplo, un repositorio GitHub). Este servicio hace una llamada a una URL que nosotros le proporcionamos que produce que se inicie el proceso de construcción. 

## Ejemplo de actualización del build por ImageChange

Seguimos trabajando con el **BuildConfig** que hemos creado y que ha disparado el primer build al tener configurado el trigger `ConfigChange`.

    oc get build
    NAME     TYPE     FROM          STATUS     STARTED         DURATION
    app9-1   Source   Git@4cca4f9   Complete   9 minutes ago   55s

Comprobamos que se han creado dos **ImageStreams**, uno que se refiere a la imagen constructora y otro a la imagen generada:

    oc get is -o name
    imagestream.image.openshift.io/app9
    imagestream.image.openshift.io/mi-php

La imagen constructora que utiliza es `mi-php:v1`. Si hacemos que esa etiqueta del **ImageStream** apunte a otra imagen, habremos cambiado la imagen constructora, y debido al trigger `ImageChange` se volverá a iniciar un nuevo build. En primer lugar voy a eliminar la etiqueta (el objeto **ImageStreamTag**):

    oc delete istag mi-php:v1

Y voy a volver a hacer que referencie a otra imagen:

    oc import-image mi-php:v1 --from=registry.access.redhat.com/ubi8/php-80

Y comprobamos que se ha iniciado otro build, que construir una nueva imagen:

    oc get build
    NAME     TYPE     FROM          STATUS     STARTED          DURATION
    app9-1   Source   Git@4cca4f9   Complete   15 minutes ago   55s
    app9-2   Source   Git@4cca4f9   Running    5 seconds ago    

