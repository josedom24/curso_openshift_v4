# Curso 1: Aprende Kubernetes con OpenShift v4

1. Introducción a OpenShift v4
	* [Implantación de aplicaciones web en contenedores](modulo1/contenedores.md)
	* [Introducción a OpenShift v4](modulo1/openshift.md)
	* [Plataformas para trabajar con OpenShift v4](modulo1/plataformas.md)

2. RedHat OpenShift Dedicated Developer Sandbox
	* [RedHat OpenShift Dedicated Developer Sandbox](modulo2/sandbox.md)
	* Visión general de la consola web
	* Visión general del proyecto de trabajo
	* [Instalación del CLI de OpenShift: oc](modulo2/oc.md)
	* [Configuración de oc para el Developer Sandbox](modulo2/oclogin.md)

3. OpenShift como distribución de Kubernetes
	* [Despliegues de aplicaciones en Kubernetes](modulo3/aplicaciones.md)
	* [Recursos que nos ofrece Openshift para desplegar aplicaciones](modulo3/recursos.md)
	* [Trabajando con Pods](modulo3/pods.md)
	* [Trabajando con Pods desde la consola web](modulo3/pods_web.md)
	* [Ejemplo: Pod multicontenedor](modulo3/pod_multicontenedor.md)
	* [Tolerancia a fallos, escalabilidad, balanceo de carga: ReplicaSet](modulo3/replicaset.md)
	* [Trabajando con ReplicaSets desde la consola web](modulo3/replicaset_web.md)
	* [Desplegando aplicaciones: Deployment](modulo3/deployment.md)
	* [Actualización de un Deployment (*rollout* y *rollback*)](modulo3/actualizacion_deployment.md)
	* [Trabajando con Deployment desde la consola web](modulo3/deployment_web.md)

4. Acceso a las aplicaciones 

	* [Recursos que nos ofrece Openshift para el acceso a las aplicaciones](modulo4/recursos.md)
	* [Trabajando con Services](modulo4/services.md)
	* [Accediendo a las aplicaciones: ingress y routes](modulo4/routes.md)
	* [Servicio DNS en Kubernetes](modulo4/dns.md)
	* [Gestionando los recursos de acceso desde la consola web](modulo4/acceso_web.md)

5. Despliegues parametrizados
	* [Variables de entorno](modulo5/variables_entorno.md)
    * [ConfigMaps](modulo5/configmaps.md)
    * [Secrets](modulo5/secrets.md)
	* [Gestionando las variables de entorno, los ConfigMap y los Secret desde la consola web](modulo5/web.md)
    * [Ejemplo completo: Despliegue y acceso a Wordpress + MySql](modulo5/wordpress.md)
	* [Agrupación de aplicaciones](modulo5/agrupamiento.md)

6. Almacenamiento en OpenShift
	* [Introducción al almacenamiento](modulo6/almacenamiento.md)
	* [Almacenamiento en RedHat OpenShift Dedicated Developer Sandbox](modulo6/almacenamiento_sandbox.md)
	* [Volúmenes dentro de un pod](modulo6/volumen_pod.md)
	* [Aprovisionamiento dinámico de volúmenes](modulo6/volumen_dinamico.md)
	* [Gestionando el almacenamiento desde la consola web](modulo6/volumen_web.md)
	* [Instantáneas de volúmenes](modulo6/snapshot.md)
	* [Ejemplo completo: Haciendo persistente la aplicación Wordpress](modulo6/wordpress.md)

7. Otros recursos para manejar nuestras aplicaciones
	* [Otros recursos para manejar nuestras aplicaciones](modulo7/introduccion.md)
	* [StatefulSet](modulo7/statefulset.md)
	* [DaemonSet](modulo7/daemonset.md)
	* [Jobs y CronJobs](modulo7/jobs.md)
	* [Horizontal Pod AutoScaler](modulo7/hpa.md)
	* PodDisruptionBudgets


8. Ejemplo final: Citas
	* [Despliegue de aplicación citas en OpenShift v4](modulo8/citas.md)
	* [Despliegues de citas-backend](modulo8/backend.md)
	* [Despliegue de citas-frontend](modulo8/frontend.md)
	* [Despliegue de la base de datos mysql](modulo8/mysql.md)
	* [Actualización de la aplicación citas-backend](modulo8/backend_v2.md)
	