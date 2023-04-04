# Gestionando el almacenamiento desde la consola web

Vamos a repetir el ejemplo visto en el punto anterior desde la consola web.

Lo primero será crear un objeto Deployment, para ello desde la vista **Administrator**, escogemos el apartado **Workloads -> Deployments** y pulsamos sobre el botón **Create Deployment**:

![volumen](img/volumen2.png)

Creamos el Deployment desde el formulario, indicando el nombre, la imagen y el número de pods que queremos desplegar:

![volumen](img/volumen3.png)

![volumen](img/volumen4.png)

Los recursos relacionados con el almacenamiento lo encontramos en la vista de **Administrator**, el apartado **Storage**. Por ejemplo ene apartado **StorageClasses** encontramos los recursos de este tipo definidos en este clúster:

![volumen](img/volumen5.png)

En el apartado **PersistentVolumeClaims** podemos gestionar este tipo de recursos, pulsando en el botón **Create PersistentVolumeClaim**, podemos crear un nuevo objeto:

![volumen](img/volumen55.png)

Creamos la solicitud de almacenamiento desde el formulario, indicando el nombre, el modo de acceso y el tamaño entre otras propiedades:

![volumen](img/volumen6.png)

Podemos ver la lista de recursos **PersistentVolumenClaim (PVC)**:

![volumen](img/volumen65.png)

Ahora tenemos que añadir a nuestro Deployment, el alamcenamiento que hemos solicitado, para ello nos vamos al detalle del recurso Deployment y escogemos la acción **Add storage**:

![volumen](img/volumen7.png)

Indicando el recurso **PersistentVolumenClaim (PVC)** que vamos a asociar, y el punto de montaje:

![volumen](img/volumen8.png)

Como ha cambiado la definición del objeto, se crear un nuevo pod con la nueva definición:

![volumen](img/volumen9.png)

A continuación, creamos el fichero `index.html` desde un terminal del pod que se está ejecutando:

![volumen](img/volumen10.png)

Y podemos acceder a la aplicación y comprobamos que está funcionando de forma adecuada:

![volumen](img/volumen11.png)