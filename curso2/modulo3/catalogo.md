# Catalogo

En OpenShift v4, el catálogo de aplicaciones es una colección de software preempaquetado que se puede instalar y utilizar en un clúster de OpenShift. Estos paquetes de software se conocen como "imágenes de contenedor" y contienen todo lo necesario para ejecutar una aplicación, incluidos los binarios, bibliotecas, dependencias y configuraciones.

El catálogo de aplicaciones está compuesto por varios elementos, como:

    Operadores: los operadores son paquetes de software que automatizan el proceso de implementación, gestión y actualización de aplicaciones complejas en OpenShift. Los operadores se utilizan para gestionar aplicaciones de nivel empresarial, como bases de datos, sistemas de almacenamiento, middleware y aplicaciones empresariales.

    Imágenes de contenedor: las imágenes de contenedor son paquetes de software que contienen todo lo necesario para ejecutar una aplicación, incluidos los binarios, bibliotecas, dependencias y configuraciones.

    Plantillas de aplicación: las plantillas de aplicación son archivos de configuración predefinidos que contienen las instrucciones necesarias para implementar y configurar una aplicación en un clúster de OpenShift. Las plantillas de aplicación se utilizan para acelerar el proceso de implementación de aplicaciones y garantizar la coherencia en todo el clúster.

    Imágenes de origen: las imágenes de origen son imágenes de contenedor que contienen todo lo necesario para construir una aplicación a partir de su código fuente. Las imágenes de origen se utilizan para facilitar la construcción y el despliegue de aplicaciones personalizadas.

En resumen, el catálogo de aplicaciones de OpenShift v4 está diseñado para simplificar el proceso de implementación y gestión de aplicaciones en un clúster de OpenShift, proporcionando una amplia variedad de paquetes de software preempaquetados que se


https://access.redhat.com/documentation/es-es/openshift_container_platform/4.11/html-single/building_applications/index#odc-using-the-developer-catalog-to-add-services-or-components_odc-creating-applications-using-developer-perspective



# Template

https://access.redhat.com/documentation/es-es/openshift_container_platform/4.9/html/images/using-templates

	oc get templates -n openshift
	oc get is -n openshift

	oc process --parameters -n openshift mariadb-ephemeral

	oc new-app mariadb-ephemeral -p MYSQL_USER=jose -p MYSQL_PASSWORD=asdasd -p MYSQL_ROOT_PASSWORD=asdasd -p MYSQL_DATABASE=blog

export PODNAME=mariadb-1-j52jv
 jose@ahsoka  ~/github/osv4_blog_php   master  oc cp database.sql $PODNAME:/tmp/
 jose@ahsoka  ~/github/osv4_blog_php   master  oc exec dc/mariadb -- bash -c "mysql -uroot -pasdasd -h mariadb blog < /tmp/database.sql"
