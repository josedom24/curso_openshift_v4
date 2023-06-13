# Curso 2: OpenShift v4 como PaaS

1. Introducción a OpenShift v4
	* [Cloud Computing PaaS: Plataforma como servicio (P)](modulo1/paas.md)
	* [OpenShift, la plataforma PaaS de Red Hat (P)](modulo1/openshift.md)
	* [Plataformas para trabajar con OpenShift v4 (P)](modulo1/plataformas.md)
	* [Introducción a  Red Hat OpenShift Dedicated Developer Sandbox](modulo1/sandbox.md)

2. Despliegue de aplicaciones en OpenShift v4
	* [Introducción al despliegue de aplicaciones en OpenShift v4 (P)](modulo2/introduccion.md)
	* [Despliegue de aplicaciones desde imágenes con oc](modulo2/imagen.md)
	* [Despliegue de aplicaciones desde imágenes desde la consola web](modulo2/imagen_web.md)
	* [Despliegue de aplicaciones desde código fuente con oc](modulo2/codigo.md)	
	* [Despliegue de aplicaciones desde código fuente con oc (2ª parte)](modulo2/codigo2.md)
	* [Despliegue de aplicaciones desde código fuente desde la consola web](modulo2/codigo_web.md)
	* [Despliegue de aplicaciones desde Dockerfile con oc](modulo2/docker.md)
	* [Despliegue de aplicaciones desde Dockerfile desde la consola web](modulo2/docker_web.md)
	* [Despliegue de aplicaciones desde el catálogo con oc](modulo2/catalogo.md)
	* [Despliegue de aplicaciones desde el catálogo desde la consola web](modulo2/catalogo_web.md)

3. ImageStreams: Gestión de imágenes en OpenShift v4
	* [Introducción al recurso ImageStream (P)](modulo3/introduccion.md)
	* [ImageStream a imágenes del registro interno](modulo3/registro_interno.md)
	* [Creación de ImageStream](modulo3/crear_is.md)
	* [Gestión de ImageStream desde la consola web](modulo3/is_web.md)
	* [Gestión de las etiquetas en un ImageStream](modulo3/etiquetas.md)
	* [Actualización automática de ImageStream](modulo3/update.md)

4. Builds: Construcción automática de imágenes
	* [Introducción a la construcción automática de imágenes (build) (P)](modulo4/build.md)
	* [Construcción de imágenes con estrategia Source-to-Image (S2I) + repositorio Git](modulo4/s2i.md)
	* [Construcción de imágenes con estrategia Docker + repositorio Git](modulo4/docker.md)
	* [Definición del objeto BuildConfig](modulo4/buildconfig.md)
	* [Actualización manual de un build](modulo4/actualizacion.md)
	* [Construcción de imágenes desde ficheros locales](modulo4/binary.md)
	* [Construcción de imágenes con Dockerfile en línea](modulo4/dockerfile_inline.md)
	* [Gestión de builds desde la consola web](modulo4/build_web.md)
	* [Actualización automática de un build](modulo4/imagechange.md)
	* [Actualización automática de un build por trigger webhook](modulo4/webhook.md)

5. Deployment us DeploymentConfig
	* [Características del recurso DeploymentConfig (P)](modulo5/dc.md)
	* [Creación de un DeployConfig al crear una aplicación](modulo5/newdc.md)
	* [Definición de un recurso DeploymentConfig](modulo5/deploymentconfig.md)
	* [Actualización de un DeploymentConfig (rollout)](modulo5/rollout.md)
	* [Rollback de un DeploymentConfig](modulo5/rollback.md)
	* [Trabajando con DeploymentConfig desde la consola web](modulo5/dc_web.md)
	* [Estrategias de despliegues](modulo5/estretegias.md)
	* [Estrategias de despliegues basadas en rutas](modulo5/estrategias_rutas.md)

6. Plantillas: empaquetando los objetos en OpenShift
	* [Introducción a los Templates](modulo6/template.md)
	* [Descripción de un objeto Template](modulo6/descripcion.md)
	* [Crear objetos desde un Template](modulo6/crear_template.md)
	* [Crear objetos desde un Template desde la consola web](modulo6/template_web.md)
	* [Creación de plantillas a partir de objetos existentes](modulo6/crear_template2.md)
	* [Despliegue de una aplicación con plantillas](modulo6/php-template.md)
	* [Uso de Helm en OpenShift desde la consola web](modulo6/helm-web.md)
	* [Uso de Helm en OpenShift desde la línea de comandos](modulo6/helm-cli.md)

7. Almacenamiento en OpenShift v4
	* [Introducción al almacenamiento en OpenShift v4 (P)](modulo7/almacenamiento.md)
	* [Almacenamiento en Red Hat OpenShift Dedicated Developer Sandbox](modulo7/almacenamiento_sandbox.md)
	* [Ejemplo 1: Gestión de almacenamiento desde la consola web: phpsqlitecms (1ª parte)](modulo7/phpsqlitecms.md)
	* [Ejemplo 1: Gestión de almacenamiento desde la consola web: phpsqlitecms (2ª parte)](modulo7/phpsqlitecms2.md)
	* [Ejemplo 2: Gestión de almacenamiento desde la línea de comandos: GuestBook](modulo7/guestbook.md)
	* [Ejemplo 3: Haciendo persistente la aplicación Wordpress](modulo7/wordpress.md)
	* [Instantáneas de volúmenes](modulo7/snapshot.md)

8. OpenShift Pipelines
	
	* [Introducción a OpenShift Pipelines (P)](modulo8/introduccion_pipeline.md)
	* [Despliegue de una aplicación con OpenShift Pipeline](modulo8/pipeline.md)
	* [Gestión de OpenShift Pipeline desde la consola web](modulo8/pipeline_web.md)
	* [Instalación de OpenShift Pipeline en CRC](modulo8/operador.md)

9. OpenShift Serverless

	* [Introducción a OpenShift Serverless (P)](modulo9/serverless.md)
	* [Ejemplo de Serverless Serving](modulo9/serving.md)
	* [Ejemplo de Serverless Eventing](modulo9/eventing.md)
	* [Ejemplo de Serverless Function](modulo9/function.md)
	* [Instalación de OpenShift Serverless en CRC](modulo9/operador.md)

10. Ejemplos de despliegues de aplicaciones web
	* [Despliegue de aplicación Citas en OpenShift v4 (1ª parte)](modulo10/citas.md)
	* [Despliegue de aplicación Citas en OpenShift v4 (2ª parte)](modulo10/citas2.md)
	* [Despliegue de aplicación Parksmap en OpenShift v4 (1ª parte)](modulo10/parksmap.md)
	* [Despliegue de aplicación Nationalparks en OpenShift v4 (2ª parte)](modulo10/parksmap2.md)
	
		




	
