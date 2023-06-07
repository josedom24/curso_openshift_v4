# ImageStream a imágenes del registro interno

OpenShift posee un registro interno con imágenes precargadas. Como hemos indicado no trabajamos directamente con esas imágenes, sino que tenemos a nuestra disposición el recurso **ImageStream** que apunta a estas imágenes, y serán las que utilicemos para crear nuevos despliegues o para construir nuevas imágenes.

Las **ImageStreams** que apuntan a imágenes internas, la podemos encontrar en el catálogo, por ejemplo si buscamos por la palabra "httpd", podemos encontrar:

    oc new-app -S httpd
    ...
    Image streams (oc new-app --image-stream=<image-stream> [--code=<source>])
    -----
    httpd
      Project: openshift
      Tags:    2.4-el7, 2.4-ubi8, 2.4-ubi9, latest

Realmente los **ImageStreams** que apuntan a imágenes internas se encuentran en el proyecto **openshift**, podemos verlos todos, ejecutando:

    oc get is -n openshift

Por ejemplo, si nos centramos en el **ImageStream** `httpd`:

    oc get is httpd -n openshift
    NAME    IMAGE REPOSITORY                                                          TAGS                                                UPDATED
    httpd   default-route-openshift-image-registry.apps-crc.testing/openshift/httpd   2.4,2.4-el7,2.4-el8,2.4-ubi8,2.4-ubi9 + 1 more...   6 weeks ago

Vemos el nombre, la ruta a dicha imagen y las etiquetas que tiene definidas.

Tenemos además los recursos **ImageStreamTags** que representan las etiquetas de un **ImageStream** y son las que verdaderamente apuntan a una imagen, por ejemplo:

    oc get istag httpd:2.4 -n openshift
    NAME        IMAGE REFERENCE                                                                                                                            UPDATED
    httpd:2.4   image-registry.openshift-image-registry.svc:5000/openshift/httpd@sha256:212f61a91651b44e8beb9635885deaae57c8b15a8a50716dd7cebb9a6457b4be   6 weeks ago

Vemos como la etiqueta `2.4` de la **ImageStream** `httpd` está apuntado a una imagen en el registro interno (`image-registry.openshift-image-registry.svc:5000`) con un nombre y un determinado identificador. Esto me asegura que cada vez que use `httpd:2.4` estaré usando la misma imagen.

Finalmente indicar que con el comando `oc get images` ejecutado como administrador del clúster puedo acceder a las imágenes del registro interno, por ejemplo vamos a buscar la imagen anterior en el registro:

    oc get images | grep httpd
    sha256:212f61a91651b44e8beb9635885deaae57c8b15a8a50716dd7cebb9a6457b4be   registry.redhat.io/rhscl/httpd-24-rhel7@sha256:212f61a91651b44e8beb9635885deaae57c8b15a8a50716dd7cebb9a6457b4be
    ...
    
## Uso de las ImageStream internas

Como hemos indicado, usaremos las **ImageStream** para la creación de nuevas aplicaciones o la construcción de nuevas imágenes. 

### Creación de un nuevo despliegue

Por ejemplo, podríamos desplegar una nueva aplicación a partir de la **ImageStream** `httpd:2.4`:

    oc new-app httpd:2.4 --name=web1
    ...
    --> Found image 2ffb964 (2 months old) in image stream "openshift/httpd" under tag "2.4" for "httpd:2.4"
    ...

Una vez creado el despliegue, podríamos ver la imagen que se está usando para el despliegue:

    oc describe deploy web1
    Containers:
       httpd:
        Image:        image-registry.openshift-image-registry.svc:5000/openshift/httpd@sha256:212f61a91651b44e8beb9635885deaae57c8b15a8a50716dd7cebb9a6457b4be

Evidentemente su ID coincide con la imagen que vimos anteriormente y que estaba apuntada por `httpd:2.4`.

### Construcción de imágenes

Del mismo modo vamos a usar la **ImageStream** `httpd:2.4` como base para crear otra imagen:

    oc new-app httpd:2.4~https://github.com/josedom24/osv4_html --name=web2
    ...
    --> Found image 2ffb964 (2 months old) in image stream "openshift/httpd" under tag "2.4" for "httpd:2.4"
    ...
    --> Creating resources ...
    imagestream.image.openshift.io "web2" created
    ...

Evidentemente se creará un nuevo recurso **ImageStream** que apunta a la nueva imagen que estamos construyendo:

    oc get is
    NAME   IMAGE REPOSITORY                                                     TAGS     UPDATED
    web2   default-route-openshift-image-registry.apps-crc.testing/httpd/web2   latest   50 seconds ago

    oc describe is web2
    ...
    Unique Images:		1
    Tags:			1

    latest
      no spec tag

      * image-registry.openshift-image-registry.svc:5000/httpd/web2@sha256:3cf4982cc9aa5337afdce8c1fb6547bcca029ba32bb8065f62ccc6350da50499
          About a minute ago

Y comprobamos que se ha creado esa imagen en el registro interno:

    oc get images | grep web2
    sha256:3cf4982cc9aa5337afdce8c1fb6547bcca029ba32bb8065f62ccc6350da50499   image-registry.openshift-image-registry.svc:5000/httpd/web2@sha256:3cf4982cc9aa5337afdce8c1fb6547bcca029ba32bb8065f62ccc6350da50499
