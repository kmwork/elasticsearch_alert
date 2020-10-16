####FROM jertel/elastalert-docker:0.2.4
FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"

MAINTAINER Datana Ltd https://datana.ru


## копирование конфигов
RUN mkdir -p /opt/config
## ADD /tmp/datana/elastalert/elastalert_config.yaml /opt/config/elastalert_config.yaml
COPY elastalert_config.yaml /opt/config/elastalert_config.yaml

ENV TZ "UTC"
ENV LANG=C.UTF-8

EXPOSE 3030
WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]