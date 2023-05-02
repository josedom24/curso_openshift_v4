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

oc project default
oc adm policy add-scc-to-user anyuid -z default

helm install wp bitnami/wordpress --set wordpressBlogName="Curso OpenShiift v4"

W0502 21:19:11.394096   34829 warnings.go:70] would violate PodSecurity "restricted:latest": unrestricted capabilities (container "mariadb" must set securityContext.capabilities.drop=["ALL"]), seccompProfile (pod or container "mariadb" must set securityContext.seccompProfile.type to "RuntimeDefault" or "Localhost")
NAME: wp
LAST DEPLOYED: Tue May  2 21:19:11 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: wordpress
CHART VERSION: 15.2.41
APP VERSION: 6.1.1

** Please be patient while the chart is being deployed **

Your WordPress site can be accessed through the following DNS name from within your cluster:

    wp-wordpress.default.svc.cluster.local (port 80)

To access your WordPress site from outside the cluster follow the steps below:

1. Get the WordPress URL by running these commands:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w wp-wordpress'

   export SERVICE_IP=$(kubectl get svc --namespace default wp-wordpress --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
   echo "WordPress URL: http://$SERVICE_IP/"
   echo "WordPress Admin URL: http://$SERVICE_IP/admin"

2. Open a browser and access WordPress using the obtained URL.

3. Login with the following credentials below to see your blog:

  echo Username: user
  echo Password: $(kubectl get secret --namespace default wp-wordpress -o jsonpath="{.data.wordpress-password}" | base64 -d)




oc get secret --namespace default wp-wordpress -o jsonpath="{.data.wordpress-password}" | base64 -d
