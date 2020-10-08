#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
###
### взято от сюда https://github.com/Yelp/elastalert
### **********************************************

### читаем переменные окружения для dev стенда
sh ./set_environment_dev_stand.sh

### папка для скачки github сорцов
ELAST_ALERT_DIR=/temp/datana_temp/elastalert

### удаляем старый мусор
rm -rf $ELAST_ALERT_DIR

### путь на наши конфиги
CONFIG_DIR=$(pwd)/../datana_elastalert

### вывод к консоль для отдадки
echo "[DATANA:SHELL] CONFIG_DIR=$CONFIG_DIR"

### качаем сорцы
git clone https://github.com/bitsensor/elastalert.git
cd $ELAST_ALERT_DIR

### делаем докер
docker run -d -p 3030:3030 \
  -v $CONFIG_DIR/config/elastalert.yaml:/opt/elastalert/config.yaml \
  -v $CONFIG_DIR/config/config.json:/opt/elastalert-server/config/config.json \
  -v $CONFIG_DIR/rules:/opt/elastalert/rules \
  -v $CONFIG_DIR/rule_templates:/opt/elastalert/rule_templates \
  --name elastalert bitsensor/elastalert:latest
