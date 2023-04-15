# Curso 2: Openshift v4 como PaaS

1. Introducción a OpenShift v4
	* Cloud Computing
	* PaaS: Plataforma como servicio
	* OpenShift como PaaS
	* RedHat OpenShift Dedicated Developer Sandbox

2. Despliegue de aplicaciones en OpenShift
	* [Introducción al despliegue de aplicaciones en OpenShift](modulo2/introduccion.md)
	* [Despliegue de aplicaciones desde imágenes con oc](modulo2/imagen.md)
	* Despliegue de aplicaciones desde imágenes desde la consola web
	* [Despliegue de aplicaciones desde código fuente con oc](modulo2/codigo.md	)
	* Despliegue de aplicaciones desde código fuente desde la consola web
	* [Despliegue de aplicaciones desde Dockerfile con oc](modulo2/dockerfile.md)
	* Despliegue de aplicaciones desde Dockerfile desde la consola web
	* Despliegue de aplicaciones desde el catálogo con oc (Base de datos??? Hay que explicar antes el catalogo y el uso de template)
	* Despliegue de aplicaciones desde el catálogo desde la consola web

3. Deployment us DeploymentConfig
	* Características de DeployConfig
	* Creación de un DeployConfig al crear una aplicación
	* Definición de un recurso DeploymentConfig
	* Ciclo de vida de un DeploymentConfig
	* Actualización de un DeploymentConfig (*rollout* y *rollback*)
	* Trabajando con DeploymentConfig desde la consola web
	* Triggers
	

4. ImageStreams
	* Introducción al recurso ImageStream
	* ImageStream a imágenes del registro interno
	* Creación de ImageStream al crear una nueva aplicación
	* Creación de ImageStream a una imagen externa
	* Creación de ImageStream desde un YAML
	* Gestión de ImageString desde la consola web
	* Gestión de las etiqueta en un ImageStream
	* Actualización automática de ImageStream

5. Builds: Construcción automática de imágenes
	* Introducción a la construcción automática de imágenes (build)
	* El recurso BuildConfig
	* Creación del recurso BuildConfig con new-build desde el código fuente
	* Ciclo de vida del recurso BuildConfig
	* Creación del recurso BuildConfig desde un fichero Dockerfile
	* Creación del recurso BuildConfig desde un directorio local
	* Gestión de builds desde la consola web
	* Actualización automática de un build

6. Ejemplos de despliegues de aplicaciones web

	* Despliegue de aplicaciones Python en OpenShift: guestbook
	* Aplicación python guestbook con con almacenamiento persistente
	* Despliegue de aplicaciones PHP en OpenShift (phpsqlitecms)
	* Despliegue de aplicaciones PHP en OpenShift con almacenamiento persistente

7. Plantillas

	* Características de las plantillas
	* Crear objetos desde una plantilla en modo comando
	* Crear objetos desde una plantilla en modo WEB

8. Aspectos avanzados de OpenShift ????
	
	* Serverless Deployment 
	* IC/DC
	* Integración con web IDE
	* ...
		
9. Trabajando con OpenShift en local
	* IMPORTANTE: Configurar permisos para poder ejecutar algunos contenedores
	* Distribución de la comunidad: okd
	* Instalación en local con crc
	* Configuración de oc para crc
	* Visión general de la consola web
	* Proyectos en OpenShift
	* Almacenamiento en crc




	
