# Contenedores en OpenShift: Pod

**La unidad mínima de ejecución en OpenShift es el Pod**. De forma genérica, un Pod representa un conjunto de contenedores que comparten almacenamiento y una única IP. Al ejecutar un Pod, se ejecutan uno o varios contenedores, según las necesidades:

* En la mayoría de los casos y siguiendo el principio de un proceso por contenedor, un pod ejecutará un contenedor que ejecuta un sólo proceso.
* En determinadas circunstancias será necesario ejecutar más de un proceso en el mismo "sistema", como en los casos de procesos
  fuertemente acoplados, en esos casos, tendremos más de un   contenedor dentro del Pod. Cada uno de los contenedores ejecutando
  un solo proceso, pero pudiendo compartir almacenamiento y una misma dirección IP como si se tratase de un sistema ejecutando múltiples
  procesos. Ejemplo: servidor web nginx con un servidor de aplicaciones PHP-FPM.

Un aspecto muy importante que hay que ir asumiendo es que los Pods son **efímeros**, se lanzan y en determinadas circunstancias se paran o se destruyen, creando en muchos casos nuevos Pods que sustituyan a los anteriores. Esto tiene importantes ventajas a la hora de realizar modificaciones en los despliegues en producción, pero tiene una consecuencia directa sobre la información que pueda tener almacenada el Pod, por lo que tendremos que utilizar algún mecanismo adicional cuando necesitemos que la información sobreviva a un Pod.

## Ejecución de Pods en OpenShift

Como veremos a continuación, para la ejecución de un Pod en OpenShift o Kubernetes, es necesario indicar las imágenes desde la que se van a crear los contenedores. OpenShift configura por defecto una política de seguridad que sólo nos permite ejecutar contenedores no privilegiados, es decir, donde no se ejecuten procesos oo acciones por el usuario con privilegio `root`. 

Por esta razón, la mayoría de las imágenes que encontramos en el registro Docker Hub no funcionarán en OpenShift. Es por ello que es necesario usar imágenes de contenedores no privilegiados, por ejemplo creadas con imágenes constructoras (images builder) del propio OpenShift. En nuestro caso, en estos primeros ejemplos, vamos a usar imágenes generadas por la empresa Bitnami, que ya están preparadas para su ejecución en OpenShift.

Por último, indicar que al estar usando **OpenShift Online Developer Sandbox** está política de seguridad no la podemos cambiar, ya que no accedemos como usuario administrador. Sin embargo, si tenemos a nuestra disposición un clúster de OpenShift v4 administrador por nosotros, podemos cambiar esta política ejecutando con el usuario administrador la instrucción:

    oc adm policy add-scc-to-user anyuid -z <Nombre del Proyecto>



