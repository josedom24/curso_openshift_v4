# Aprovisionamiento dinámico de volúmenes

Desde el punto de vista del desarrollador que necesita almacenamiento para su aplicación, este realizará una petición de un volumen (objeto **PersistentVolumeClaim**) y usando algún mecanismo que haya configurado el administrador del clúster se asociará un volumen a esa petición.

En este ejemplo vamos a desplegar un servidor web que va a servir una página html que tendrá almacenada en un volumen. La asignación del volumen se va a realizar de forma dinámica.

Como vimos en CRC tenemos configurado un recurso **StorageClass**, que de forma dinámica van a crear el nuevo volumen de tipo hostPath y lo asocian a la petición de volumen que vamos a realizar.

    oc get storageclass
    NAME                                     PROVISIONER                        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
    crc-csi-hostpath-provisioner (default)   kubevirt.io.hostpath-provisioner   Delete          WaitForFirstConsumer   false                  36d     

## Solicitud del volumen

Vamos a realizar la solicitud de volumen, en este caso usaremos el fichero `pvc.yaml`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

Al crear el objeto **PersistentVolumenClaim (PVC)**, veremos que se queda en estado Pending, no se creará el objeto **PersistentVolume (PV)** hasta que no lo vayamos a usar por primera vez:

    oc login -u developer -p developer https://api.crc.testing:6443
    oc new-project almacenamiento

    oc apply -f pvc.yaml 

    oc get pvc
    NAME     STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS                   AGE
    my-pvc   Pending                                      crc-csi-hostpath-provisioner   2s

Podemos ver las características del objeto que hemos creado, ejecutando:

    oc describe pvc my-pvc
    
## Uso del volumen

Creamos el Deployment usando el fichero `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: bitnami/nginx
        name: contenedor-nginx
        ports:
        - name: http
          containerPort: 8080
        volumeMounts:
        - name: my-volumen
          mountPath: /app
        securityContext:
            runAsNonRoot: true
            allowPrivilegeEscalation: false
            seccompProfile:
              type: RuntimeDefault
            capabilities:
              drop:
              - ALL
      volumes:
      - name: my-volumen
        persistentVolumeClaim:
          claimName: my-pvc
```

* En la especificación del Pod, además de indicar el contenedor, hemos indicado que va a tener un volumen (campo `volumes`). 
* En realidad, definimos una lista de volúmenes (en este caso solo definimos uno) indicando su nombre (`name`) y la solicitud del volumen (`persistentVolumeClaim`, `claimName`).
* Además en la definición del contenedor tendremos que indicar el punto de montaje del volumen (`volumeMounts`) señalando el directorio del contenedor (`mountPath`) y el nombre (`name`).

Creamos el **Deployment**:

    oc apply -f deployment.yaml

Ya podemos comprobar que se ha asociado un volumen a la solicitud de volumen:

    oc get pvc
    NAME     STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                   AGE
    my-pvc   Bound    pvc-69e0a042-6964-45aa-b06e-73a2f620b1bb   30Gi       RWO            crc-csi-hostpath-provisioner   2m25s

También podemos verlos desde el punto de vista del administrador para poder listar los objetos **PeristentVolume**:

    oc login -u kubeadmin https://api.crc.testing:6443
    oc project developer

    oc get pv,pvc

    NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                                 STORAGECLASS                   REASON   AGE
    persistentvolume/pvc-69e0a042-6964-45aa-b06e-73a2f620b1bb   30Gi       RWO            Delete           Bound    developer/my-pvc                                      crc-csi-hostpath-provisioner            2m38s

    NAME                           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                   AGE
    persistentvolumeclaim/my-pvc   Bound    pvc-69e0a042-6964-45aa-b06e-73a2f620b1bb   30Gi       RWO            crc-csi-hostpath-provisioner   4m22s

**Nota**: Los objetos **PersistentVolumeClaim** están asociados a un proyecto (en nuestro caso `developer/my-pvc`). Sin embargo, los objetos **PersistentVolume** no pertenecen a un proyecto, son globales al clúster de OpenShift.

Seguimos trabajando con el usaurio `developer`, y creamos un fichero `index.html`:

    oc login -u developer -p developer https://api.crc.testing:6443
    oc exec deploy/nginx -- bash -c "echo '<h1>Curso de OpenShift</h1>' > /app/index.html"

Finalmente creamos el Service y el Route para acceder al despliegue:

    oc expose deploy/nginx
    oc expose service/nginx

![volumen](img/volumen1.png)

Finalmente podemos comprobar que la información de la aplicación no se pierde borrando el **Deployment** y volviéndolo a crear, comprobando que se sigue sirviendo el fichero `index.html`.


## Eliminación del volumen

En este caso, los volúmenes que crea de forma dinámica el **StorageClass** tiene como política de reciclaje el valor de `Delete`. Esto significa que cuando eliminemos la solicitud, el objeto **PersistentVolumeClaim**, también se borrará el volumen, el objeto **PersistentVolume**.

    oc delete deploy/nginx
    oc delete persistentvolumeclaim/my-pvc
