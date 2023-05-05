# Servicio DNS en OpenShift

Existe un componente en OpenShift que ofrece un servidor DNS interno para que los Pods puedan resolver diferentes nombres de recursos (Services, Pods, ...) a direcciones IP.

Cada vez que se crea un nuevo recurso **Service** se crea un registro de tipo A con el nombre:

    <nombre_servicio>.<nombre_namespace>.svc.cluster.local.

## Comprobemos el servidor DNS

Partimos del punto anterior donde tenemos creado un **Service**:

    oc get services
    test-web            ClusterIP   172.30.211.73   <none>        8080/TCP  
   
Para comprobar el servidor DNS de nuestro clúster y que podemos resolver los nombres de los distintos **Services**, vamos a usar un Pod, cuya definición esta en el fichero `busybox.yaml` creado desde una imagen `busybox`.  Es una imagen muy pequeña pero con algunas utilidades que nos vienen muy bien:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  containers:
  - name: contenedor
    image: busybox
    command:
      - sleep
      - "3600"
    imagePullPolicy: IfNotPresent
```

Creamos el pod:

    oc apply -f busybox.yaml

¿Qué servidor DNS está configurado en los Pods que estamos creando? Podemos ejecutar la siguiente instrucción para comprobarlo:

    oc exec -it busybox -- cat /etc/resolv.conf
    search test-web.svc.cluster.local svc.cluster.local cluster.local crc.testing
    nameserver 10.217.4.10

* El servidor DNS tiene asignado la IP del clúster 10.217.4.10.
* Podemos utilizar el nombre corto del **Service**, porque buscará el nombre del host totalmente cualificado usando los dominios indicados en el parámetro `search`. Como vemos el primer nombre de dominio es el que se crea con los **Services**: `test-web.svc.cluster.local svc.cluster.local` (recuerda que el proyecto que estamos usando es `test-web`).

Vamos a comprobar que realmente se ha creado un registro A para el **Service**, haciendo consultas DNS:

    oc exec -it busybox -- nslookup test-web
    Server:		10.217.4.10
    Address:	10.217.4.10:53
    ...
    Name:	test-web.test-web.svc.cluster.local
    Address: 10.217.4.144
    

Vemos que ha hecho la resolución del nombre `test-web` con la IP correspondiente a su servicio.

Podemos concluir que, cuando necesitemos acceder desde alguna aplicación desplegada en nuestro clúster a otro servicio ofrecido por otro despliegue, **utilizaremos el nombre que hemos asignado a su Service de acceso**.
