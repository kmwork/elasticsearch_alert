FROM jertel/elastalert-docker:0.2.4
####FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"

MAINTAINER Datana Ltd https://datana.ru


## копирование конфигов
COPY /elastalert_rules_yaml/*.yaml /opt/datana/
COPY ./dockerfile-insert.sh /opt/datana/
CMD ["/opt/datana/dockerfile-insert.sh"]

ENV TZ "UTC"
ENV LANG=C.UTF-8

CMD ["/opt/elastalert/run.sh"]

WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]