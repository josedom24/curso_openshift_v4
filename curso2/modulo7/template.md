# Descripción de un objeto Template

oc apply -f mysql-plantilla.yaml 
oc process mysql-plantilla -p PASSWORD=asdasd| oc apply -f -


oc exec -it deploy/mysql22 -- mysql -u usuario -pasdasd nueva_bd -h localhost
...
mysql> exit
