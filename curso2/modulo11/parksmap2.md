# Despliegue de aplicación Nationalparks en OpenShift v4 (2ª parte)

En este apartado vamos a desplegar la aplicación escrita en Java **Nationalparks**, es el servicio backend, que expondrá 2 endpoints que la aplicación **Parksmap** utilizará para obtener la información delos Parques NAcionales que visualizará en el mapa. Este servicio guarda la información de los Parques Nacionales en una base de datos **MongoDB**. Para hacer las peticiones a este servicio se utilizará una URL proporcionada por el objeto **Route** que crearemos a continuación.

Vamos a usar la estrategia de construcción de imágenes **source-2-image**, utilizando el código de la aplicación que se encuentra en el repositorio `https://github.com/openshift-roadshow/nationalparks.git`.

Vamos a crear el despliegue desde la terminal, para ello:

    oc new-app java:openjdk-11-ubi8~https://github.com/openshift-roadshow/nationalparks.git -l app=workshop \
                      -l component=nationalparks
                      -l role=backend
                      -l app.kubernetes.io/part-of=workshop \
                      -l app.openshift.io/runtime=java
                      --name=nationalparks \
                      --strategy=source
    
    oc expose service/nationalparks

Una vez creado los recursos accedemos a la topología y comprobamos los que hemos creado:




