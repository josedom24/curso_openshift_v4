# Uso de Helm en OpenShift desde la línea de comandos

Podemos instalar el cliente de Helm, para realizar la gestión de charts de Helm desde la línea de comandos.

## Instalación de Helm chart

Si accedemos ala consola web, en la parte superior derecha lel botón **?** y la opción **Command line tools**, nos parece la página web de descargar del Helm CLI: [Download Helm](https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/helm/latest/).

Podemos descargarnos la versión que necesitemos y copiar el binario en un directorio del PATH, por ejemplo en Linux:

    wget -O helm https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/helm/latest/helm-linux-amd64 
    sudo install helm /usr/local/bin

    helm version
    version.BuildInfo{Version:"v3.10.1+2.el8", GitCommit:"add6b4d0bfd122afc3ec403812efb2079ee5a2f0", GitTreeState:"clean", GoVersion:"go1.18.4"}

Aunque desde el cliente `helm` podemos gestionar el ciclo de visa de las aplicaciones instaladas en nuestro clúster:

    helm ls
    NAME   	NAMESPACE    	REVISION	UPDATED                                	STATUS  	CHART        	APP VERSION
    jenkins	josedom24-dev	1       	2023-05-02 16:17:51.373141711 +0000 UTC	deployed	jenkins-0.0.3	1.16.0     

Los repositorios de charts son independientes, es decir, no están sincronizados. Por ejemplo, cuando acabamos de instalar `helm` no tiene repositorios instalados:

    helm repo list
    Error: no repositories to show

Para añadir el repositorio de charts de OpenShift y actualizarlo, ejecutamos:

    helm repo add openshift https://charts.openshift.io/
    "openshift" has been added to your repositories

    helm repo update
    Hang tight while we grab the latest from your chart repositories...
    ...Successfully got an update from the "openshift" chart repository
    Update Complete. ⎈Happy Helming!⎈

Y ahora podemos buscar los charts ejecutando:

    helm search repo jenkins
    NAME                    	CHART VERSION	APP VERSION	DESCRIPTION                                       
    openshift/redhat-jenkins	0.0.3        	1.16.0     	Jenkins is an open source automation server whi...

Y para buscar información acerca de ese chart:

    helm show all openshift/redhat-jenkins

## Instalación de un chart helm desde la línea de comandos

