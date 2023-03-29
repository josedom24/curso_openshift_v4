# Curso 1: Aprende Kubernetes con OpenShift v4

1. Introducción a OpenShift v4
	* Implantación de aplicaciones web en contenedores
	* Contenedores de aplicación: Docker, Podman
	* Orquestadores de contenedores: Kubernetes
	* OpenShift. Ventajas y beneficios
	* Arquitectura de OpenShift v4
	* Plataformas para trabajar con OpenShift v4

2. Trabajando con OpenShift
	* Trabajo online con OpenShift: Developer Sandbox
	* Instalación el CLI de OpenShift: oc
	* Configuración de oc para el Developer Sandbox
	* Visión general de la consola web

3. OpenShift como distribución de Kubernetes
	* Introducción a kubernetes
	* Recursos que nos ofrece Openshift
	* [Contenedores en OpenShift: Pod](modulo3/pod.md)
	* [Trabajando con Pods](modulo3/trabajando_pods.md)
	* [Trabajando con Pods desde la consola web](modulo3/trabajando_pods_web.md)
	* [Ejemplo: Pod multicontenedor](modulo3/pod_multicontenedor.yaml)
	* Tolerancia a fallos, escalabilidad, balanceo de carga: ReplicaSet
	* Desplegando aplicaciones: Deployment
	* Actualizaciones continúas/Rollback
	* Autoescalado: Escalado automático en OpenShift
	* Accediendo a las aplicaciones: services, ingress
	* Nuevo recurso de OpenShift para el acceso a las aplicaciones: Routes

4. Despliegues parametrizados
	* Variables de entorno
    * ConfigMaps
    * Secrets
    * Ejemplo completo: Despliegue y acceso a Wordpress + MariaDB

5. Almacenamiento en OpenShift
	* Consideraciones sobre el almacenamiento
	* Volúmenes en Kubernetes
	* Aprovisionamiento de volúmenes
	* Solicitud de volúmenes
	* Uso de volúmenes
	* Ejemplo completo: Haciendo persistente la aplicación Wordpress

6. Ejemplo final: Citas
	* Despliegues de citas-backend
	* Despliegue de citas-frontend
	* Despliegue de la base de datos mariadb
	* Actualización de la aplicación citas-backend
	