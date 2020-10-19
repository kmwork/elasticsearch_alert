FROM jertel/elastalert-docker:0.2.4
####FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"

MAINTAINER Datana Ltd https://datana.ru


## копирование конфигов
RUN apk add gettext && apk add bash
COPY /elastalert_rules_yaml/*.yaml /opt/datana_templates/
COPY run.sh /opt/datana/

ENV TZ "UTC"
ENV LANG=C.UTF-8


WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/datana/run.sh"]