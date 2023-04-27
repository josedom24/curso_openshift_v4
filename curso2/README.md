# Curso 2: Openshift v4 como PaaS

1. Introducción a OpenShift v4
	* Cloud Computing
	* PaaS: Plataforma como servicio
	* OpenShift como PaaS
	* Plataformas para trabajar con OpenShift v4

2. Trabajando con OpenShift en local
	* Distribución de la comunidad: okd
	* Instalación en local con crc
	* Configuración de oc para crc
	* Visión general de la consola web
	* Proyectos en OpenShift
	* Almacenamiento en crc
	* [Ejecución de pods privilegiados](modulo2/pods_privilegiados.md)

3. Despliegue de aplicaciones en OpenShift
	* [Introducción al despliegue de aplicaciones en OpenShift](modulo3/introduccion.md)
	* [Despliegue de aplicaciones desde imágenes con oc](modulo3/imagen.md)
	* [Despliegue de aplicaciones desde imágenes desde la consola web](modulo3/imagen_web.md)
	* [Despliegue de aplicaciones desde código fuente con oc](modulo3/codigo.md	)
	* [Despliegue de aplicaciones desde código fuente desde la consola web](modulo3/codigo_web.md)
	* [Despliegue de aplicaciones desde Dockerfile con oc](modulo3/docker.md)
	* [Despliegue de aplicaciones desde Dockerfile desde la consola web](modulo3/docker_web.md)
	* [Despliegue de aplicaciones desde el catálogo con oc](modulo3/catalogo.md)
	* [Despliegue de aplicaciones desde el catálogo desde la consola web](modulo3/catalogo_web.md)

4. ImageStreams: Gestión de imágenes en OpenShift v4
	* [Introducción al recurso ImageStream](modulo4/introduccion.md)
	* [ImageStream a imágenes del registro interno](modulo4/registro_interno.md)
	* [Creación de ImageStream](modulo4/crear_is.md)
	* [Gestión de ImageStream desde la consola web](modulo4/is_web.md)
	* [Gestión de las etiquetas en un ImageStream](modulo4/etiquetas.md)
	* [Actualización automática de ImageStream](modulo4/update.md)

5. Builds: Construcción automática de imágenes
	* [Introducción a la construcción automática de imágenes (build)](modulo5/build.md)
	* [Construcción de imágenes con estrategia Source-to-image (S2I) + repositorio Git](modulo5/s2i.md)
	* [Construcción de imágenes con estrategia Docker + repositorio Git](modulo5/docker.md)
	* [Definición del objeto BuildConfig](modulo5/buildconfig.md)
	* [Actualización manual de un build](modulo5/actualizacion.md)
	* [Construcción de imágenes desde ficheros locales](modulo5/binary.md)
	* [Construcción de imágenes con Dockerfile en línea](modulo5/dockerfile_inline.md)
	* [Gestión de builds desde la consola web](modulo5/build_web.md)
	* [Actualización automática de un build](modulo5/imagechange.md)
	* [Actualización automática de un build por trigger webhook](modulo5/webhook.md)

6. Deployment us DeploymentConfig
	* [Características del recurso DeploymentConfig](modulo6/dc.md)
	* [Creación de un DeployConfig al crear una aplicación](modulo6/newdc.md)
	* [Definición de un recurso DeploymentConfig](modulo6/deploymentconfig.md)
	* [Actualización de un DeploymentConfig (rollout)](modulo6/rollout.md)
	* [Rollback de un DeploymentConfig](modulo6/rollback.md)
	* [Trabajando con DeploymentConfig desde la consola web](modulo6/dc_web.md)
	* [Estrategias de despliegues](modulo6/estretegias.md)
	* [Estrategias de despliegues basadas en rutas](modulo6/estrategias_rutas.md)

7. Plantillas: empaquetando los objetos en OpenShift
	* [Introducción a los Templates](modulo7/template.md)
	* [Descripción de un objeto Template](modulo7/descripcion.md)
	* [Crear objetos desde un Template](modulo7/crear_template.md)
	* [Crear objetos desde un Template desde la consola web](modulo7/template_web.md)
	* [Creación de plantillas a partir de objetos existentes](modulo7/crear_template2.md)
	* [Despliegue de una aplicación con plantillas](modulo7/php-template.md)
	* Uso de Helm en OpenShift

8. OpenShift Pipelines
	
	* [Introducción a OpenShift Pipelines](modulo8/introduccion_pipeline.md)
	* [Despliegue de una aplicación con OpenShift Pipeline](modulo8/pipeline.md)
	* [Gestión de OpenShift Pipeline desde la consola web](modulo8/pipeline_web.md)
	* [Despliegues automáticos con trigger webhook en OpenShift Pipeline](modulo8/pipeline_webhook.md)

9. OpenShift Serverless

	* [Introducción a OpenShift Serverless](modulo9/serverless.md)
	* [Ejemplo de Serverless Serving](modulo9/serving.md)
	* [Ejemplo de Serverless Eventing](modulo9/eventing.md)
	* Ejemplo de Serverless Function

10. Ejemplos de despliegues de aplicaciones web
	* Despliegue de aplicaciones Python en OpenShift: guestbook
	* Aplicación python guestbook con con almacenamiento persistente
	* Despliegue de aplicaciones PHP en OpenShift (phpsqlitecms)
	* Despliegue de aplicaciones PHP en OpenShift con almacenamiento persistente
		




	
