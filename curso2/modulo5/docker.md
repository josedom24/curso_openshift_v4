# Construcción de imágenes con estrategia Docker + repositorio Git

En el apartado anterior, vimos que al desplegar una aplicación con `oc new-app` entre otros recursos, se creaba el **BuildConfig** responsable de construir la nueva imagen. Realmente, no es necesario desplegar la aplicación, podemos simplemente crear el objeto **BuildConfig** para construir la imagen y posteriormente crear la aplicación desde la **ImageStream** que se haya creado. Para ello vamos a usar el comando `oc new-build`.

En este primer ejercicio vamos a crear una construcción (build) utilizando la estrategia **Docker** y como fuente de entrada donde esta nuestro fichero `Dockerfile` indicaremos  un **repositorio en GitHub**. 

En este ejercicio no vamos a desplegar la aplicación, vamos a construir la imagen ejecutando el comando `oc nrw-build`, que creará el **BuildConfig** encargado de construir la imagen que se guardará en el registro interno y se apuntara con un objeto **ImageStream**. Posteriormente desplegaremos la aplicación con `oc new-app` utilizando la iamgen construida.




El fichero `Dockerfile`:

```
FROM rhscl/php-56-rhel7
EXPOSE 8080
COPY . /app
ENV INFORMACION="Imagen construida con Dockerfile"
CMD /bin/bash -c 'php -S 0.0.0.0:8080'
``` 