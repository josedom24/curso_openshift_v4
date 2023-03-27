# Cursos OpenShift v4

## Curso 1: Aprende Kubernetes con OpenShift v4

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

4. OpenShift como distribución de Kubernetes
	* Introducción a kubernetes
	* IMPORTANTE: Configurar permisos para poder ejecutar algunos contenedores
	* Ejecución de Pod en OpenShift
	* Tolerancia a fallos, escalabilidad, balanceo de carga
	* Desplegando aplicaciones: Deployment
	* Actualizaciones continúas/Rollback
	* Autoescalado: Escalado automático en OpenShift
	* Accediendo a las aplicaciones: services, ingress
	* Nuevo recurso de OpenShift para el acceso a las aplicaciones: Routes

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

7. Deployment us DeploymentConfig
	* Diferencias entre lso Deployments y los DeploymentConfig
	* Definición de un DeploymentConfig
	* Gestioanndo depliegues con el recurso DeploymentConfig
	* Actualizaciones continúas/Rollback con DeploymentConfig
	* Trigger de tipo Config Change. Cambiando la configuración.

8. Ejemplo final: Citas
	* Despliegues de citas-backend
	* Despliegue de citas-frontend
	* Despliegue de la base de datos mariadb
	* Actualización de la aplicación citas-backend
	

## Curso 2: Openshift v4 como PaaS

1. Introducción a OpenShift v4
	* Cloud Computing
	* PaaS: Plataforma como servicio
	* OpenShift como PaaS
	* Introducción a las estrategias de despliegues en OpsenShift v4

2. Trabajando con OpenShift
	* Distribución de la comunidad: okd
	* Instalación en local con crc
	* Configuración de oc para crc
	* Visión general de la consola web
	* Proyectos en OpenShift

3. Despliegue de aplicaciones en OpenShift
	* Despliegue de aplicaciones desde imágenes
	* Despliegue de aplicaciones desde código fuente
	* Despliegue de aplicaciones desde Dockerfile
	* Despliegue de aplicaciones desde el catálogo

4. ImageStreams
	* Introducción a los ImageStreams
	* Creación de ImageStreams
	* Gestión de etiquetas en un ImageStreams
	* Gestión de ImageStreams desde la consola web
	* Actualización de ImageStreams

5. Builds
	* Introducción a los BuildsConfig
	* Creación de un nuevo build
	* Ciclo de vida de los builds: iniciar, cancelar, parar, borrar, ...
	* Build desde un repositorio git
	* Build desde un Dockerfile
	* Build desde sistema de ficheros local
	* Actualización automática de build
	

6. Plantillas

	* Características de las plantillas
	* Crear objetos desde una plantilla en modo comando
	* Crear objetos desde una plantilla en modo WEB

7. Aspectos avanzados de OpenShift 
	
	* Despliegues de aplicaciones usando Helm
	* Serverless Deployment 
	* IC/DC: Despliegue de aplicaciones desde un pipeline
	* Integración con web IDE
	* ...
		





	
