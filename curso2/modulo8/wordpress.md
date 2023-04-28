# wordpress

oc new-app bitnami/wordpress -e WORDPRESS_DATABASE_NAME=wordpress -e  WORDPRESS_DATABASE_HOST=mariadb -e WORDPRESS_DATABASE_USER=usuario -e WORDPRESS_DATABASE_PASSWORD=asdasd --name wordpress

directorio persistene: 
/bitnami/wordpress
