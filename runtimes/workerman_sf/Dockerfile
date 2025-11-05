FROM scratch
COPY . /www
ENV APP_RUNTIME=CrazyGoat\\WorkermanBundle\\Runtime
WORKDIR /www

ENTRYPOINT ["./bin/php", "public/index.php", "start"]
