# Recursos que nos ofrece Openshift

## Pods

**La unidad mínima de ejecución en OpenShift es el Pod**. De forma genérica, un Pod representa un conjunto de contenedores que comparten almacenamiento y una única IP. Al ejecutar un Pod, se ejecutan uno o varios contenedores, según las necesidades:

* En la mayoría de los casos y siguiendo el principio de un proceso por contenedor, un pod ejecutará un contenedor que ejecuta un sólo proceso.
* En determinadas circunstancias será necesario ejecutar más de un proceso en el mismo "sistema", como en los casos de procesos
  fuertemente acoplados, en esos casos, tendremos más de un   contenedor dentro del Pod. Cada uno de los contenedores ejecutando
  un solo proceso, pero pudiendo compartir almacenamiento y una misma dirección IP como si se tratase de un sistema ejecutando múltiples
  procesos. Ejemplo: servidor web nginx con un servidor de aplicaciones PHP-FPM.

Un aspecto muy importante que hay que ir asumiendo es que los Pods son **efímeros**, se lanzan y en determinadas circunstancias se paran o se destruyen, creando en muchos casos nuevos Pods que sustituyan a los anteriores. Esto tiene importantes ventajas a la hora de realizar modificaciones en los despliegues en producción, pero tiene una consecuencia directa sobre la información que pueda tener almacenada el Pod, por lo que tendremos que utilizar algún mecanismo adicional cuando necesitemos que la información sobreviva a un Pod.

