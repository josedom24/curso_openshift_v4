# Gestión de ImageStream desde la consola web

En primer lugar podemos ver desde la consola web los objetos **ImageStream** que apuntan a las imágenes precargadas en OpenShift. recordemos que se encuentran en el proyecto `openshift`. En la vista **Administrator**, en el apartado **Builds->ImageStream**, escogemos el proyecto **OpenShift** y accedemos:

![is](img/is_web1.png)

Si cambiamos el proyecto, y escogemos el `default` donde hemos estado trabajando, accederemos a los **ImageStream** que hemos creado en el apartado anterior:

![is](img/is_web2.png)

Por ejemplo si pulsamos en uno de ellos, podemos ver los detalles de este objeto:

![is](img/is_web3.png)

Y las etiquetas que tiene definido:

![is](img/is_web4.png)

Finalmente podemos pulsar sobre el botón **Create ImageStream** para crear un nuevo objeto desde su definición yaml_

![is](img/is_web5.png)


