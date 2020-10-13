FROM python:alpine as builder
# Заимтовано от https://hub.docker.com/r/jertel/elastalert-docker/dockerfile
LABEL description="ElastAlert suitable for Kubernetes and Helm"
LABEL maintainer="Datana Ltd, city Moscow"

RUN apk --update upgrade && \
    apk add git && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /opt/elastalert && \
    git clone -b alt https://github.com/jertel/elastalert /tmp/elastalert && \
    cd /tmp/elastalert && \
    pip install setuptools wheel && \
    python setup.py sdist bdist_wheel

FROM python:alpine

COPY --from=builder /tmp/elastalert/dist/*.tar.gz /tmp/

RUN apk --update upgrade && \
    apk add gcc libffi-dev musl-dev python3-dev openssl-dev tzdata libmagic && \
	pip install /tmp/*.tar.gz && \
    apk del gcc libffi-dev musl-dev python3-dev openssl-dev && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /opt/elastalert && \
	echo "#!/bin/sh" >> /opt/elastalert/run.sh && \
    echo "set -e" >> /opt/elastalert/run.sh && \
    echo "elastalert-create-index --config /opt/config/elastalert_config.yaml" >> /opt/elastalert/run.sh && \
    echo "elastalert --config /opt/config/elastalert_config.yaml \"\$@\"" >> /opt/elastalert/run.sh && \
    chmod +x /opt/elastalert/run.sh

ENV TZ "UTC"

WORKDIR /opt/elastalert
ENTRYPOINT ["/opt/elastalert/run.sh"]