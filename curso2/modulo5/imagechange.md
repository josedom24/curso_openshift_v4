# Actualización automática de un build por trigger ImageChange

oc import-image mi-php:v1 --from=registry.access.redhat.com/ubi8/php-74 --confirm
 2197  oc new-build mi-php:v1~https://github.com/josedom24/osv4_php --strategy=source --name=app9
 2198  oc get build
 2199  oc delete istag mi-php:v1
 2200  oc import-image mi-php:v1 --from=registry.access.redhat.com/ubi8/php-80 --confirm
 2201  oc get build
