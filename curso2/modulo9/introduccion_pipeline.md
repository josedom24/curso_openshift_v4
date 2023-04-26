# Introducción a OpenShift Pipelines

**OpenShift Pipelines** es una solución de integración y entrega continuas (CI/CD) nativa de la nube para crear pipelines con Tekton. **Tekton** es un framework CI/CD flexible, nativo de Kubernetes y de código abierto que permite automatizar despliegues en distintas plataformas.

## Tekton CLI 

Vamos a usar una herramienta de línea de comandos llamada `tkn`, puedes seguir las siguientes [instrucciones](https://github.com/tektoncd/cli#installing-tkn) para su instalación. En Linux Debian:

    curl -LO https://github.com/tektoncd/cli/releases/download/v0.30.1/tektoncd-cli-0.30.1_Linux-64bit.deb
    sudo dpkg -i tektoncd-cli-0.30.1_Linux-64bit.deb

## Conceptos

Tekton define una serie de recursos de Kubernetes/OpenShift con el fin de estandarizar los conceptos de de IC/DC:

* `Task`: un número de pasos reutilizables que realizan una tarea específica (por ejemplo, construir una imagen de contenedor).
* `Pipeline`: la definición del pipeline y las tareas que debe realizar.
* `TaskRun`: la ejecución y el resultado de ejecutar una instancia de tarea.
* `PipelineRun`: la ejecución y el resultado de ejecutar una instancia de pipeline, que incluye un número de TaskRuns.

![tekton](img/tekton-architecture.svg)

En resumen, para crear un Pipeline, se hace lo siguiente:

* Crear tareas (**Task**) personalizadas o instalar tareas reutilizables existentes.
* Crear un **Pipeline** y PipelineResources para definir el pipeline de entrega de su aplicación.
* Crear un **PersistentVolumeClaim** para proporcionar el volumen/sistema de archivos para la ejecución del pipeline.
* Crear un PipelineRun para instanciar e invocar el pipeline.
* Podemos crear distintos disparadores (triggers) que ejecutan el Pipeline con algún evento determinado.

