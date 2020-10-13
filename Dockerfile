FROM jertel/elastalert-docker:latest
# Заимтовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"
LABEL maintainer="Datana Ltd, city Moscow"

ENV TZ "UTC"

WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]