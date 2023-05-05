# Curso 1: Aprende Kubernetes con OpenShift v4

1. Introducción a OpenShift v4
	* [Implantación de aplicaciones web en contenedores (P)](modulo1/contenedores.md)
	* [Introducción a OpenShift v4 (P)](modulo1/openshift.md)
	* [Plataformas para trabajar con OpenShift v4 (P)](modulo1/plataformas.md)

2. RedHat OpenShift Dedicated Developer Sandbox
	* [RedHat OpenShift Dedicated Developer Sandbox (P)](modulo2/sandbox.md)
	* [Visión general de la consola web](modulo2/consola.md)
	* [Visión general del proyecto de trabajo](modulo2/proyecto.md)
	* [Instalación del CLI de OpenShift: oc](modulo2/oc.md)
	* [Configuración de oc para el Developer Sandbox](modulo2/oclogin.md)

3. Trabajando con OpenShift en local
	* [Instalación en local con CRC](modulo3/instalacion_crc.md)
	* [Configuración de oc para CRC](modulo3/oc.md)
	* [Proyectos en OpenShift](modulo3/proyectos.md)
	* [La consola web en CRC](modulo3/consola_web.md)
	* [Similitudes y diferencias entre CRC y Developer Sandbox](modulo3/crc_sandbox.md)
	
4. OpenShift como distribución de Kubernetes
	* [Despliegues de aplicaciones en Kubernetes (P)](modulo4/aplicaciones.md)
	* [Recursos que nos ofrece OpenShift para desplegar aplicaciones (P)](modulo4/recursos.md)
	* [Trabajando con Pods](modulo4/pods.md)
	* [Trabajando con Pods desde la consola web](modulo4/pods_web.md)
	* [Ejemplo: Pod multicontenedor](modulo4/pod_multicontenedor.md)
	* [Tolerancia a fallos, escalabilidad, balanceo de carga: ReplicaSet](modulo4/replicaset.md)
	* [Trabajando con ReplicaSets desde la consola web](modulo4/replicaset_web.md)
	* [Desplegando aplicaciones: Deployment](modulo4/deployment.md)
	* [Trabajando con Deployment desde la consola web](modulo4/deployment_web.md)
	* [Ejecución de Pods privilegiados](modulo4/pods_privilegiados.md)
	* [Actualización de un Deployment (*rollout* y *rollback*)](modulo4/actualizacion_deployment.md)
	
5. Acceso a las aplicaciones 

	* [Recursos que nos ofrece OpenShift para el acceso a las aplicaciones (P)](modulo5/recursos.md)
	* [Trabajando con Services](modulo5/services.md)
	* [Accediendo a las aplicaciones: ingress y routes](modulo5/routes.md)
	* [Servicio DNS en Kubernetes](modulo5/dns.md)
	* [Gestionando los recursos de acceso desde la consola web](modulo5/acceso_web.md)

6. Despliegues parametrizados
	* [Variables de entorno](modulo6/variables_entorno.md)
    * [ConfigMaps](modulo6/configmaps.md)
    * [Secrets](modulo6/secrets.md)
	* [Gestionando las variables de entorno, los ConfigMap y los Secret desde la consola web](modulo6/web.md)
    * [Ejemplo completo: Despliegue y acceso a Wordpress + MySql](modulo6/wordpress.md)
	* [Agrupación de aplicaciones](modulo6/agrupamiento.md)

7. Almacenamiento en OpenShift
	* [Introducción al almacenamiento (P)](modulo7/almacenamiento.md)
	* [Almacenamiento en CRC](modulo7/almacenamiento_crc.md)
	* [Volúmenes dentro de un pod](modulo7/volumen_pod.md)
	* [Aprovisionamiento dinámico de volúmenes](modulo7/volumen_dinamico.md)
	* [Gestionando el almacenamiento desde la consola web](modulo7/volumen_web.md)
	* [Ejemplo completo: Haciendo persistente la aplicación Wordpress](modulo7/wordpress.md)

8. Otros recursos para manejar nuestras aplicaciones
	* [Otros recursos para manejar nuestras aplicaciones (P)](modulo8/introduccion.md)
	* [StatefulSet](modulo8/statefulset.md)
	* [DaemonSet](modulo8/daemonset.md)
	* [Jobs y CronJobs](modulo8/jobs.md)
	* [Horizontal Pod AutoScaler](modulo8/hpa.md)
		
9. Ejemplo final: Citas
	* [Despliegue de aplicación Citas en OpenShift v4 (P)](modulo9/citas.md)
	* [Despliegues de citas-backend](modulo9/backend.md)
	* [Despliegue de citas-frontend](modulo9/frontend.md)
	* [Despliegue de la base de datos mysql](modulo9/mysql.md)
	* [Actualización de la aplicación citas-backend](modulo9/backend_v2.md)
	