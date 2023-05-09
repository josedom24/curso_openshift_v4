# Creación de plantillas a partir de objetos existentes

En este apartado vamos a aprender a crear nuevos **Templates** a partir de recursos que ya tenemos creado. En concreto, crearemos plantillas a partir de plantillas que ya tenemos creadas, y crearemos plantillas a partir de un conjunto de objetos que ya tenemos creados.

## Crear Templates a partir de Templates existentes

Esta operación es muy sencilla, y simplemente consiste en copiar la definición YAML de un **Template** en un fichero y posteriormente hacer las modificaciones que necesitemos. Por ejemplo:

    oc get template mysql-plantilla -o yaml > nueva_plantilla.yaml

Otro ejemplo que nos permite hacer una copia de una plantilla del catálogo de aplicaciones de de OpenShift:

    oc get template mariadb-ephemeral -n openshift -o yaml > otra-plantilla.yaml

## Crear Templates a partir de objetos existentes

Vamos a imaginar que hemos desplegado una aplicación PHP que tenemos guardada en un repositorio. Para ello hemos ejecutado el comando:

    oc new-app php~https://github.com/josedom24/osv4_php --name=app-php --as-deployment-config=true
    oc expose service app-php

Como ya sabemos estas dos instrucciones han creado varios tipos de objetos: **DeploymentConfig**, **BuildConfig**, **ImageStream**, **Service** y **Route**.

Ahora queremos diseñar un **Template** que nos permita desplegar aplicaciones PHP que estén guardadas en repositorios GitHub. A partir de la definición de los objetos que hemos creado, podemos crear la definición de un **Tempalate**, estableciendo los parámetros que queramos configurar posteriormente. Para ello podemos ejecutar la instrucción:

    oc get -o yaml all > php-plantilla.yaml

En el fichero `php-plantilla.yaml` tendremos la lista de las definiciones de los objetos, en el próximo apartado veremos cómo lo convertimos en la definición de un **Template**.