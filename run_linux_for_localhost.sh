#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
###
### **********************************************
### текущий каталог
BIN_DIR=$(pwd)

DS_DOCKER_NAME="datana-smart/proba_elastalert:0.0.1"
echo "[DATANA:SHELL] ================================ Build dockerfile ================================"
### docker build --tag $DS_DOCKER_NAME $BIN_DIR

### файл - переменные окружения для dev стенда
ENV_FILE="$BIN_DIR/env_folder/env_dev_stand.env"

### путь на наши конфиги
CONFIG_DIR=$BIN_DIR/datana_elastalert

echo "[DATANA:SHELL] ================================ Run dockerfile ================================"
docker run -d -p 3030:3030 \
  -v $CONFIG_DIR/config/elastalert.yaml:/opt/elastalert/config.yaml \
  $DS_DOCKER_NAME