#!/bin/sh -xe
### **********************************************
### ******** Проект Докер под Elastalert
###
### взято от сюда https://github.com/Yelp/elastalert
### **********************************************
CONFIG_DIR=$(pwd)/datana_elastalert
echo "CONFIG_DIR=$CONFIG_DIR"
git clone https://github.com/bitsensor/elastalert.git
cd elastalert
docker run -d -p 3030:3030 \
  -v $CONFIG_DIR/config/elastalert.yaml:/opt/elastalert/config.yaml \
  -v $CONFIG_DIR/config/config.json:/opt/elastalert-server/config/config.json \
  -v $CONFIG_DIR/rules:/opt/elastalert/rules \
  -v $CONFIG_DIR/rule_templates:/opt/elastalert/rule_templates \
  --net="host" \
  --name elastalert bitsensor/elastalert:latest
