# Ejemplo 1: Gestión de almacenamiento desde la consola web: phpsqlitecms (1ª parte)

En este ejemplo, vamos a instalar un CMS PHP llamado **phpSQLiteCMS** que utiliza una base de datos SQLite. Para ello vamos a utilizar el código de la aplicación que se encuentra en el repositorio: `https://github.com/ilosuna/phpsqlitecms`.

Vamos a realizar el despliegue desde la línea de comandos:

    oc new-app php:7.3-ubi7~https://github.com/ilosuna/phpsqlitecms --name=phpsqlitecms
    oc expose service/phpsqlitecms

Se han creado los recursos:

![phpsqlitecms](img/phpsqlitecms1.png)

Y podemos acceder a la aplicación:

![phpsqlitecms](img/phpsqlitecms2.png)

## Modificación de la aplicación

A continuación, vamos a entrar en la zona de administración, en la URL `/cms`, y con el usuario y contraseña: `admin` - `admin` vamos a realizar un cambio (por ejemplo el nombre de la página) que se guardará en la base de datos SQLite.

![phpsqlitecms](img/phpsqlitecms3.png)

## Los contenedores son efímeros

**Los contenedores son efímeros**. La información que se guarda en ellos se pierde al eliminar el contenedor, además si tenemos varias réplicas de una misma aplicación (varios Pods) la información que se guarda en cada una de ellas es independiente. Vamos a comprobarlo:

1. Cuando escalemos nuestra aplicación se va a crear otro Pod con la base de datos inicial, en este nuevo Pod no tenemos el mismo contenido que el original.
2. Si realizamos un nuevo despliegue después de una actualización, los nuevos Pods perderán los datos de la base de datos.

## Volúmenes persistentes

Necesitamos un volumen para guardar los datos de la base de datos. Vamos a crear un volumen y lo vamos a montar en le directorio `/opt/app-root/src/cms/data`, que es donde se encuentra la base de datos. Para ello vamos a crear un objeto **PersistentVolumenClaim** que nos permitirá crear un **PersistentVolumen** que asociaremos al **Deployment**. Lo vamos a hacer desde la consola web, desde la vista **Administrator**, escogemos la opción **Storage -> PersistentVolumenClaims** y creamos un nuevo objeto:

![phpsqlitecms](img/phpsqlitecms4.png)

A continuación, añadimos almacenamiento al despliegue:

![phpsqlitecms](img/phpsqlitecms5.png)

Indicando el objeto **PersistentVolumenClaim** que hemos creado, y el directorio donde vamos a montar el volumen.

![phpsqlitecms](img/phpsqlitecms6.png)

Se ha actualizado el despliegue, se ha creado un nuevo Pod con la nueva versión (el volumen montado en el directorio) y podemos comprobar que el **PersistentVolumenClaim** se ha asociado con un **PersistentVolumen**:

![phpsqlitecms](img/phpsqlitecms12.png)

Accedemos a la aplicación para comprobar si funciona:

![phpsqlitecms](img/phpsqlitecms7.png)

La aplicación no está funcionando bien. ¿Qué ha pasado?. Al montar el volumen en el directorio `/opt/app-root/src/cms/data`, el contenido anterior, correspondiente a los ficheros de la base de datos se ha perdido. Tenemos que copiar en este directorio (en realidad en el volumen) los ficheros necesarios, para ello vamos a copiarlos desde el repositorio:

    git clone https://github.com/ilosuna/phpsqlitecms
    cd phpsqlitecms/cms

    oc get pod
    NAME                            READY   STATUS      RESTARTS   AGE
    phpsqlitecms-1-build            0/1     Completed   0          8m26s
    phpsqlitecms-687b8ff8cd-sqcdm   1/1     Running     0          6m17s

    oc cp data phpsqlitecms-687b8ff8cd-sqcdm:/opt/app-root/src/cms

Y volvemos a comprobar si está funcionando la aplicación:

![phpsqlitecms](img/phpsqlitecms2.png)

