# Introducción al despliegue de aplicaciones en OpenShift v4

## Recursos que nos ofrece OpenShift v4 para el despliegue de aplicaciones

* **Deployment**: Este recurso es igual al ofrecido por Kubernetes, y nos permite el despliegue y actualización de una aplicación, creando varias replicas de la misma y balanceando la carga a las distintas réplicas cuando accedemos a la aplicación.. 
* **DeploymentConfig**: Este recurso es propio de OpenShift. Es muy similar al recurso Deployment, por lo que de la misma manera, nos permite el despliegue y la actualización de aplicaciones. Tiene algunas diferencias con la anterior, por ejemplo la posibilidad de tener estrategias de despliegue configurables, o el uso de triggers para actualizar el despliegue.
* **Deployment Serverless**:  Es un recurso que permite desplegar aplicaciones sin tener que preocuparse por el número de réplicas en ejecución. En lugar de utilizar réplicas, la aplicación se ejecuta en un **pod autoscaling** que se adapta automáticamente según la demanda. **Deployment Serverless** es ideal para aplicaciones con fluctuaciones en el uso, como las aplicaciones web que experimentan una mayor carga durante los picos de tráfico.

OpenShift también nos permite desplegar aplicaciones que requieren de otras características usando recursos como el **StatefulSet**, **DaemonSet**, **Job**,...

## Métodos de despliegues en OpenShift

Una forma de trabajar con OpenShift es a partir de la definición de los recursos en fichero con formato YAML, y utilizar la herramienta de línea de comando **oc** (`oc apply...`) o la **consola web** para gestionar los recursos.

Sin embargo, lo que le da más potencialidad a OpenShift son los diferentes métodos de creación de despliegues de una forma automática. Esta funcionalidad es la que otorga a OpenShift las características de Cloud Computing PaaS, ya que nos ofrece la posibilidad de desplegar aplicaciones de una forma muy sencilla.

Los principales métodos de implementar una aplicación son:

* Desplegar una aplicación a partir de una **imagen ya existente**.
* **Source-to-Image (s2i)**: Construir de forma automática una nueva imagen a partir de una aplicación que tengamos guardada en un repositorio git. A partir de la imagen que genera de forma automática se despliega la aplicación. 
* Construir una nueva imagen generada a partir de un fichero **Dockerfile**, y desplegar la aplicación desde esa imagen construida.
* Desplegar aplicaciones a partir de plantillas.
* Desplegar aplicaciones desde un pipeline de IC/DC.

## Otros recursos de OpenShift involucrados en el despliegue de aplicaciones

Los métodos de despliegues anteriores se pueden usar en OpenShift desde la **consola web** o usando la herramienta de línea de comando **oc** (`oc new-app ...`). Al crea un aplicación con algunos de estos métodos podemos indicar si queremos usar los distintos recursos de despliegues que hemos visto anteriormente: **Deployment**, **DeploymentConfig** o **Deployment Serverless**. Si creamos un despliegue con la herramienta de línea de comando `oc`, por defecto se crea un recurso **Deployment**. Si creamos un despliegue con la consola web, podemos configurar el recurso que se crea por defecto.

En la creación de aplicaciones, se usan otros recursos de OpenShift:

* **ImageStreams**: Cuando se crea un despliegue con alguno de estos métodos, no se utiliza directamente una imagen que esta almacenada en un registro. Se utiliza un recurso llamado **ImageStream** que nos permite referenciar a las imágenes que tenemos en un registro externo o en el registro interno de imágenes de OpenShift. 
* **BuildConfig**: Cuando el método de despliegue conlleva la construcción automática de una imagen (s2i o Dockerfile), este recurso se utiliza para configurar el proceso de construcción de la imagen (build).
* **Build**: Cada vez que se hace una construcción automática de una imagen con la configuración del recurso **BuildConfig**, se creará un recurso del tipo **Build**. La construcción se realizará en un Pod cuyo nombre tendrá la palabra *build*.

## El catálogo de aplicaciones

En OpenShift v4, el **catálogo de aplicaciones** es una colección de software preempaquetado que se puede instalar y utilizar en un clúster de OpenShift. 

Esta formado por varios tipos de elemento, entre los que destacamos:

* **Builder Images**: Son imágenes de contenedor que usamos para crear nuevas imágenes. Tenemos distintos tipos, según el lenguaje de programación que implementan.
* **Templates**: Plantillas que nos permiten crear un conjunto de objetos relacionados. Suelen definir parámetros para personalizar los despliegues.
* **Helm Charts**: Helm es un software que nos permite empaquetar aplicaciones completas y gestionar el ciclo completo de despliegue de dicha aplicación. Helm usa un formato de empaquetado llamado **charts**. Un chart es una colección de archivos que describen un conjunto de recursos que nos permite desplegar una aplicación en Kubernetes o en OpenShift.
* ...
