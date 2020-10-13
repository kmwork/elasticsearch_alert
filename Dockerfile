FROM jertel/elastalert-docker:0.2.4
###FROM jertel/elastalert-docker:latest
# Заимствовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"
LABEL maintainer="Datana Ltd, city Moscow"

ENV TZ "UTC"

WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]