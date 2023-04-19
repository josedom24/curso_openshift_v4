# docker

El fichero `Dockerfile`:

```
FROM rhscl/php-56-rhel7
EXPOSE 8080
COPY . /app
ENV INFORMACION="Imagen construida con Dockerfile"
CMD /bin/bash -c 'php -S 0.0.0.0:8080'
``` 