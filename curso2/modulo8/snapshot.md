# Instantáneas de volúmenes

Un recurso **VolumeSnapshot** representa una instantánea de un volumen en un sistema de almacenamiento. Las instantáneas de volumen nos proporciona una forma estandarizada de copiar el contenido de un volumen en un momento determinado sin crear un volumen completamente nuevo.

Realmente un recurso **VolumeSnapshot** es una solicitud de instantánea de un volumen por parte de un usuario. Será necesio tener configurado un recurso **VolumeSnapshotClass**, donde el administrador del clúster habrá configurado diferentes características sobre al almacenamiento que está utilizando para que se realicen las instantáneas.

Eb la consola web, en la vista de **Administrator**, el apartado **Storage -> VolumeSnapshotClasses**, podemos ver los recursos **VolumeSnapshotClasses** que están definido en este clúster:

![snapshot](img/snapshot1.png)

Continuamos con en el ejemplo anterior, donde habíamos creado un objeto **PersistentVolumeClaim** asociado a un recurso **PersistentVolume**, que estaba asociado a un Deployment. A continuación vamos a crear una instantánea de ese volumen, para ello entramos en la sección **Storage -> VolumeSnapshots** y pulsamos sobre el botón **Create VolumeSnapshot**:

![snapshot](img/snapshot2.png)

A continuación indicamos el recurso **PersistentVolumeClaim** al que queremos crear la instantánea y el nombre de la misma:

![snapshot](img/snapshot3.png)

Y transcurridos unos segundos, podremos ver la lista de las instantáneas de volúmenes que hemos creado:

![snapshot](img/snapshot4.png)

Podemos eliminar el despliegue del servidor web y el volumen que hemos creado:

![snapshot](img/snapshot5.png)

![snapshot](img/snapshot6.png)

Ya que a partir de la instantánea podemos crear un nuevo volumen conb la misma información, para ello escogemos la opción:

![snapshot](img/snapshot7.png)

Indicando las propiedades del recurso **PersistentVolumeClaim**:

![snapshot](img/snapshot8.png)

Volvemos a crear el Deployment, y comprobamos que podemos acceder al fichero `index.html`, que en esta ocasión no hemos tenido que crear porque se ha restaurado desde la instantánea de volumen.

![volumen](img/volumen11.png)