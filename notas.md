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
