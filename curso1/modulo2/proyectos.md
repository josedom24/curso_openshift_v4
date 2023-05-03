# Proyectos en OpenShift

Un proyecto en OpenShift v4 es una agrupamiento lógico de recursos. En realidad es muy parecido al recurso **namespace** de Kubernetes pero puede guardar información adicional. Si eliminamos un proyecto se eliminarán todos los recursos que hemos creado en él.

Vamos a seguir trabajando con el usuario `developer`, que hemos usado para acceder al clúster de OpenShift:

    oc login -u developer -p developer https://api.crc.testing:6443

    Login successful.

    You don't have any projects. You can try to create a new project, by running

        oc new-project <projectname>

Por lo tanto lo primero que vamos a hacer es crear un nuevo proyecto que utilizará este usuario:

    oc new-project developer
    Now using project "developer" on server "https://api.crc.testing:6443".

    You can add applications to this project with the 'new-app' command. For example, try:

        oc new-app rails-postgresql-example

    to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

        kubectl create deployment hello-node --image=k8s.gcr.io/e2e-test-images/agnhost:2.33 -- /agnhost serve-hostname

Vemos que ahora está usando el proyecto `developer`. Para obtener la lista de proyectos disponibles:

    oc get projects
    NAME       DISPLAY NAME   STATUS
    developer                  Active

Y para ver los detalles del proyecto, ejecutamos:

    oc describe project developer

Si creamos un nuevo proyecto:

    oc new-project developer2

    oc get projects
    NAME       DISPLAY NAME   STATUS
    developer                  Active
    developer2                 Active

Nos podemos posicionar en uno de ellos, ejecutando:

    oc project developer

## Proyectos y namespaces

Como hemos comentado un objeto **project** es en realidad un **namespace** que puede guardar más información. De hecho, cada vez que creamos un proyecto se creará un **namespace**. Sin embargo el usuario `developer` no tiene permiso para acceder a los **namespaces**:

    oc get ns
    Error from server (Forbidden): namespaces is forbidden: User "developer" cannot list resource "namespaces" in API group "" at the cluster scope

Vamos a conectarnos como administrador para poder acceder a los **namespaces**:

    oc login -u kubeadmin -p 7CCZB-XLaxk-ELS2G-GrGaw https://api.crc.testing:6443
    Login successful.
    
    You have access to 68 projects, the list has been suppressed. You can list all projects with 'oc projects'

    Using project "developer2".

El administrador tiene acceso a 68 proyectos, por defecto, está usando el último que se ha creado. Podemos ver todos los poryecrtos, ejecutando:

    oc get projects

Ahora si podemos acceder a los **namespaces**, ejecutando:

    oc get ns

Y podemos comprobar que se han creado el **namespace** `developer` y `developer2` correspondiente a los proyectos creados anteriormente.
Finalmente si queremos trabajar en un proyecto en concreto, por ejemplo en el `default`, ejecutaremos:

    oc project default
    Now using project "default" on server "https://api.crc.testing:6443".

Finalmente para borrar un proyecto, ejecutamos:

    pc delete project developer2