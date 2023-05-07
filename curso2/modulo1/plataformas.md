# Plataformas para trabajar con OpenShift v4

Tenemos varias soluciones para trabajar con OpenShift v4:

* [Cloud Services Editions](https://www.redhat.com/en/technologies/cloud-computing/openshift#cloud-services-editions): Clúster de OpenShift en la nube pública. Los proveedores disponibles son: **AWS, Microsoft Azure, o IBM**.
* [Self-Managed Editions](https://www.redhat.com/en/technologies/cloud-computing/openshift#self-managed): Clúster de OpenShift en infraestructura privada.
* [Dedicated](https://www.redhat.com/en/technologies/cloud-computing/openshift/dedicated): Esta opción es una combinación de las dos opciones anteriores, que ofrece una infraestructura dedicada y completamente administrada por Red Hat. Estas opciones nos permiten hacer una prueba de la plataforma: [Try Red Hat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift/try-it).
    * **Developer Sandbox**: Nos permite probar OpenShift v4 usando un usuario sin privilegios, en un clúster administrador por Red Hat. 
    * **Managed Services**: Clúster de OpenShift en servidores de servicios cloud (AWS o Google) que son propiedad del usuario. 
    * **Self-managed**: Clúster de OpenShift en servidores propios.
* [OKD (Origin Community Distribution)](https://www.okd.io/): OKD es la versión impulsada por la comunidad de OpenShift que está disponible de forma gratuita y es totalmente de código abierto.
* [CRC (CodeReady Containers)](https://developers.redhat.com/products/openshift-local/overview): CRC es una versión ligera y portátil de OpenShift que se puede ejecutar en un ordenador personal. 

## Developer Sandbox y CRC

**RedHat OpenShift Dedicated Developer Sandbox** y **CRC (CodeReady Containers)** son las opciones que vamos a usar en este curso.

### RedHat OpenShift Dedicated Developer Sandbox

La versión **Developer Sandbox** de **OpenShift Dedicated** nos permite probar OpenShift v4 en una plataforma con las siguientes características:

* Accedemos a un clúster de OpenShift administrado por Red Hat. Tenemos a nuestra disposición un proyecto para trabajar con un usuario sin privilegios.
* El uso de esta plataforma no tiene ningún coste (no hace falta introducir la tarjeta de crédito para darte de alta).
* Para acceder a la plataforma es necesario tener una cuenta en el portal de Red Hat y es necesario validar tu número de teléfono.
* El periodo de uso es de un mes. Una vez terminada la prueba se borrará el proyecto, pero siempre puedes volver a crear uno nuevo para tener otro mes de prueba.
* Nos ofrece la mayoría de las funcionalidades de OpenShift. Aunque como es administrada por Red Hat, si falta alguna funcionalidad no podemos instalarla.
* La cuota de recursos que podemos usar en nuestro proyecto es de 7 GB RAM, y 15 GB de almacenamiento.
* La idea es que no se utilice esta plataforma como entorno de producción, por lo que las aplicaciones se paran a las 12 horas de su creación. Aunque siempre podemos volver a activarlas.
* La plataforma está implementada sobre un clúster de instancias de AWS. En este caso, cuando trabajemos con el almacenamiento tendremos a nuestra disposición los medios de almacenamiento que ofrece el proveedor: AWS Elastic Block Store (EBS).
* Al usar un usuario sin privilegios, no tendremos acceso a algunos recursos: la gestión de proyectos, los nodos del clúster, los volúmenes de almacenamiento,...

### CRC (CodeReady Containers)

**CRC** nos proporciona la posibilidad de realizar una instalación local de OpenShift v4, creando un clúster de un nodo que se ejecutará en una máquina virtual. Nos proporciona las siguientes características:

* El clúster de un sólo nodo lo administramos nosotros. Y podemos trabajar con usuarios con y sin permisos de administración.
* El uso de la plataforma no tiene ningún coste, y no tiene cuota de recursos, el clúster se ejecuta en una máquina virtual y los recursos serán los que asignemos a está máquina.
* No viene por defecto con todas las funcionalidades de OpenShift, pero usando el usuario administrador podemos instalar nuevas funcionalidades por medio de Operadores.
* Al tener un sólo nodo en el clúster, los volúmenes ofrecidos corresponden a directorios en el host. Es suficiente para simular el almacenamiento en un clúster con un único nodo, ya que todos los contenedores se ejecutan en la misma máquina. 

## ¿Qué plataforma vamos a usar en este curso?

En este curso vamos a usar principalmente **RedHat OpenShift Dedicated Developer Sandbox**, aunque algunos ejercicios lo vamos a realizar sobre **CRC** por alguna característica específica, por ejemplo, por poder utilizar un usuario con permisos administrativos.

Hay que tener en cuenta que la mayoría de ejercicios que vamos a realizar en el curso se pueden desarrollar indistintamente en las dos plataformas.