# Notas

## Problema con la instalación de crc

https://github.com/crc-org/crc/issues/1578
https://github.com/crc-org/crc/issues/1776
https://serverfault.com/questions/899614/permission-denied-error-when-launching-instance-could-not-open-backing-file


```
sudo nano /etc/apparmor.d/libvirt/TEMPLATE.qemu
```
Y añado el fichero que es la imagen base:

```
#
# This profile is for the domain whose UUID matches this file.
#

#include <tunables/global>

profile LIBVIRT_TEMPLATE flags=(attach_disconnected) {
  #include <abstractions/libvirt-qemu>
  /home/jose/.crc/cache/crc_libvirt_4.12.5_amd64/crc.qcow2 rk,
}
```

Y reiniciamos apparmor:

```
systemctl restart apparmor
```


## Credenciales

```
Started the OpenShift cluster.

The server is accessible via web console at:
  https://console-openshift-console.apps-crc.testing

Log in as administrator:
  Username: kubeadmin
  Password: 52dmz-QUddd-iHwzq-YS5tj

Log in as user:
  Username: developer
  Password: developer

Use the 'oc' command line interface:
  $ eval $(crc oc-env)
  $ oc login -u developer https://api.crc.testing:6443
```


## Imágenes

https://kubernetes.io/docs/concepts/containers/images/

To make sure the Pod always uses the same version of a container image, you can specify the image's digest; replace <image-name>:<tag> with <image-name>@<digest> (for example, image@sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2).

When using image tags, if the image registry were to change the code that the tag on that image represents, you might end up with a mix of Pods running the old and new code. An image digest uniquely identifies a specific version of the image, so Kubernetes runs the same code every time it starts a container with that image name and digest specified. Specifying an image by digest fixes the code that you run so that a change at the registry cannot lead to that mix of versions.

There are third-party admission controllers that mutate Pods (and pod templates) when they are created, so that the running workload is defined based on an image digest rather than a tag. That might be useful if you want to make sure that all your workload is running the same code no matter what tag changes happen at the registry.
Default image pull policy


## Ejecutar cualquier imagen en crc

https://www.returngis.net/2023/01/hoy-empiezo-con-openshift/