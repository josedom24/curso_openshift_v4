# Definición del objeto BuildConfig

Como hemos visto el objeto **BuildConfig** guarda la configuración (estrategia y fuentes de entrada) para realizar la construcción de una nueva imagen.

Hemos creado objetos **BuildConfig** con dos comandos distintos: `oc new-app` y con `oc new-build`. Pero como cualquier recurso de OpenShift podemos tener su definición en un fichero YAML, y crearlo a partir de este fichero.

Tenemos un fichero `bc.yaml` con el siguiente contenido:

```yaml
apiVersion: build.openshift.io/v1
kind: BuildConfig
metadata:
  labels:
    app: app3
  name: app3
spec:
  failedBuildsHistoryLimit: 5
  output:
    to:
      kind: ImageStreamTag
      name: imagen-app3:latest
  runPolicy: Serial
  source:
    git:
      uri: https://github.com/josedom24/osv4_php
    type: Git
  strategy:
    sourceStrategy:
      from:
        kind: ImageStreamTag
        name: php:latest
        namespace: openshift
    type: Source
  successfulBuildsHistoryLimit: 5
  triggers:
  - type: ConfigChange
  - imageChange: {}
    type: ImageChange
```

Veamos los distintos parámetros:

* `failedBuildsHistoryLimit`: Especifica la cantidad máxima de builds fallidos que se pueden mantener en el historial de builds de la aplicación.
* `successfulBuildsHistoryLimit`: Especifica la cantidad máxima de builds que se han ejecutado de manera correcta que se pueden mantener en el historial de builds de la aplicación.
* `runPolicy`: Como podemos indicar varias fuentes de entrada, este parámetro indica la manera de construirlos. Por defecto el valor es `Serial` indicando que se deben construir de manera consecutiva. En otros escenarios es posible hacer construcciones en paralelo (`Parallel`).
* `output`: Me permite indicar donde se guardará la imagen construida. En este caso, se creará un recurso **ImageStream** (campo `kind`) y el nombre y etiqueta asignada (`name`).
* `source`: Indica la fuente de información donde se toman los ficheros. En este caso es un repositorio Git (`type`), indicando la dirección `git.uri`.
* `strategy`: Nos define la estrategia de construcción. Indicamos la imagen constructora (`from`): indicamos el tipo (`kind`), el nombre (`name`) y el proyecto donde se encuentra (`namespace`). También indicamos el tipo de estrategia, con el parámetro `type`.
* `triggers`: Se definen los disparadores que comienza una nueva construcción de forma automática. En este caso tenemos dos posibles disparadores: que la configuración del recurso cambie (`type: ConfigChange`) o que la imagen de construcción cambie (`type: ImageChange`). Más adelante veremos que hay otro tipo de disparador.

Para crear el nuevo objeto **BuildConfig**, ejecutamos:

    oc apply -f bc.yaml 

    oc get bc
    NAME      TYPE     FROM   LATEST
    app3      Source   Git    1

Y comprobamos que se ha comenzando una construcción:

    oc get build
    NAME        TYPE     FROM          STATUS     STARTED             DURATION
    app3-1      Source   Git           New (InvalidOutputReference)

Vemos que la construcción ha dado un fallo: `InvalidOutputReference`. Esto es debido a que la **ImageStream** que habíamos configurado de salida: `imagen-app3`no existe. Para crear el objeto **ImageStream** ejecutamos:

    oc create is imagen-app3

Una vez que la hemos creado, comprobamos que el build ya puede seguir ejecutándose:

    oc get build
    NAME        TYPE     FROM          STATUS     STARTED             DURATION
    app3-1   Source   Git@4c4e84f      Running    6 seconds ago

Si queremos ver las características de los recursos que hemos creado, podemos ejecutar:

    oc describe bc app3
    oc describe build app3-1

Cuando finalice la construcción de la imagen, podríamos desplegarla ejecutando:

    oc new-app imagen-app3 --name=app3

## Definición de los objetos BuildConfig definidos en los ejercicios anteriores

Recordamos que teníamos un **BuildConfig** `app1` que utilizaba la estrategia **Source-to-Image (S2I)** y obtenía los ficheros de un repositorio Git, podemos ver su definición ejecutando:

    oc get bc app1 -o yaml
    ...    
    spec:
      ...
      output:
        to:
          kind: ImageStreamTag
          name: app1:latest
      ...
      source:
        git:
          uri: https://github.com/josedom24/osv4_php
        type: Git
      strategy:
        sourceStrategy:
          from:
            kind: ImageStreamTag
            name: php:8.0-ubi8
            namespace: openshift
        type: Source
      triggers:
      - github:
          secret: 35iNue334T9PuT4Sp2sV
        type: GitHub
      - generic:
          secret: hwvVeSjQhcjyDSNdvGYt
        type: Generic
      - type: ConfigChange
      - imageChange: {}
        type: ImageChange

El **BuildConfig** `app2` utilizaba la estrategia **Docker** y obtenía el fichero `Dockerfile` de un repositorio Git, podemos ver su definición ejecutando:

    oc get bc app2 -o yaml
    ...
    spec:
      ...
      output:
        to:
          kind: ImageStreamTag
          name: app2:latest
      ...
      source:
        git:
          uri: https://github.com/josedom24/osv4_php
        type: Git
      strategy:
        dockerStrategy:
          from:
            kind: ImageStreamTag
            name: php-74:latest
        type: Docker
      triggers:
      - github:
          secret: bb3ZKLHH7hTfQ53Wc5me
        type: GitHub
      - generic:
          secret: 3G0Sc0NhPSuuFhlNGEQ6
        type: Generic
      - type: ConfigChange
      - imageChange: {}
        type: ImageChange
