# Instalación del CLI de OpenShift: oc

La herramienta `oc` nos permite gestionar los recursos de nuestro clúster de OpenShift desde la línea de comandos.

Para más información de esta herramienta puedes acceder a la [documentación oficial](https://docs.openshift.com/container-platform/4.12/cli_reference/openshift_cli/getting-started-cli.html).

Tenemos varios métodos de instalación de esta herrmienta, nostros vamos a hacerlo desde la consola web de OpenShift.

## Instalación de oc desde la consola web

Accedemos a la consola web y escogemos el icono de ayuda en la parte superior derecha, y posteriormente elegimos la opción **Command Line Tools**:

imagen1

Nos aparecerá una página donde podremos descargarnos las distintas veriosnes de la herramienta, en mi caso he escogido la versión Linux x86_64.

Nos descargamos un fichero comprimido `oc.tar`, lo descomprimimos y lo copiamos con permisos de ejecución en un directorio del PATH:

    tar xvf oc.tar
    sudo install oc /usr/local/bin

Y comprobamos la versión que hemos instalado:

    oc version
    Client Version: 4.12.0-202303081116.p0.g846602e.assembly.stream-846602e
    Kustomize Version: v4.5.7

Si ejecutamos cuelquier comando con la herramienta `oc` nos recurda que nos tenemos que loguear:

    oc get deploy
    error: You must be logged in to the server (Unauthorized)

    