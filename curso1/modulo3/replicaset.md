# Tolerancia a fallos, escalabilidad, balanceo de carga: ReplicaSet

En este caso también vamos a definir el recurso de ReplicaSet en un fichero `replicaset.yaml`, por ejemplo como este:

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: replicaset-nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - image: bitnami/nginx
          name: contenedor-nginx
```

Algunos de los parámetros definidos ya lo hemos estudiado en la definición del Pod. Los nuevos parámetros de este recurso son los siguientes:

* `replicas`: Indicamos el número de Pods que siempre se deben estar ejecutando.
* `selector`: Seleccionamos los Pods que va a controlar el ReplicaSet por medio de las etiquetas. Es decir este ReplicaSet controla los Pods cuya etiqueta `app` es igual a `nginx`.
* `template`: El recurso ReplicaSet contiene la definición de un Pod. Fíjate que el Pod que hemos definido en la sección `template` tiene indicado la etiqueta necesaria para que sea seleccionado por el ReplicaSet (`app: nginx`).

## Creación del replicaset

De forma declarativa creamos el replicaset ejecutando:

    oc apply -f replicaset.yaml

Y podemos ver los recursos que se han creado con:

    oc get rs,pods

Observamos que queríamos crear 2 replicas del Pod, y efectivamente se han creado.

Si queremos obtener información detallada del recurso ReplicaSet que hemos creado:

    oc describe rs replicaset-nginx

## Tolerancia a fallos

Y ahora comenzamos con las funcionalidades llamativas de Kubernetes. ¿Qué pasaría si borro uno de los Pods que se han creado? Inmediatamente se creará uno nuevo para que siempre estén ejecutándose los Pods deseados, en este caso 2:

    oc delete pod <nombre_del_pod>
    oc get pods

## Escalabilidad

Para escalar el número de pods:

    oc scale rs replicaset-nginx --replicas=5
    oc get pods

Otra forma de hacerlo sería cambiando el parámetro `replicas` de fichero yaml, y volviendo a ejecutar:

    oc apply -f nginx-rs.yaml

La escalabilidad puede ser para aumentar el número de Pods o para reducirla:

    oc scale rs replicaset-nginx --replicas=1

## Eliminando el ReplicaSet

Por último, si borramos un ReplicaSet se borrarán todos los Pods asociados:

    oc delete rs replicaset-nginx

Otra forma de borrar el recurso, es utilizar el fichero yaml:

    oc delete -f replicaset.yaml