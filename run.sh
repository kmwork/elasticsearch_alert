#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
### (работает внутри докера)
### **********************************************
### текущий каталог
WORK_DATANA_DIR=/opt/datana

### путь на наши конфиги
CONFIG_FILE_TEMPLATE=$WORK_DATANA_DIR/elastalert_config_with_params.yaml
CONFIG_FILE=/opt/config/elastalert_config.yaml

cat $CONFIG_FILE_TEMPLATE | envsubst >$CONFIG_FILE

if test -f "$CONFIG_FILE"; then
  echo "[DATANA:SHELL] ok, exists file: CONFIG_FILE=$CONFIG_FILE"
else
  echo "[DATANA:SHELL] error, not exists file: CONFIG_FILE=$CONFIG_FILE"
  exit
fi
/bin/bash /opt/elastalert/run.sh