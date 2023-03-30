# Despliegues de aplicaciones en Kubernetes




## Arquitectura de nuestras aplicaciones

Tenemos dos clases de aplicaciones que podemos desplegar en un cluster de Kubernetes:

1. Aplicaciones que necesitan varios servicios para ejecutarse: por ejemplo una aplicación escrita en PHP y servida por un servidor web que necesita un servidor de base de datos para guardar la información. En este caso crearemos dos recursos Deployment: uno para desplegar la aplicación PHP y otro para desplegar la base de datos. Por cada servicio que necesite nuestra aplicación crearemos un Deployment para desplegarlo.
2. Aplicaciones construidas con microservicios: cada microservicio se puede desplegar de manera autónoma. Por cada microservicio que forma parte de la aplicación crearemos un recurso Deployment. Por ejemplo, una aplicación que tenga un frontend para ofrecer la información y que haga llamadas a un backend que ofrece un servicio web por medio de una API RESTful.