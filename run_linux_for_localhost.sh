#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
###
### **********************************************
### текущий каталог
BIN_DIR=$(pwd)

DS_DOCKER_NAME="datana-smart/proba_elastalert:0.0.1"
echo "[DATANA:SHELL] ================================ Build dockerfile ================================"
docker build --tag $DS_DOCKER_NAME $BIN_DIR


echo "[DATANA:SHELL] ================================ Run dockerfile ================================"
### docker run   $DS_DOCKER_NAME
