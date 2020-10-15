FROM jertel/elastalert-docker:0.2.4
### FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"

MAINTAINER Datana Ltd https://datana.ru


## копирование конфигов
COPY ./elastalert_rules_yaml /opt/config

ENV TZ "UTC"
ENV LANG=C.UTF-8

# value = datana-logs.datana.ru
ENV ES_HOST=${ES_HOST}

# value = 9200
ENV ES_PORT=${ES_PORT}

# value = elastic
ENV ES_USERNAME=${ES_USERNAME}

# value = changeme
ENV ES_PASSWORD=${ES_PASSWORD}

# value = False
ENV ES_USE_SSL=${ES_USE_SSL}

EXPOSE 3030
WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]