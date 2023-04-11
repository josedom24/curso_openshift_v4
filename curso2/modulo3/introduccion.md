# Introducción al despliegue de aplicaciones en OpenShift

## Recursos que nos ofrece OpenShift v4 para el despliegue de aplicaciones

* **Deployment**: Este recurso es igual al ofrecido por Kubernetes, y nos permite el despliegue y actualización de una aplicación, creando varias replicas de la misma y balanceando la carga a las distintas replicas cuando accedemos a la aplicación.. 
* **DeploymentConfig**: Este recurso es propio de OpenShift. Es muy similar al recurso Deployment, por lo que de la misma manera nos permite el despliegue y la actualización de aplicaciones. Tiene algunas diferencias con la anterior, por ejemplo la posibilidad de tener estrategias de despliegue configurables, o el uso de triggers para actualizar el despliegue.
* **Deployment Serverless**:  Es un recurso específico de OpenShift que permite desplegar aplicaciones sin tener que preocuparse por el número de réplicas en ejecución. En lugar de utilizar réplicas, la aplicación se ejecuta en un pod autoscaling que se adapta automáticamente según la demanda. Deployment Serverless es ideal para aplicaciones con fluctuaciones en el uso, como las aplicaciones web que experimentan una mayor carga durante los picos de tráfico.

OpenShift también nos permite desplegar aplicaciones que requieren de otras características usando recursos como el **StatefulSet**, **DaemonSet**, **Job**,...

## Métodos de despliegues en OpenShift

Una forma de trabajar con OpenShift es partir de la definición de los recursos en fichero con formato YAML, y utilizar la la herramienta de línea de comando **oc** (`oc apply...`) o la **consola web** para gestionar los recursos.

Sin embargo, lo que le da más potencialidad a OpenShift son los diferentes métodos de creación de despliegues de una forma automática. Esta funcionalidad es la que otorga a OpenShift las características de Cloud Computing PaaS, ya que nos ofrece la posibilidad de desplegar aplicaciones de una forma muy sencilla.

Los principales métodos de implementar una aplicación son:

* Desplegar una aplicación a partir de una **imagen ya existente**.
* **Source-to-Image (s2i)**: Construir de forma automática una nueva imagen a parir de una aplicación que tengamos guardada en un repositorio git. A partir de la imagen que genera de forma automática se despliega la aplicación. 
* Construir una nueva imagen generada a partir de un fichero **Dockerfile**, y desplegar la aplicación desde esa imagen construida.
* Desplegar aplicaciones a partir de plantillas.
* Desplegar aplicaciones desde un pipeline de IC/DC.

## Otros recursos de OpenShift involucrados en el despliegue de aplicaciones

Los métodos de despliegue anteriores se pueden usar en OpenShift desde la **consola web** o usando la herramienta de línea de comando **oc** (`oc new-app ...`). Al crea un aplicación con algunos de estos métodos podemos indicar si queremos usar los distintos recursos de despliegues que hemos visto anteriormente: **Deployment**, **DeploymentConfig** o **Deployment Serverless**. Desde la versión 4.5 por defecto se crea un recurso **Deployment**.

En la creación de aplicaciones además, se usan otros recursos de OpenShift:

* **ImageStreams**: Cuando se crea un despliegue con alguno de estaos métodos, no se utiliza directamente una imagen que esta en un registro. Se utiliza un recurso llamado **ImageStream** que nos permite referenciar a las imágenes que tenemos en un registro externo o en el registro interno de imágenes de OpenShift. 

    Los ImageStreams tienen varias ventajas sobre el uso directo de las imágenes de contenedores en un clúster de OpenShift:

    * **Control de versiones de las imágenes**: cada imagen se identifica por un nombre y una etiqueta, lo que facilita la gestión de versiones de las imágenes.
    * **Control de acceso a las imágenes**: Pueden configurarse para permitir o restringir el acceso a las imágenes según diferentes criterios, como el usuario, el grupo o el proyecto.
    * **Gestión centralizada de las imágenes**: Nos permite controlar y auditar el uso de imágenes de contenedores , independientemente del registro donde se localice la imagen real. Los registros puedes externos o interno al clúster de OpenShift.

* **BuildConfig**: Cuando el método de despliegue conlleva la construcción automática de una imagen (s2i o Dockerfile), este recurso se utiliza para configurar el proceso de construcción de la imagen (build).

