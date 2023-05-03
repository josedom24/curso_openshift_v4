# Tolerancia a fallos, escalabilidad, balanceo de carga: ReplicaSet

Para trabajar con los objetos **ReplicaSet** vamos a seguir trabajando con el usuario `developer` pero vamos a crear un nuevo proyecto:

    oc new-project proyecto-rs

En este caso también vamos a definir el recurso de **ReplicaSet** en un fichero `replicaset.yaml`, por ejemplo como este:

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
* `selector`: Seleccionamos los Pods que va a controlar el **ReplicaSet** por medio de las etiquetas. Es decir este **ReplicaSet** controla los Pods cuya etiqueta `app` es igual a `nginx`.
* `template`: El recurso **ReplicaSet** contiene la definición de un Pod. Fíjate que el Pod que hemos definido en la sección `template` tiene indicado la etiqueta necesaria para que sea seleccionado por el **ReplicaSet** (`app: nginx`).

## Creación del ReplicaSet

De forma declarativa creamos el **ReplicaSet** ejecutando:

    oc apply -f replicaset.yaml

Y podemos ver los recursos que se han creado con:

    oc get rs,pods

Observamos que queríamos crear 2 replicas del Pod, y efectivamente se han creado.

Si queremos obtener información detallada del recurso **ReplicaSet** que hemos creado:

    oc describe rs replicaset-nginx

### Política de seguridad del Pod

Al crear el **RepicaSet** nos da un warning, de este estilo: 

```
Warning: would violate PodSecurity "restricted:v1.24": allowPrivilegeEscalation != false (container "httpd" must set securityContext.allowPrivilegeEscalation=false), unrestricted capabilities (container "httpd" must set securityContext.capabilities.drop=["ALL"]), runAsNonRoot != true (pod or container "httpd" must set securityContext.runAsNonRoot=true), seccompProfile (pod or container "httpd" must set securityContext.seccompProfile.type to "RuntimeDefault" or "Localhost")
```

Este warning indica que el contenedor `contenedor-nginx` no cumple con algunas de las restricciones de seguridad establecidas en la política de seguridad.

Las restricciones que se indican en el warning son:

* `allowPrivilegeEscalation != false`: Este parámetro debe ser false, lo que impide que el contenedor pueda obtener más privilegios de los que se le han asignado.
* `unrestricted capabilities`: Esto significa que el contenedor debe establecer `securityContext.capabilities.drop=["ALL"]` para eliminar todas las capacidades adicionales del contenedor que no son necesarias.
* `runAsNonRoot != true`: Este parámetro debe ser true para garantizar que el contenedor se ejecute como un usuario no privilegiado.
* `seccompProfile`: Esto significa que el pod o el contenedor deben establecer `securityContext.seccompProfile.type en "RuntimeDefault"` o `"Localhost"` para garantizar que la política de seguridad de Seccomp esté configurada adecuadamente. Seccomp (modo de computación segura), es una característica del kernel de Linux que se puede utilizar para limitar el proceso que se ejecuta en un contenedor para que sólo llame a un subconjunto de las llamadas al sistema disponibles.

### Solución 1: Actualizar la definición del pod para indicar el contento de seguridad

Para resolver este warning, debe actualizar la definición del pod o del contenedor para cumplir con estas restricciones de seguridad. 

```yaml
    spec:
      containers:
        - image: bitnami/nginx
          name: contenedor-nginx
          securityContext:
            runAsNonRoot: true
            allowPrivilegeEscalation: false
            seccompProfile:
              type: RuntimeDefault
            capabilities:
              drop:
              - ALL
```

### Solución 2: Otorgar privilegios para ejecutar pod privilegiados

Muchas de las interacciones que se hacen sobre la API de OpenShift se realizan por el usuario final, pero muchas otras se hacen internamente. Para hacer estas últimas peticiones a la API se utiliza una cuenta especial de usuario, que se llaman **Service Account**.

OpenShift crea automáticamente algunas **Service Account** en cada proyecto. Por ejemplo, hay una **Service Account** que se llama **default** y será la responsable de ejecutar los pods.

Vamos a modificar los privilegios de ejecución al **Service Account** llamado `default`, para ello:

    oc login -u kubeadmin -p 7CCZB-XLaxk-ELS2G-GrGaw https://api.crc.testing:6443
    oc project proyecto-rs
    oc adm policy add-scc-to-user anyuid -z default

* Esta instrucción agrega el restricción de seguridad llamada **anyuid** al **ServiceAccount** predeterminado (`default`) en tu proyecto actual de OpenShift.
* La restricción **anyuid** permite a los contenedores en el pod ejecutarse con privilegios.

Esta segunda opción la utilizaremos más adelante para poder ejecutar pods privilegiados.

## Tolerancia a fallos

¿Qué pasaría si borro uno de los Pods que se han creado? Inmediatamente se creará uno nuevo para que siempre estén ejecutándose los Pods deseados, en este caso 2:

    oc delete pod <nombre_del_pod>
    oc get pods

## Escalabilidad

Para escalar el número de pods:

    oc scale rs replicaset-nginx --replicas=5
    oc get pods
    NAME                     READY   STATUS    RESTARTS   AGE
    replicaset-nginx-88rzr   1/1     Running   0          9s
    replicaset-nginx-gq8bs   1/1     Running   0          10m
    replicaset-nginx-lrmwb   1/1     Running   0          9s
    replicaset-nginx-wmcj6   1/1     Running   0          10m
    replicaset-nginx-xzdq8   1/1     Running   0          9s


Otra forma de hacerlo sería cambiando el parámetro `replicas` de fichero yaml, y volviendo a ejecutar:

    oc apply -f nginx-rs.yaml

La escalabilidad puede ser para aumentar el número de Pods o para reducirla:

    oc scale rs replicaset-nginx --replicas=1

## Eliminando el ReplicaSet

Por último, si borramos un ReplicaSet se borrarán todos los Pods asociados:

    oc delete rs replicaset-nginx

Otra forma de borrar el recurso, es utilizar el fichero yaml:

    oc delete -f replicaset.yaml