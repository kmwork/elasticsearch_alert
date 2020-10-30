#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
### (работает внутри докера)
### **********************************************
### текущий каталог
WORK_DATANA_DIR=/opt/datana

## временнвая папка
TEMPLETE_DIR=/opt/datana_templates
# Подготовка конфгов
TEMPLETE_FILES=$TEMPLETE_DIR/*.yaml
for f in $TEMPLETE_FILES
do
  newNameFile="$(basename -- $f)"
  echo "Processing $f file to $newNameFile"
  # take action on each file. $f store current file name
  cat $f | envsubst >$WORK_DATANA_DIR/$newNameFile
done
CONFIG_FILE_DATANA=$WORK_DATANA_DIR/d_config.yaml
CONFIG_FILE=/opt/config/elastalert_config.yaml

mkdir -p /opt/config
mv -f $CONFIG_FILE_DATANA $CONFIG_FILE

## для откладки запросов в лог
exec elastalert --verbose --config $CONFIG_FILE --es_debug_trace /var/log/datana_alert.log

# для боя, без тонны логов
##exec elastalert --verbose --config $CONFIG_FILE