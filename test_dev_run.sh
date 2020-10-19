#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
### для тестирования
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
export ES_WRITEBACK_INDEX=dev_index_alert
export ES_WRITEBACK_ALIAS=dev_alerts
export RULE_INDEX=datana-smart-dev-logs-*
export RULE_TELEGRAM_BOT_TOKEN=1171367749:AAFgyOW0LGRLl9NHo9TkZIGNUdd6cFKYGqo
export RULE_TELEGRAM_ROOM_ID=@DatanaReleaseEvent

#cat $CONFIG_FILE_TEMPLATE | envsubst >$CONFIG_FILE
#cat $ENV_FILE_TEMPLATE | envsubst >$ENV_FILE


TEMPLETE_FILES=$BIN_DIR/elastalert_rules_yaml/*.yaml
for f in $TEMPLETE_FILES
do
  newNameFile="$(basename -- $f)"
  echo "Processing $f file to $newNameFile"
  # take action on each file. $f store current file name
  cat $f | envsubst >$WORK_TEMP_DIR/$newNameFile
done


echo "[DATANA:SHELL] ================================ Run dockerfile ================================"
docker build --tag $DS_DOCKER_NAME $BIN_DIR

echo "[DATANA:SHELL] ================================ Build dockerfile ================================"
###docker run -d --env-file=$ENV_FILE $DS_DOCKER_NAME
