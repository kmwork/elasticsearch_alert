### FROM jertel/elastalert-docker:0.2.4
FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"

MAINTAINER Datana Ltd https://datana.ru


COPY ./elastalert_rules_yaml/elastalert_config.yaml /opt/config/elastalert_config.yaml
ENV TZ "UTC"
ENV LANG=C.UTF-8

WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]