# Desplegando aplicaciones: Deployment

Para trabajar con los objetos **Deployment** vamos a seguir trabajando con el usuario `developer` pero vamos a crear un nuevo proyecto:

    oc new-project proyecto-deploy

Podemos crear un **Deployment** de forma imperativa utilizando un comando como el siguiente:

    oc create deployment nginx --image bitnami/nginx

Nosotros, sin embargo, vamos a seguir describiendo los recursos en un fichero yaml. En este caso para describir un **Deployment** de nginx podemos escribir un fichero `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment-nginx
  labels:
    app: nginx
spec:
  revisionHistoryLimit: 2
  strategy:
    type: RollingUpdate
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
        name: contendor-nginx
        ports:
        - name: http
          containerPort: 8080
```

La creación de un **Deployment** crea un **ReplicaSet** y los Pods correspondientes. Por lo tanto en la definición de un **Deployment** se define también el **ReplicaSet** asociado (los parámetros `replicas`, `selector` y `template`). Los atributos relacionados con el **Deployment** que hemos indicado en la definición son:

* `revisionHistoryLimit`: Indicamos cuántos **ReplicaSets** antiguos deseamos conservar, para poder realizar rollback a estados anteriores. Por defecto, es 10.
* `strategy`: Indica el modo en que se realiza una actualización del Deployment. Es decir, cuando modificamos la versión de la imagen del Deployment, se crea un ReplicaSet nuevo y ¿qué hacemos con los Pods?:
    * `Recreate`: elimina los Pods antiguos y crea los nuevos.
    * `RollingUpdate`: va creando los nuevos Pods, comprueba que funcionan y se eliminan los antiguos; es la opción por defecto.

Además, hemos introducido un nuevo parámetro al definir el contenedor del pod: con el parámetro `ports` hemos indicado el puerto que expone el contenedor (`containerPort`) y le hemos asignado un nombre (`name`).

Para crear el deployment desde el dichero, ejecutamos:

    oc apply -f deployment.yaml
    oc get deploy,rs,pod

Para ver los recursos que hemos creado también podemos utilizar la instrucción:

    oc get all

### Política de seguridad del Pod

Al crear el **Deployment** nos da un warning igual que en el apartado anterior, al crear un **ReplicaSet**. De la misma menra que vimos en el apartado anterior, tenemos dos posibles soluciones:

1. Actualizar la definición del Pod para indicar el contento de seguridad.
2. Otorgar privilegios para ejecutar Pod privilegiados, para ello:
    
        oc login -u kubeadmin https://api.crc.testing:6443
        oc project proyecto-deploy
        oc adm policy add-scc-to-user anyuid -z default

## Escalado de los Deployments

Como ocurría con los **ReplicaSets**, los **Deployments** también se pueden escalar, aumentando o disminuyendo el número de Pods asociados. Al escalar un **Deployment** estamos escalando el **ReplicaSet** asociado en ese momento:

    oc scale deployment/deployment-nginx --replicas=4

## Otras operaciones

Si queremos acceder a la aplicación, podemos utilizar la opción de `port-forward` sobre el despliegue (de nuevo recordamos que no es la forma adecuada para acceder a un servicio que se ejecuta en un Pod, pero de momento no tenemos otra). En este caso si tenemos asociados más de un Pod, la redirección de puertos se hará sobre un solo Pod (no habrá balanceo de carga):

    oc port-forward deployment/deployment-nginx 8080:80

Si queremos ver los logs generados en los Pods de un **Deployment**:

    oc logs deployment/deployment-nginx

Si queremos obtener información detallada del recurso **Deployment** que hemos creado:

    oc describe deployment/deployment-nginx

## Eliminando el Deployment

Si eliminamos el **Deployment** se eliminarán el **ReplicaSet** asociado y los Pods que se estaban gestionando.

    oc delete deployment/deployment-nginx

O también, usando el fichero:

    oc delete -f deployment.yaml