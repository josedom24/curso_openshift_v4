# Despliegue de aplicaciones desde código fuente con oc (2ª parte)

## Despliegue de una página estática con un servidor nginx

Si queremos crear una aplicación con la página web de nuestro repositorio con una imagen basada en *nginx*, podemos buscar los recursos **Images Stream** que tenemos en el catálogo:

    oc new-app -S nginx

Y posteriormente creamos la aplicación con el comando:

    oc new-app nginx~https://github.com/josedom24/osv4_html.git --name=app2

## Detección automática del Builder Image

OpenShift examina el repositorio y según los ficheros que tengamos es capaz de determinar con que lenguaje está escrito y te sugiere un **Builder Image** .

Si añadimos un fichero `index.php` a nuestro repositorio:

    echo '<?php phpinfo();?>'> index.php
    git add index.php 
    git commit -am "php"
    git push

Y ahora creamos la aplicación sin indicar la **Builder Image**:

    oc new-app https://github.com/josedom24/osv4_html.git --name=app3
    --> Found image b34c3d8 (5 months old) in image stream "openshift/php" under tag "8.0-ubi8" for "php"

        Apache 2.4 with PHP 8.0 
        ----------------------- 
        PHP 8.0 available as container is a base platform for building and running various PHP 8.0 applications and frameworks. PHP is an HTML-embedded scripting language. PHP attempts to make it easy for developers to write dynamically generated web pages. PHP also offers built-in database integration for several commercial and non-commercial database management systems, so writing a database-enabled webpage with PHP is fairly simple. The most common use of PHP coding is probably as a replacement for CGI scripts.

        Tags: builder, php, php80, php-80

        * The source repository appears to match: php
        * A source build using source code from https://github.com/josedom24/osv4_html.git will be created
          * The resulting image will be pushed to image stream tag "app3:latest"
          * Use 'oc start-build' to trigger a new build

    --> Creating resources ...
        imagestream.image.openshift.io "app3" created
        buildconfig.build.openshift.io "app3" created
        deployment.apps "app3" created
        service "app3" created
    --> Success
        Build scheduled, use 'oc logs -f buildconfig/app3' to track its progress.
        Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
         'oc expose service/app3' 
        Run 'oc status' to view your app.

Comprobamos que ha detectado que la aplicación está escrita en PHP, y nos ha seleccionado la **Builder Image** `php:8.0-ubi8`.  Una vez desplegada la aplicación, creamos el objeto **Route** y accedemos al fichero `index.php`:

    oc expose service app3

![app3](img/app3.png)

Si queremos usar otra versión de PHP, tendríamos que indicar la versión de la **builder image**, para ello buscamos las distintas versiones que nos ofrecen:

    oc new-app -S php
    ...
    Image streams (oc new-app --image-stream=<image-stream> [--code=<source>])
    -----
    php
      Project: openshift
      Tags:    7.3-ubi7, 7.4-ubi8, 8.0-ubi8, 8.0-ubi9, latest


Y ahora creamos una nueva aplicación con la versión `7.3-ubi7`:

    oc new-app php:7.3-ubi7~https://github.com/josedom24/osv4_html.git --name=app4

    oc expose service app4

![app4](img/app4.png)

## Eliminar la aplicación

Por ejemplo, para eliminar la aplicación `app1` tendríamos que eliminar todos los recursos generados:

    oc delete deploy app1
    oc delete service app1
    oc delete route app1
    oc delete is app1
    oc delete bc app1
