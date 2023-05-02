# Actualización automática de ImageStream

Cuando creamos un nuevo **ImageStream** que apunta a una imagen, podemos activar una funcionalidad que periódicamente comprueba si la imagen ha cambiado, y en caso afirmativo, actualiza el **ImageStream** para que apunte a la nueva imagen. Por defecto, el periodo de comprobación es de 15 minutos.

En primer lugar, vamos a crear una imagen docker y la voy a subir a mi cuenta de Docker Hub. Para ello vamos a usar el fichero `Dockerfile`:

```
FROM centos:centos7
CMD echo 'Hola, esta es la versión 1 de la imagen' && exec sleep infinity
```

Para crear la imagen y subirla ejecuto las siguientes instrucciones:

    docker login
    docker build -t josedom24/imagen-prueba .
    docker pull josedom24/image-prueba

A continuación creamos el **ImageStream** apuntando a dicha image, con la opción `--scheduled=true` que es la responsable de monitorizar la imagen original:

    oc import-image imagen-prueba:latest --from=docker.io/josedom24/imagen-prueba:latest --scheduled=true --confirm

Comprobamos el id de la imagen a la que apunta:

    oc describe is imagen-prueba
    ...
    latest
      updates automatically from registry docker.io/josedom24/imagen-prueba:latest

      * docker.io/josedom24/imagen-prueba@sha256:9577a5de1c8e4590c3e538207f3edb74968e3d119e435cceeeef9853528ab761


Ahora desplegamos esta imagen y comprobamos la versión:

    oc new-app imagen-prueba --name=app-prueba
    
    oc logs deploy/app-prueba
    Hola, esta es la versión 1 de la imagen

Ahora vamos a modificar el fichero `Dockerfile` y vamos a volver a subir la imagen con el mismo nombre y la misma etiqueta. Cambiamos el mensaje del fichero `Dockerfile` para que ponga `versión 2`, y volvemos a generar la imagen y subirla:

    docker build -t josedom24/imagen-prueba .
    docker pull josedom24/image-prueba   

Cuando se ha subido la imagen ya vemos que se le ha asignado otro id:
    
    latest: digest: sha256:20ed24d87a2f66eab7ddae859fe43ad101bea5b28b2101947e1468f24c52470d size: 529

**Y esperamos los 15 minutos...**

Y podemos comprobar que el **ImageStream** se ha actualizado:

oc describe is imagen-prueba
    ...
    latest
      updates automatically from registry docker.io/josedom24/imagen-prueba:latest

      * docker.io/josedom24/imagen-prueba@sha256:20ed24d87a2f66eab7ddae859fe43ad101bea5b28b2101947e1468f24c52470d
          39 seconds ago
        docker.io/josedom24/imagen-prueba@sha256:9577a5de1c8e4590c3e538207f3edb74968e3d119e435cceeeef9853528ab761
          15 minutes ago

Y que se ha actualizado el despliegue:

    oc get deploy,rs,pod
    NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/app-prueba   1/1     1            1           14m

    NAME                                    DESIRED   CURRENT   READY   AGE
    replicaset.apps/app-prueba-57896bf5     0         0         0       14m
    replicaset.apps/app-prueba-59f8bd66f7   0         0         0       14m
    replicaset.apps/app-prueba-5c8494ffc7   1         1         1       60s

    NAME                              READY   STATUS    RESTARTS   AGE
    pod/app-prueba-5c8494ffc7-nk7ft   1/1     Running   0          60s

Y por tanto tenemos desplegado la nueva versión de la imagen:

    oc logs deploy/app-prueba
    Hola, esta es la versión 2 de la imagen
