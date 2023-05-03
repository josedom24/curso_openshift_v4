# Configuración de oc para crc

La herramienta `oc` nos permite gestionar los recursos de nuestro clúster de OpenShift desde la línea de comandos.

Para más información de esta herramienta puedes acceder a la [documentación oficial](https://docs.openshift.com/container-platform/4.12/cli_reference/openshift_cli/getting-started-cli.html).

Si utilizamos CRC no es necesario la instalación de esta herramienta, solamente tenemos que configurar de forma adecuada el PATH, ejecutando:

eval $(crc oc-env)

Como hemos dicho anteriormente para obtener las instrucciones para hacer login en el clúster, ejecutamos:

    crc console --credentials
    To login as a regular user, run 'oc login -u developer -p developer https://api.crc.testing:6443'.
    To login as an admin, run 'oc login -u kubeadmin -p 7CCZB-XLaxk-ELS2G-GrGaw https://api.crc.testing:6443'

Como vemos podemos loguearno con dos usarios: `kubeadmin` que será un usuario administrador con todos los permisos disponibles, y con el usuario `developer` que será un usuario sin privilegios.

Por ejemplo para loguearnos como administrador.
    
    oc login -u kubeadmin -p 7CCZB-XLaxk-ELS2G-GrGaw https://api.crc.testing:6443
    Login successful.

    You have access to 66 projects, the list has been suppressed. You can list all projects with 'oc projects'

    Using project "default".

Vemos que tiene acceso a 66 proyectos y que por defecto está usando el proyecto `default`. Por ejemplo el usuario administrador puede acceder a los nodos del clúster


    oc get nodes
    NAME                 STATUS   ROLES                         AGE   VERSION
    crc-8tnb7-master-0   Ready    control-plane,master,worker   36d   v1.25.7+eab9cc9

Si nos conectamos con el usuario `developer`:

    oc login -u developer -p developer https://api.crc.testing:6443

    Login successful.

    You don't have any projects. You can try to create a new project, by running

        oc new-project <projectname>

Te avisa que no tienes asignado ningún proyecto y que tienes que crear uno para trabajar. Si intentamos, por ejemplo acceder a los nodos del clúster, veremos que no tenemos permiso:

    oc get nodes
    Error from server (Forbidden): nodes is forbidden: User "developer" cannot list resource "nodes" in API group "" at the cluster scope
