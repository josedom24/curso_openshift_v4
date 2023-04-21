# Estrategias de despliegues

Cuando se actualiza un despliegue, la manera en cómo se van eliminando los pods antiguos y se crean los nuevos, es lo que llamamos **estrategias de despliegue**. El objetivo, es el tiempo de inactividad sea lo más bajo posible. Lo que vamos a explicar sobre las estrategias de despliegues en este apartado, nos sirve tanto para los objetos **deployment** como para los objetos **DeploymentConfig**.

Vamos a estudiar dos tipos de estrategias:

## Estrategia Rolling Update

En este tipo de estrategia utiliza una implementación gradual y en cascada para actualizar los pods: se van creando los nuevos pods, se comprueba que funcionan, y posteriormente se van eliminando los pods antiguos. Es la estrategia por defecto. Veamos la configuración de esta estrategia, creando un **DeploymentConfig** a partir de la **ImageStream** `is-example` que tiene otras dos etqiuetas apuntando a las versiones:

    oc create is is_example
    oc import-image is_example:v1 --from=quay.io/openshifttest/deployment-example:v1
    oc import-image is_example:v2 --from=quay.io/openshifttest/deployment-example:v2
    oc tag is_example:v1 is_example:latest

    oc new-app is_example:latest --as-deployment-config=true --name=example

Ahora nos fijamos en la configuración de la estrategia en la definición del objeto:

    oc get dc example -o yaml

```yaml
strategy:
    activeDeadlineSeconds: 21600
    resources: {}
    rollingParams:
      intervalSeconds: 1
      maxSurge: 25%
      maxUnavailable: 25%
      timeoutSeconds: 600
      updatePeriodSeconds: 1
    type: Rolling
```

* `intervalSeconds`: El tiempo de espera entre la comprobación del estado de despliegue después de la actualización.
* `timeoutSeconds`: El tiempo de espera máximo para cada actualización de pod.
* `updatePeriodSeconds`: El tiempo de espera entre actualizaciones de pods individuales.Por defecto, 1 segundo.
* `maxSurge`: El número máximo de pods nuevos que se pueden crear por encima del número deseado de replicas.
* `maxUnavailable`: El número máximo de pods que se pueden eliminar simultáneamente.

Vamos a escalar el despliegue y a comprobar el acceso a la aplicación:

    oc scale dc/example --replicas=5
    oc expose service/example

![example](img/example1.png)

A continuación vamos a hacer la actualización del despliegue, para verlo bien puedes poner en una terminal la siguiente instrucción:

    watch oc get pods

Y en otra terminal actualizamos la etiqueta `latest` del **ImageStream** Para provocar el nuevo despliegue:

    oc tag -d is_example:latest
    oc tag is_example:v2 is_example:latest


Finalmente podemos comprobamos que tenemos desplegada la versión 2:

![example](img/example2.png)

En la cosnola web, también podemos ver la transición de los pods. En la vista **Developer**, la opción **Topology**, escogemos el bojeto **DeploymentConfig** y en las acciones elegimos **Start rollout**:

![example](img/example3.png)

## Estrategia Recreate

En algunas circunstancias, podemos necesitar eliminar todos los pods antiguos y posteriormente crear los nuevos. Este tipo de estrategia se denomina **Recreate**.

Vamos a modificar lel tipo de estrategia en nuestro **DeploymentConfig**:

    oc edit dc example

Y modificamos la sección `strategy` y la dejamos así:

```yaml
strategy:
    type: Recreate
```

Ahora vamos a volver a actualizar el despliegue a la versión 1 (recuerda tener en una terminal ejecutando `watch oc get pods` para ver como se eliminan todos los pods antes de crear los nuevos):

    oc tag -d is_example:latest
    oc tag is_example:v1 is_example:latest    

## Estrategia custom

A los objetos **DeploymentConfig** se el puede configurar una estrategia personalizada. [Más información](https://docs.openshift.com/container-platform/4.12/applications/deployments/deployment-strategies.html#deployments-custom-strategy_deployment-strategies).
