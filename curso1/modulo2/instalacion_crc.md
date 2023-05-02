# Instalación en local con crc

    sudo apt install qemu-kvm libvirt-daemon libvirt-daemon-system network-manager
    sudo adduser usuario libvirt


    https://console.redhat.com/openshift/create/local

    tar -xf crc-linux-2.17.0-amd64
    cd crc-linux-2.17.0-amd64
    sudo install crc /usr/local/bin

     crc version
CRC version: 2.17.0+44e15711
OpenShift version: 4.12.9
Podman version: 4.4.1



crc setup

crc config set consent-telemetry yes
crc config set cpus 8
crc config set memory 20480
crc start

Started the OpenShift cluster.

The server is accessible via web console at:
  https://console-openshift-console.apps-crc.testing

Log in as administrator:
  Username: kubeadmin
  Password: 7CCZB-XLaxk-ELS2G-GrGaw

Log in as user:
  Username: developer
  Password: developer

Use the 'oc' command line interface:
  $ eval $(crc oc-env)
  $ oc login -u developer https://api.crc.testing:6443
