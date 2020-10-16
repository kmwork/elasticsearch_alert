FROM jertel/elastalert-docker:0.2.4
### FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"

MAINTAINER Datana Ltd https://datana.ru


## копирование конфигов
COPY /tmp/datana/elastalert/elastalert_rules_yaml /opt/config

ENV TZ "UTC"
ENV LANG=C.UTF-8

EXPOSE 3030
WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]