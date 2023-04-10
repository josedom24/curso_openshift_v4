# Visión general del proyecto de trabajo

Un proyecto permite a OpenShift agrupar distintos recursos. Es similar al recurso namespace de Kubernetes, pero guarda infromación adicional.

De hcho cada vez que se crea un nuevo proyecto, se crea un recursos namespace con el mismo nombre.

En RedHat OpenShift Dedicated Developer Sandbox, no podemos crear nuevos proyecto y se nos asigna de forma automática un proyecto con el mismo nombre que el de nuestro usuario.

Para acceder a la infromación de nuestro poryecto, en la **Vista Administrator**, escogemos la opción **Home -> Projects**:

imagen1

Si pulsamos sobre el nombre del proyecto, obtendremos los detalles del mismo: definción, inventario, uso de recursos, metricas, cuotas, eventos,...

Imagen2

Imagen3

Tenemos varias opciones:

* **Details**: detalles sobre la definciónd el proyecto.
* **YAML**: definción YAML del recurso projecto.
* **Workloads**: acceso a todos los recursos definidos en este proyecto.
* **RoleBindings**: Permisos definidos para este proyecto.