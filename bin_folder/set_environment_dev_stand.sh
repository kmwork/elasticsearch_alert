#!/bin/sh -xe
export ENV_ES_HOST="datana-logs.datana.ru"
export ENV_ES_PORT="9200"

### вывод к консоль для отдадки
echo "[DATANA:SHELL] ENV_ES_HOST = $ENV_ES_HOST"
echo "[DATANA:SHELL] ENV_ES_PORT = $ENV_ES_PORT"