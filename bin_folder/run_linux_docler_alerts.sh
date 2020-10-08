#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
###
### взято от сюда https://github.com/Yelp/elastalert
### **********************************************
### текущий каталог
BIN_DIR=$(pwd)

### папка для скачки github сорцов
ELAST_ALERT_DIR=/tmp/datana_temp/elastalert

### удаляем старый мусор
rm -rf $ELAST_ALERT_DIR

### создаем папку под сорцы
mkdir -p $ELAST_ALERT_DIR

### путь на наши конфиги
CONFIG_DIR=$BIN_DIR/../datana_elastalert

### вывод к консоль для отладки
echo "[DATANA:SHELL] CONFIG_DIR=$CONFIG_DIR"
### качаем сорцы
git clone https://github.com/bitsensor/elastalert.git $ELAST_ALERT_DIR
cd $ELAST_ALERT_DIR

### файл - переменные окружения для dev стенда
ENV_FILE="$BIN_DIR/../env_folder/env_dev_stand.env"

if test -f "$ENV_FILE"; then
    echo "[DATANA:SHELL] ok, exists file: $ENV_FILE"
else
  echo "[DATANA:SHELL] error, not exists file: $ENV_FILE"
  exit
fi

### делаем докер
docker run --env-file $ENV_FILE  -d -p 3030:3030 \
  -v $CONFIG_DIR/config/elastalert.yaml:/opt/elastalert/config.yaml \
  -v $CONFIG_DIR/rules:/opt/elastalert/rules \
  -v $CONFIG_DIR/rule_templates:/opt/elastalert/rule_templates \
  --name elastalert bitsensor/elastalert:latest
