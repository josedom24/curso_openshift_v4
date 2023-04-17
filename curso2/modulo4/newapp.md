
En crc como administrador, para poder acceder a las imágenes del registro interno.

oc new-project mediawiki

oc create sa sa-mediawiki
oc adm policy add-scc-to-user anyuid -z sa-mediawiki

oc new-app mediawiki --name=wiki
oc get is
oc describe is wiki

oc describe deploy wiki
oc set sa deploy wiki sa-mediawiki

oc get image | grep mediawiki

oc expose service wiki
oc get route
