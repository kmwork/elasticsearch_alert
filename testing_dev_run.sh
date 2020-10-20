#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
### для тестирования
### **********************************************
### текущий каталог
BIN_DIR=$(pwd)

DS_DOCKER_NAME="datana-smart/proba_elastalert:0.0.1"

echo "[DATANA:SHELL] ================================ Run dockerfile ================================"
docker build --tag $DS_DOCKER_NAME $BIN_DIR



### файл - переменные окружения для dev стенда
ENV_FILE=$BIN_DIR/testing_dev.env

echo "[DATANA:SHELL] ================================ Build dockerfile ================================"
docker run -d --env-file=$ENV_FILE $DS_DOCKER_NAME
