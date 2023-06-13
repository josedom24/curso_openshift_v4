# Introducción a OpenShift Pipelines

**OpenShift Pipelines** es una solución de integración y entrega continua (CI/CD) nativa de la nube para crear pipelines con Tekton. **Tekton** es un framework CI/CD flexible, nativo de Kubernetes y de código abierto que permite automatizar despliegues en distintas plataformas.

Tekton define una serie de recursos de Kubernetes/OpenShift con el fin de estandarizar los conceptos de de IC/DC:

* `Task`: Un número de pasos reutilizables que realizan una tarea específica (por ejemplo, construir una imagen de contenedor).
* `Pipeline`: La definición del conjunto de tareas que se deben ejecutar.
* `TaskRun`: La ejecución y el resultado de ejecutar una instancia de tarea.
* `PipelineRun`: La ejecución y el resultado de ejecutar una instancia de pipeline, que incluye un número de TaskRuns.

![tekton](img/tekton-architecture.svg)

En resumen, para crear un Pipeline, se hace lo siguiente:

* Crear tareas (**Task**) personalizadas o instalar tareas reutilizables existentes.
* Crear un **Pipeline**  para definir el conjunto de tareas que se tienen que ejecutar.
* Crear un **PersistentVolumeClaim** para proporcionar el volumen/sistema de archivos para la ejecución del pipeline. Para que las distintas tareas del pipeline compartan información es necesario tener un almacenamiento compartido que llamamos **Workspaces**.
* Crear un **PipelineRun** para instanciar e invocar el pipeline.
* Podemos crear distintos disparadores (triggers) que ejecutan el Pipeline con algún evento determinado.

