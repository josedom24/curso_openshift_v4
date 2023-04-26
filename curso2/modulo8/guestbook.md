
oc new-app https://github.com/josedom24/osv4_guestbook.git --name=guestbook

oc new-app bitnami/redis  -e REDIS_PASSWORD=mypass --name=redis

