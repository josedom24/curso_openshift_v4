# Uso de Helm en OpenShift desde la línea de comandos

Podemos instalar el cliente de Helm, para realizar la gestión de charts de Helm desde la línea de comandos.

## Instalación de Helm chart

Si accedemos a la consola web, en la parte superior derecha lel botón **?** y la opción **Command line tools**, nos parece la página web de descargar del Helm CLI: [Download Helm](https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/helm/latest/).

Podemos descargarnos la versión que necesitemos y copiar el binario en un directorio del PATH, por ejemplo en Linux:

    wget -O helm https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/helm/latest/helm-linux-amd64 
    sudo install helm /usr/local/bin

    helm version
    version.BuildInfo{Version:"v3.10.1+2.el8", GitCommit:"add6b4d0bfd122afc3ec403812efb2079ee5a2f0", GitTreeState:"clean", GoVersion:"go1.18.4"}

Aunque desde el cliente `helm` podemos gestionar el ciclo de vida de las aplicaciones instaladas en nuestro clúster:

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

Podemos buscar más repositorios de charts buscando en la página [Artifact Hub](https://artifacthub.io/), por ejemplo podemos añadir el repositorio de charts de Bitnami de la siguiente manera:

    helm repo add bitnami https://charts.bitnami.com/bitnami
    "bitnami" has been added to your repositories

Y podemos comprobar que hemos añadido un nuevo repositorio:

    helm repo list
    NAME                	URL                                               
    openshift           	https://charts.openshift.io/      
    bitnami             	https://charts.bitnami.com/bitnami                

Actualizamos la lista de charts ofrecidos por los repositorios:

    helm repo update

Como hemos comentado anteriormente, los charts los podemos buscar en la página [Artifact Hub](https://artifacthub.io/) o los podemos buscar desde la línea de comandos, por ejemplo si queremos buscar un chart relacionado con nginx:

    helm search repo nginx
    NAME                   	CHART VERSION	APP VERSION	DESCRIPTION                                       
    bitnami/nginx         	14.1.0       	1.24.0     	NGINX Open Source is a web server that can be a...
    ...

Todos los ficheros yaml que forman parte de un chart están parametrizados, es decir cada propiedad tiene un valor por defecto, pero a la hora de instalarlo se puede cambiar. Por ejemplo, ¿qué tipo de **Service** se creará al instalar el chart `bitnami/nginx`? Por defecto, el parámetro `service.type` tiene como valor `LoadBalancer`, pero si queremos un **Service** de tipo `NodePort`, podremos redefinir este parámetro a la hora de instalar el chart.

¿Y cómo sabemos los parámetros que tiene definido cada chart y sus valores por defecto?. Estudiando la documentación del chart en Artifact Hub. En concreto para el chart con el que estamos trabajando, accediendo a su [página de de documentación](https://artifacthub.io/packages/helm/bitnami/nginx). También podemos obtener esta información ejecutando el siguiente comando:

    helm show all bitnami/nginx

Vamos a desplegar este chart modificando el parámetro `service.type` como `ClusterIP` ya que luego crearemos un recurso **Route** para acceder a él.

    helm install web bitnami/nginx --set service.type=ClusterIP 

Podemos listar los charts que tenemos instalados:

    helm ls
    NAME	NAMESPACE    	REVISION	UPDATED                                 	STATUS  	CHART       	APP VERSION
    web 	josedom24-dev	1       	2023-05-05 21:19:39.759567746 +0200 CEST	deployed	nginx-14.1.0	1.24.0  

Los nombres de los recursos que se han creado son del tipo `<nombre-instancia>-<nombre-chart>, por ejemplo:

    oc get all -o name
    service/web-nginx
    deployment.apps/web-nginx
    ...

Podemos crear la ruta de acceso:

    oc expose service/web-nginx

Y acceder para comprobar que funciona. Finalmente podemos borrar la aplicación desplegada con:

    helm uninstall web