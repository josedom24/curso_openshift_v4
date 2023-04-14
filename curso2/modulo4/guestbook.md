
oc new-app https://github.com/josedom24/osv4_temperaturas.git --name=temp 

oc new-app bitnami/redis  -e REDIS_PASSWORD=mypass --name=redis

