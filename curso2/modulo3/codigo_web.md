# Despliegue de aplicaciones desde código fuente desde la consola web

Vamos a realizar el mismo ejercicio pero desde la consola web. Para ello accedemos desde la vista **Developer** a la opción de **+Add** y elegimos el apartado **Git Repository**:

![codigoweb](img/codigoweb1.png)

## Despliegue de una página estática con un servidor apache2

Queremos construir una imagen con un servidor web a parir de un repositorio donde tenemos una página web estática, para ello vamos a configurar el despliegue:

![codigoweb](img/codigoweb2.png)

Indicamos el repositorio donde se encuentra la aplicación (`https://github.com/josedom24/osv4_html.git`). Y vemos que nos detecta la una **builder image** para construir la nueva imagen, pero no nos muestra la que nos recomienda. Como pasaba en el apartado anterior, OpenShift no puede determinar el lenguaje con el que está escrita la aplicación, por lo que tendremos nosotros que indicar la **Builder Image** que vamos a utilizar. Para ello pulsamos sobre ela opción **Edit Import Strategy**:

![codigoweb](img/codigoweb3.png)

Vemos que ha seleccionado la estrategia de construcción (**Builder Image**) pero, como indicabamos, no se ha seleccionado ninguna. Nosotros podemos seleccionar una imagen para construir la nueva imagen (en nuestro caso **Httpd**) y podemos elegir la versión de la imagen que hemos escogido.

Una vez lo hemos hecho, seguimos con la configuración de forma similar al despliegue de una imagen:

![codigoweb](img/codigoweb4.png)

* El nombre de la aplicación que nos va permitir agrupar distintos recursos con un mismo nombre.
* El nombre del despliegue.

Continuamos con la configuración:

![codigoweb](img/codigoweb5.png)

* El puerto donde se ofrece el servicio, normalmente es el 8080, pero dependerá de la imagen que estamos desplegando.
* Indicamos que se cree un objeto **Route** para acceder a la aplicación por medio de una URL.
* Pulsamos sobre la opción **Resource type** y elegimos **Deployment**.

Finalmente le damos al botón **Create** para crear el despliegue, esperamos unos segundo y accedemos al apartado **Topology** y comprobamos que se han creado los distintos recursos:

![codigoweb](img/codigoweb4.png)

Podemos ver que tenemos varias secciones el icono que representa el despliegue:

1. Representa la aplicación. Es una agrupación de recursos. Si borramos la aplicaciones, se borrarán todos los recursos.
2. Representa el **Deployment**: En la pabntalla lateral, podemos acceder a algunos de los recursos que se han creado.
3. Si pulsamos sobre "la flechita" se abrirá una nueva página web con la URL del objero **Route** que nos permitirá el acceso a la aplicación.

Si pulsamos sobre los tres puntos verticales del cuadro del **Deployment** o sobre el botón **Actions**, obtendremos un menú con todas las acciones que podemos realizar sobre el objeto:

![codigoweb](img/codigoweb5.png)

Nos queda por comprobar que se ha creado un objeto **ImageStream**, para ello en la vista **Administrator**, en la opción **Builds -> ImageStreams** la podemos encontrar:

![codigoweb](img/codigoweb6.png)

Al acceder a la URL de la ruta accedemos a la aplicación:

![codigoweb](img/codigoweb7.png)

Por último podemos borrar todos los recursos creado, eliminando la aplicación:

![codigoweb](img/codigoweb8.png)