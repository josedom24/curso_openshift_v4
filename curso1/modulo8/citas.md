# Despliegue de aplicación Citas en OpenShift v4

El ejemplo que vamos a desarrollar en este módulo se basa en el artículo [Learn Kubernetes using Red Hat Developer Sandbox for OpenShift](https://developers.redhat.com/developer-sandbox/activities/learn-kubernetes-using-red-hat-developer-sandbox-openshift).

La aplicación **Citas** nos muestra citas celebres de distintos autores en una página web. Esta formada por dos microservicios (`citas-backend` y `citas-frontend`) y un servicio de base de datos mysql. La aplicación funciona de la siguiente manera:

* `citas-backend`: Es una API RESTful que devuelve información sobre citas famosas de distintos autores famosos. La **versión 1** devuelve información de 6 citas que tiene incluidas en el programa. La **versión 2** lee la información de las citas de una base de datos guardada en un servidor mysql. La aplicación está construida en python 3.9 y ofrece el servicio en el puerto TCP/10000.

    La API RESTful tiene los siguientes endpoints:

    * URL: `/`
        * MÉTODO: GET  
        * Devuelve la cadena "qotd" para comprobar que el servicio está funcionando.
    * URL: `/version`
        * MÉTODO: GET 
        * Devuelve una cadena con la versión de la aplicación.
    * URL: `/writtenin`
        * MÉTODO: GET
        * Devuelve una cadena con la versión de python con el que se ha programado.
    * URL: `/quotes`
        * MÉTODO: GET
        * Devuelve un JSON con todas las citas.
    * URL: `/quotes/random`
        * MÉTODO: GET
        * Devuelve un JSON con una cita elegida aleatoriamente.
    * URL: `/quotes/{id}`
        * MÉTODO: GET
        * Devuelve un JSON con la cita correspondiente al identificador indicado en la url.
* `citas-frontend`: Es una aplicación python flask que crea una página web dinámica con una cita aleatoria que lee de `citas-backend` para ello conecta al servicio RESTful usando el nombre indicado en la variable de entorno `CITAS_SERVIDOR`.

En el [repositorio GitHub](https://github.com/josedom24/citas-openshift) puedes encontrar el código para generar las imágenes que se van a usar, así como un ejemplo de despliegue en Kubernetes.
