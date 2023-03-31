# Curso 1: Aprende Kubernetes con OpenShift v4

1. Introducción a OpenShift v4
	* Implantación de aplicaciones web en contenedores
	* Contenedores de aplicación: Docker, Podman
	* Orquestadores de contenedores: Kubernetes
	* OpenShift. Ventajas y beneficios
	* Arquitectura de OpenShift v4
	* Plataformas para trabajar con OpenShift v4

2. Trabajando con OpenShift
	* RedHat OpenShift Dedicated: Developer Sandbox
	* Instalación el CLI de OpenShift: oc
	* Configuración de oc para el Developer Sandbox
	* Visión general de la consola web

3. OpenShift como distribución de Kubernetes
	* [Despliegues de aplicaciones en Kubernetes](modulo3/aplicaciones.md)
	* [Recursos que nos ofrece Openshift](modulo3/recursos.md)
	* [Trabajando con Pods](modulo3/pods.md)
	* [Trabajando con Pods desde la consola web](modulo3/pods_web.md)
	* [Ejemplo: Pod multicontenedor](modulo3/pod_multicontenedor.md)
	* [Tolerancia a fallos, escalabilidad, balanceo de carga: ReplicaSet](modulo3/replicaset.md)
	* [Trabajando con ReplicaSets desde la consola web](modulo3/replicaset_web.md)
	* [Desplegando aplicaciones: Deployment](modulo3/deployment.md)
	* [Actualización de un Deployment (*rollout* y *rollback*)](modulo3/actualizacion_deployment.md)
	* [Trabajando con Deployment desde la consola web](modulo3/deployment_web.md)
	* Otras cargas de trabajo

4. Acceso a las aplicaciones 

	* [Recursos que nos ofrece Openshift para el acceso a las aplicaciones](modulo4/recursos.md)
	* [Trabajando con Services](modulo4/services.md)
	* [Accediendo a las aplicaciones: ingress y routes](modulo4/routes.md)
	* [Servicio DNS en Kubernetes](modulo4/dns.md)
	* Accediendo a las aplicaciones desde la consola web

5. Despliegues parametrizados
	* Variables de entorno
    * ConfigMaps
    * Secrets
    * Ejemplo completo: Despliegue y acceso a Wordpress + MariaDB

6. Almacenamiento en OpenShift
	* Consideraciones sobre el almacenamiento
	* Volúmenes en Kubernetes
	* Aprovisionamiento de volúmenes
	* Solicitud de volúmenes
	* Uso de volúmenes
	* Ejemplo completo: Haciendo persistente la aplicación Wordpress

7. Ejemplo final: Citas
	* Despliegues de citas-backend
	* Despliegue de citas-frontend
	* Despliegue de la base de datos mariadb
	* Actualización de la aplicación citas-backend
	