## ПО для JIRA 
    https://jira.dds.lanit.ru/browse/NKR-783
    взято за основу проект https://hub.docker.com/r/jertel/elastalert-docker/
    и он же в GitHub https://github.com/jertel/elastalert-docker
## Состав:
```
+ elastalert_rules_yaml -- папка YAML файлов
elastalert_config_with_params.yaml -- конфиг для запуска скрипов (конфигов других по alert)
socker_alert_is_down.yaml -- алерт на случае если упал сервис сокет-адаптер
socket_alert_is_up.yaml  -- алерт на случае если поднялся сервис сокет-адаптер

## как запускать на машине логов без докера
### как пример: 
```
elastalert-test-rule elk_alert_socket_adapter.yaml --alert --days=1 --config ./../temp_work/elastalert_config.yaml 
```
### в докере (само должно запускаться, но на всякий случай ниже команды)
```
elastalert-test-rule /opt/datana/elk_alert_new_video_adapter.yaml --config /opt/config/elastalert_config.yaml

elastalert --verbose --config /opt/config/elastalert_config.yaml --start=NOW --rule /opt/datana/socker_alert_is_down.yaml --es_debug_trace alert.log
```

## Как запустить докер
### на сборку докера
```
docker build .
```
### на запуск
```
docker run --env-file=./env_folder/env_dev_stand.env -p 3030:3030 -it 1ee7aaa809e0
```
где 1ee7aaa809e0 -- хеш-код от первой команды `docker build 

## нужно задать переменные окружения
```
export ES_HOST=datana-logs.datana.ru
export ES_PORT=9200
export ES_USERNAME=elastic
export ES_PASSWORD=<изменено значение>
export ES_USE_SSL=False
export ES_WRITEBACK_INDEX=dev_index_alert
export ES_WRITEBACK_ALIAS=dev_alerts
export RULE_INDEX=datana-smart-dev-logs-*
export RULE_TELEGRAM_BOT_TOKEN=<число:символы>
export RULE_TELEGRAM_ROOM_ID=<изменено значение с начиная с @>
```

## Отладка правил
```
elastalert --config ./../temp_work/elastalert_config.yaml --rule elk_alert_ui_video_adapter.yaml --verbose --es_debug_trace ./../ask/alert.log

elastalert  --config /opt/config/elastalert_config.yaml --rule k.yaml --verbose --es_debug_trace alert.log
```