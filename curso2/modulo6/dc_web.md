# Trabajando con DeploymentConfig desde la consola web

Cuando creamos una nueva aplicación desde la consola web, y queremos utilizar como recurso de despliegue un **DeploymentConfig**, tenemos que seleccionar el recurso en el apartado **Resource type**:

![dc](img/dc_web1.png)

Una vez que se ha creado, podemos ver en la vista **Topology** que se ha creado un recurso de tipo **DeploymentConfig** (**DC**):

![dc](img/dc_web2.png)

## Objeto DeploymentConfig

Si accedemos a la vista **Administrator**, la sección **Workloads -> DeploymentConfigs**, podemos ver la lista de objetos **DeploymentConfig** que tenemos en nuestro proyecto:

![dc](img/dc_web3.png)

Con el botón **Create DeploymentConfig** podemos crear nuevos objetos **DeploymentConfig**, desde la vista formulario:

![dc](img/dc_web4.png)

O desde la definición yaml del objeto:

![dc](img/dc_web5.png)

Si pulsamos en un objeto **DeploymentConfig** acedemos a una página donde nos dan los detalles del objeto y tenemos la posibilidad de gestionarlo con las acciones que encontramos en el desplegable **Actions**:

![dc](img/dc_web6.png)

En esta pantalla encontramos varias pestañas:

* **Details**: La página donde estamos, que nos da información detallada del objeto.
* **YAML**: Donde accedemos a la definición yaml del objeto.
* **ReplicationControllers**: Accedemos a la ventana donde se nos muestran los objetos **ReplicationControllers** del objeto **DeploymentConfig** que estamos viendo.
* **Pods**: La lista de pods controlada por el **ReplicationController** activo.
* **Environment**: Donde podemos crear variables de entorno de tipo clave=valor que se crearan en los pods.
* **Events**: Donde nos indica los distintos eventos que han modificado el estado del objeto.

## Objetos ReplicationController

Como hemos indicados, podemos ver la lista de objetos **ReplicationControllers** de un **DeploymentConfig**, accediendo a la pestaña **ReplicationControllers**:

![dc](img/dc_web7.png)

De la misma manera, si pulsamos sobre un objeto determinado, obtenemos la información detallada del mismo:

![dc](img/dc_web8.png)

Donde tenemos varias pestañas con distintas informaciones:

* **Details**: La página donde estamos, que nos da información detallada del objeto.
* **YAML**: Donde accedemos a la definición yaml del objeto.
* **Pods**: La lista de pods controlada por el **ReplicationController** activo.
* **Environment**: Donde podemos crear variables de entorno de tipo clave=valor que se crearan en los pods.
* **Events**: Donde nos indica los distintos eventos que han modificado el estado del objeto.

## Rollout de un DeploymentConfig

Podemos actualizar el **DeploymentConfig** eligiendo la opción **Start rollout**:

![dc](img/dc_web9.png)

Podemos observar en la lista de **ReplicationController**  que se ha creado un nuevo objeto:

![dc](img/dc_web10.png)

Efectivamente hemos tenido otro **deploy pod** que ha creado un nuevo pod:

![dc](img/dc_web11.png)

Si queremos hacer un Rollback a una revisión anterior para activar un **ReplicationController** anterior, lo elegimos en la lista y pulsamos sobre la opción **Rollback**:

![dc](img/dc_web12.png)



