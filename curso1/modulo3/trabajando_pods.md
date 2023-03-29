# Trabajando con Pods

## Creación de Pods

De forma **imperativa** podríamos crear un Pod, ejecutando:

    oc run pod-nginx --image=bitnami/nginx

Pero, normalmente necesitamos indicar más parámetros en la definición de los recursos. Además, sería deseable crear el Pod de forma **declarativa**, es decir indicando el estado del recurso que queremos obtener. Para ello, definiremos el recurso, en nuestro caso el Pod, en un fichero de texto en formato **YAML**. Por ejemplo, podemos tener el fichero `pod.yaml`:

```yaml
apiVersion: v1 
kind: Pod 
metadata: 
 name: pod2-nginx 
 namespace: josedom24-dev
 labels:
   app: nginx
   service: web
spec: 
 containers:
   - image: bitnami/nginx
     name: contenedor-nginx
     imagePullPolicy: Always
```

Veamos cada uno de los parámetros que hemos definido:

* `apiVersion: v1`: La versión de la API que vamos a usar.
* `kind: Pod`: La clase de recurso que estamos definiendo.
* `metadata`: Información que nos permite identificar unívocamente el recurso:
    * `name`: Nombre del pod.
    * `namespace`: Proyecto donde se va a crear el recurso. Si no se indica este parámetro se creará en el proyecto activo.
    * `labels`: Las [Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) nos permiten etiquetar los recursos de Kubernetes (por ejemplo un pod) con información del tipo clave/valor.
* `spec`: Definimos las características del recurso. En el caso de un Pod indicamos los contenedores que van a formar el Pod (sección `containers`), en este caso sólo uno.
    * `image`: La imagen desde la que se va a crear el contenedor
    * `name`: Nombre del contenedor.
    * `imagePullPolicy`: Si creamos un contenedor, necesitamos tener descargada en un registro interno la imagen. Existe una política de descarga de estas imágenes:
        * La política por defecto es `IfNotPresent`, que se baja la imagen si no está en el registro interno.
        * Si queremos forzar la descarga desde el repositorio externo, indicaremos el valor `Always`.
        * Si estamos seguro que la imagen esta en el registro interno, y no queremos bjar la imagen del registro externo, indecamos el valor `Never`.

Ahora para crear el Pod a partir del fichero yaml, podemos usar dos subcomandos:

* `create`: **Configuración imperativa de objetos**, creamos el objeto (en nuestro caso el pod) pero si necesitamos modificarlo tendremos que eliminarlo y volver a crearlo después de modificar el fichero de definición.

    oc create -f pod.yaml

* `apply`: **Configuración declarativa de objetos**, el fichero indica el estado del recurso que queremos tener. Al aplicar los cambios, se realizarán todas las acciones necesarias para llegar al estado indicado. Por ejemplo, si no existe el objeto se creará, pero si existe el objeto, se modificará.

    oc apply -f pod.yaml
