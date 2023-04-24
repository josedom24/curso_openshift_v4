# Catalogo





# Template

https://access.redhat.com/documentation/es-es/openshift_container_platform/4.9/html/images/using-templates

	oc get templates -n openshift
	oc get is -n openshift

	oc process --parameters -n openshift mariadb-ephemeral

	oc new-app mariadb-ephemeral -p MYSQL_USER=jose -p MYSQL_PASSWORD=asdasd -p MYSQL_ROOT_PASSWORD=asdasd -p MYSQL_DATABASE=blog

export PODNAME=mariadb-1-j52jv
 jose@ahsoka  ~/github/osv4_blog_php   master  oc cp database.sql $PODNAME:/tmp/
 jose@ahsoka  ~/github/osv4_blog_php   master  oc exec dc/mariadb -- bash -c "mysql -uroot -pasdasd -h mariadb blog < /tmp/database.sql"
