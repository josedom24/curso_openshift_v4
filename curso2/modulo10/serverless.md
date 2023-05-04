# Introducción a OpenShift Serverless

**Serverless** es un modelo de desarrollo para aplicaciones nativas de la nube, que evita cualquier tarea de creación o mantenimiento de servidores, lo que permite a los desarrolladores centrarse en ofrecer aplicaciones sin preocuparse por la infraestructura sobre la que se ejecutan. 
Serverless es más adecuado para aplicaciones asíncronas y sin estado, especialmente aquellas que tienen cargas de trabajo impredecibles.

## Ventajas de Serverless

* **Aprovisionamiento automatizado**: La principal ventaja es que los servidores son totalmente proporcionados por el proveedor serverless, que se encarga de aprovisionarlos, mantenerlos y escalarlos. Esta ventaja está asociada a la reducción de costes.
* **Enfoque en el desarrollador**: Permite a los desarrolladores centrarse en la lógica de negocio.
* **Escala a cero**: No necesitamos ejecutar ninguna instancia de aplicación cuando no hay tráfico y reaccionan a las solicitudes entrantes poniéndolas en espera mientras se activan las aplicaciones necesarias.
* **Elasticidad**: Con la infraestructura tradicional, los recursos computacionales se reservan y se pagan por adelantado, mientras que los Serverless sólo se ejecutan cuando se necesitan.

## Red Hat OpenShift Serverless

**OpenShift Serverless** es la funcionalidad ofrecida por OpenShift, que permite a los desarrolladores desplegar aplicaciones Serverless de una manera sencilla.

OpenShift Serverless se basa en el proyecto de código abierto **Knative**, que nos ofrece dos funcionalidades:

* **Servicio**: Componente encargado del despliegue y escalado automático de aplicaciones.
* **Eventos**: Infraestructura para consumir y producir eventos que nos permite crear aplicaciones usando **Arquitectura dirigida por eventos**: desplegar aplicaciones distribuidas cuyos componentes intercambian **eventos** para la comunicación entre ellos.

### Knative Servig

Knative Serving es el componente responsable de:

* Desplegar aplicaciones.
* Actualizar aplicaciones.
* Enrutar el tráfico a las aplicaciones.
* Auto-escalado de aplicaciones.

Knative Serving crea nuevos despliegues y garantiza que el tráfico sólo se redirige a las versiones operativas de la aplicación. Cuando no hay tráfico, reduce los Pods de aplicación a cero. Si llega nuevo tráfico se escalará de forma automática para servir la petición.

## Knative Eventing

Knative Eventing nos permite utilizar una **arquitectura basada en eventos** con Serverless. Una arquitectura dirigida por eventos se basa en el concepto de relaciones desacopladas entre productores y consumidores de **eventos**.

Los productores de eventos crean eventos, y los consumidores de eventos reciben eventos. Knative Eventing utiliza peticiones HTTP POST estándar para enviar y recibir eventos entre productores y receptores de eventos. 

## Serverless Functions

Serverless Functions nos permite crear e implementar funciones Serverless basadas en eventos como un servicio Knative.

Nos proporciona plantillas para cada lenguaje y framework compatible, como Node.js, Quarkus, Go, ...; y Buildpacks adecuados para cada uno de ellos.

Cuando el desarrollador crea una función, Serverless Functions crea un proyecto utilizando la plantilla correspondiente. Esta plantilla proporciona los archivos y dependencias necesarios, y un código inicial vacío para una función, listo para añadir lógica de negocio.
Los desarrolladores sólo tienen que emitir el comando `build` y Serverless Functions utiliza el Buildpack para construir la imagen de ejecución. Una vez creada la imagen de ejecución, OpenShift Serverless se encarga de subir, desplegar y gestionar las funciones como cualquier otra aplicación Serverless.