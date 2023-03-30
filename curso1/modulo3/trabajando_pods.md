# Trabajando con Pods

## Ejecución de Pods en OpenShift

Como veremos a continuación, para la ejecución de un Pod en OpenShift o Kubernetes, es necesario indicar las imágenes desde la que se van a crear los contenedores. OpenShift configura por defecto una política de seguridad que sólo nos permite ejecutar contenedores no privilegiados, es decir, donde no se ejecuten procesos o acciones por el usuario con privilegio `root` (por ejmplo, no utilizan puertos no privilegiados, puertos menores a 1024). 

Por esta razón, la mayoría de las imágenes que encontramos en el registro Docker Hub no funcionarán en OpenShift. Es por ello que es necesario usar imágenes de contenedores no privilegiados, por ejemplo creadas con imágenes constructoras (images builder) del propio OpenShift. En nuestro caso, en estos primeros ejemplos, vamos a usar imágenes generadas por la empresa Bitnami, que ya están preparadas para su ejecución en OpenShift.

Por último, indicar que al estar usando **OpenShift Online Developer Sandbox** está política de seguridad no la podemos cambiar, ya que no accedemos como usuario administrador. Sin embargo, si tenemos a nuestra disposición un clúster de OpenShift v4 administrador por nosotros, podemos cambiar esta política ejecutando con el usuario administrador la instrucción:

    oc adm policy add-scc-to-user anyuid -z <Nombre del Proyecto>

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
    * `labels`: Las [Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) nos permiten etiquetar los recursos de OpenShift (por ejemplo un pod) con información del tipo clave/valor.
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

## Otras operaciones con Pods

Podemos ver el estado en el que se encuentra y si está o no listo:

    oc get pods

**Nota:** Sería equivalente usar po, pod o pods.

Si queremos ver más información sobre los Pods, como por ejemplo, saber en qué nodo del cluster se está ejecutando:

    oc get pod -o wide

Para obtener información más detallada del Pod:

    oc describe pod pod-nginx

Podríamos editar el Pod y ver todos los atributos que definen el objeto, la mayoría de ellos con valores asignados automáticamente por el propio OpenShift y podremos actualizar ciertos valores:

    oc edit pod pod-nginx

Normalmente no se interactúa directamente con el Pod a través de una shell, pero sí se obtienen directamente los logs al igual que se hace
en docker:

    oc logs pod-nginx

En el caso poco habitual de que queramos ejecutar alguna orden adicional en el Pod, podemos utilizar el comando `exec`, por ejemplo,
en el caso particular de que queremos abrir una shell de forma interactiva:

    oc exec -it pod-nginx -- /bin/bash

Otra manera de acceder al pod:

    oc rsh pod-nginx

Podemos acceder a la aplicación, redirigiendo un puerto de localhost al puerto de la aplicación:

    oc port-forward pod-nginx 8080:80

Y accedemos al servidor web en la url http://localhost:8080.

**NOTA**: Esta no es la forma con la que accedemos a las aplicaciones en OpenShift. Para el acceso a las aplicaciones usaremos un recurso llamado Service. Con la anterior instrucción lo que estamos haciendo es una redirección desde localhost el puerto 8080 al puerto 80 del Pod y es útil para pequeñas pruebas de funcionamiento, nunca para acceso real a un servicio.

Para obtener las etiquetas de los Pods que hemos creado:

    oc get pods --show-labels

Las etiquetas las hemos definido en la sección metadata del fichero yaml, pero también podemos añadirlos a los Pods ya creados:

    oc label pods pod-nginx service=web --overwrite=true

Las etiquetas son muy útiles, ya que permiten seleccionar un recurso determinado (en el clúster puede haber cientos o miles de objetos). Por ejemplo para visualizar los Pods que tienen una etiqueta con un determinado valor:

    oc get pods -l service=web

También podemos visualizar los valores de las etiquetas como una nueva
columna:

    oc get pods -Lservice

Y por último, eliminamos el Pod mediante:

    oc delete pod pod-nginx
