#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
###
### **********************************************
### текущий каталог
BIN_DIR=$(pwd)

DS_DOCKER_NAME="datana-smart/proba_elastalert:0.0.1"
echo "[DATANA:SHELL] ================================ Build dockerfile ================================"
##### docker build --tag $DS_DOCKER_NAME $BIN_DIR

### файл - переменные окружения для dev стенда
ENV_FILE="$BIN_DIR/env_folder/env_dev_stand.env"

if test -f "$ENV_FILE"; then
  echo "[DATANA:SHELL] ok, exists file: ENV_FILE=$ENV_FILE"
else
  echo "[DATANA:SHELL] error, not exists file: ENV_FILE=$ENV_FILE"
  exit
fi

### путь на наши конфиги
CONFIG_FILE=$BIN_DIR/elastalert_rules_yaml/elastalert_config.yaml
if test -f "$CONFIG_FILE"; then
  echo "[DATANA:SHELL] ok, exists file: CONFIG_FILE=$CONFIG_FILE"
else
  echo "[DATANA:SHELL] error, not exists file: CONFIG_FILE=$CONFIG_FILE"
  exit
fi


export ES_HOST=datana-logs.datana.ru
export ES_PORT=9200
export ES_USERNAME=elastic
export ES_PASSWORD=changeme
export ES_USE_SSL=False

echo "[DATANA:SHELL] ================================ Run dockerfile ================================"
docker run -d -v $CONFIG_FILE:/opt/config/config.yaml \
  --env-file $ENV_FILE \
  $DS_DOCKER_NAME
