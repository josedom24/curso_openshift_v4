
oc new-app https://github.com/josedom24/osv4_guestbook.git --name=guestbook

oc new-app bitnami/redis  -e REDIS_PASSWORD=mypass --name=redis

Edito deploy redis

* Pongo recreate
* Configuro volumen

      containers:
      ...
        volumeMounts:
        - mountPath: /bitnami/redis/data
          name: my-volumen
      ...
      volumes:
      - name: my-volumen
        persistentVolumeClaim:
          claimName: my-pvc-redis
