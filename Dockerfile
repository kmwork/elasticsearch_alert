### FROM python:alpine
FROM jertel/elastalert-docker:latest
####FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"

MAINTAINER Datana Ltd https://datana.ru

RUN apk --update upgrade && \
    apk add linux-headers && \
    apk add build-base && \
    apk add git && \
    apk add gettext && \
    apk add bash && \
    apk add gcc && \
    apk add libc-dev && \
    apk add librdkafka-dev && \
    apk add librdkafka && \
    apk add musl-dev && \
    apk add python3-dev

## копирование конфигов -------------
COPY /elastalert_rules_yaml/*.yaml /opt/datana_templates/
COPY run.sh /opt/datana/
## Конец: копирование конфигов -------------

# для кафки ------------------------
RUN git clone -b dev https://github.com/0xStormEye/elastalert_kafka.git /tmp/elast_kafka && \
    pip3 install setuptools wheel confluent_kafka && \
    mkdir -p /opt/elastalert/elastalert_modules && \
    mv -f /tmp/elast_kafka/elastalert_modules/*.py /opt/elastalert/elastalert_modules/
# КОНЕЦ: для кафки ------------------------

RUN apk del gcc libc-dev librdkafka-dev musl-dev python3-dev && \
    rm -rf /var/cache/apk/*

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
### ENV ES_URL_PREFIX=""

# для кафки
ENV KAFKA_BROKERS_HOST=""
ENV KAFKA_GROUP_ID=""
ENV KAFKA_TOPIC=""

## НЕ МЕНЯТЬ !!!! для кастомных модулей на питоне для кафки (в частности)
ENV PYTHONPATH=/opt/elastalert/elastalert_modules
ENV PYTHONDEBUG=true


WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/datana/run.sh"]