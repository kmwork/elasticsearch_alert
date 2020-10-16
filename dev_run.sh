#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
###
### **********************************************
### текущий каталог
BIN_DIR=$(pwd)

DS_DOCKER_NAME="datana-smart/proba_elastalert:0.0.1"


## временнвая папка
WORK_TEMP_DIR=$BIN_DIR/temp_work
mkdir -p $WORK_TEMP_DIR

### файл - переменные окружения для dev стенда
ENV_FILE_TEMPLATE="$BIN_DIR/env_folder/env_dev_stand_with_params.env"
ENV_FILE="$WORK_TEMP_DIR/.env"

### путь на наши конфиги
CONFIG_FILE_TEMPLATE=$BIN_DIR/elastalert_rules_yaml/elastalert_config_with_params.yaml
CONFIG_FILE=$WORK_TEMP_DIR/elastalert_config.yaml

export ES_HOST=datana-logs.datana.ru
export ES_PORT=9200
export ES_USERNAME=elastic
export ES_PASSWORD=changeme
export ES_USE_SSL=False
cat $CONFIG_FILE_TEMPLATE | envsubst >$CONFIG_FILE
cat $ENV_FILE_TEMPLATE | envsubst >$ENV_FILE

if test -f "$ENV_FILE"; then
  echo "[DATANA:SHELL] ok, exists file: ENV_FILE=$ENV_FILE"
else
  echo "[DATANA:SHELL] error, not exists file: ENV_FILE=$ENV_FILE"
  exit
fi

if test -f "$CONFIG_FILE"; then
  echo "[DATANA:SHELL] ok, exists file: CONFIG_FILE=$CONFIG_FILE"
else
  echo "[DATANA:SHELL] error, not exists file: CONFIG_FILE=$CONFIG_FILE"
  exit
fi

echo "[DATANA:SHELL] ================================ Run dockerfile ================================"
docker build --tag $DS_DOCKER_NAME $BIN_DIR

echo "[DATANA:SHELL] ================================ Build dockerfile ================================"
docker run -d --env-file=$ENV_FILE $DS_DOCKER_NAME
