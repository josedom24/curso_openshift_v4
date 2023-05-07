# CRC (CodeReady Containers)

**CRC (CodeReady Containers)** nos proporciona la posibilidad de realizar una instalación local de OpenShift v4, creando un clúster de un nodo que se ejecutará en una máquina virtual. Nos proporciona las siguientes características:

* El clúster de un sólo nodo lo administramos nosotros. Y podemos trabajar con usuarios con y sin permisos de administración.
* El uso de la plataforma no tiene ningún coste, y no tiene cuota de recursos, el clúster se ejecuta en una máquina virtual y los recursos serán los que asignemos a está máquina.
* No viene por defecto con todas las funcionalidades de OpenShift, pero usando el usuario administrador podemos instalar nuevas funcionalidades por medio de Operadores.
* Al tener un sólo nodo en el clúster, los volúmenes ofrecidos corresponden a directorios en el host. Es suficiente para simular el almacenamiento en un clúster con un único nodo, ya que todos los contenedores se ejecutan en la misma máquina.
