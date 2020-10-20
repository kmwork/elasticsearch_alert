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
ENV ES_HOST=""
ENV ES_PORT=9200
ENV ES_USERNAME=elastic
ENV ES_PASSWORD=""
ENV ES_USE_SSL=False
ENV ES_WRITEBACK_INDEX=dev_index_alert
ENV ES_WRITEBACK_ALIAS=dev_alerts
ENV RULE_INDEX=""
ENV RULE_TELEGRAM_BOT_TOKEN=""
ENV RULE_TELEGRAM_ROOM_ID=""

WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/datana/run.sh"]