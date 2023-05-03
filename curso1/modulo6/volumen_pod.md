# Volúmenes dentro de un pod

Los volúmenes son objetos que permiten a los contenedores acceder y compartir datos entre ellos o con el host. Hay varios tipos de volúmenes disponibles, y dos de ellos son "emptyDir" y "hostPath".

* **emptyDir** es un tipo de volumen que se crea vacío al comienzo de la vida de un Pod y se elimina cuando el Pod muere. Este tipo de volumen se utiliza para compartir datos temporales entre los contenedores dentro de un mismo pod. Como su nombre indica, está vacío al principio, y cualquier contenido que se escriba en él se perderá si el Pod se reinicia o se elimina.

* **hostPath** es un tipo de volumen que permite a los contenedores acceder a un directorio o archivo en el host en el que se ejecuta el pod. Este tipo de volumen es útil cuando se necesita acceder a datos persistentes en el host, como archivos de configuración o bases de datos. A diferencia de "emptyDir", el contenido del directorio o archivo en el host persiste incluso si el Pod se reinicia o se elimina.

## Declaración de volúmenes en un pod

Vamos a trabajar con la definición de un Pod que hemos definido en el fichero `pod.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: writer-container
    image: busybox
    volumeMounts:
    - name: shared-data
      mountPath: /data
    - name: host-data
      mountPath: /dir
    command: ["sh", "-c", "echo 'Hello, world!' > /data/my-file.txt && sleep 3600"]
  - name: reader-container
    image: busybox
    volumeMounts:
    - name: shared-data
      mountPath: /data
    - name: host-data
      mountPath: /dir
    command: ["/bin/sh", "-c", "cat /data/my-file.txt; sleep 3600"]
    args: ["-w"]
  volumes:
  - name: shared-data
    emptyDir: {}
  - name: host-data
    host-path:
      path: /tmp/datos
```

* En el Pod hemos definido dos contenedores y dos volúmenes.
* El volumen (`shared-data`) es de tipo `emptyDir` y se monta en el directorio `/data` de los dos contenedores.
* El volumen (`host-data`) es de tipo `hostPath` y se monta en el directorio `/dir` de los dos contenedores.
* El contenedor `writer-container` escribe un fichero en el directorio `/data`.
* El contenedor `reader-container` lee el fichero guardado en el directorio `/data`.

Creamos el pod:

    oc apply - pod.yaml

Y mostramos los logs del contenedor `reader-container`, para asegurarnos que está leyendo el fichero que ha creado el contenedor `writer-container`:

    oc logs -c reader-container my-pod
    Hello, world!

Si cambiamos el valor del fichero en el primer contenedor, cambiará en el segundo contenedor:

    oc exec -c writer-container my-pod -- sh -c 'echo "Hola, mundo!" > /data/my-file.txt'
    oc exec -c reader-container my-pod -- sh -c 'cat /data/my-file.txt'
    Hola, mundo!

Si creamos un nuevo fichero en el directorio `/dir` del primer contenedor, se estará creando en el directorio `/temp/datos` del host donde se está ejecutando el pod. A continuación listaremos los ficheros del directorio `/dir` del segundo contenedor y se debe mostrar el fichero:

    oc exec -c writer-container my-pod -- sh -c 'touch /dir/new-file.txt'
    oc exec -c reader-container my-pod -- sh -c 'ls /dir'
    new-file.txt

Si borramos el Pod se eliminará lo guardado en el directorio `/data`, sin embargo el fichero creado en el directorio `/dir` no se eliminará del directorio `/tmp/datos` del host. Sin embargo, al crear de nuevo el Pod es muy probable que se cree en otro worker del clúster por lo que el directorio`/dir` de los contenedores estará vacío.

Finalmente podemos obtener información de los volúmenes que tenemos en un Pod ejecutando:

    oc describe pod/my-pod
    ...
    Containers:
      writer-container:
    ...
        Mounts:
          /data from shared-data (rw)
          /dir from host-data (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-l2dzt (ro)
      reader-container:
    ...
        Mounts:
          /data from shared-data (rw)
          /dir from host-data (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-l2dzt (ro)
    ...
    Volumes:
      shared-data:
        Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
        Medium:     
        SizeLimit:  <unset>
      host-data:
        Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
        Medium:     
        SizeLimit:  <unset>
    ...