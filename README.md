## ПО для JIRA 
    докер - https://jira.dds.lanit.ru/browse/NKR-783
    взято за основу проект https://hub.docker.com/r/jertel/elastalert-docker/
    и он же в GitHub https://github.com/jertel/elastalert-docker
    для правил https://jira.dds.lanit.ru/browse/NKR-874
## Состав:
```
    + elastalert_rules_yaml -- папка YAML файлов
    elastalert_config_with_params.yaml -- настройки для запуска скрипов и правила на YAML синтаксисе
    
    socker_alert_is_down_rule.yaml -- на случай "тишины", когда нет информации о температуре или она с ошибкой
    socket_alert_is_up_rule.yaml -- на восстановление сбоя, когда данные с датчика температруры стали поступать 
    socket_out_of_range_rule.yaml -- сбор когда температура меньше 20 С или больше 30 -- то есть вышла "комнатного климата
```
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

## О правилах 
C Ильей договорились что события (триггеры) будут независимые и без состояний
1) триггер на тишину
2) триггер на восстановления измерения значения температуры
3) триггер выход температуры из диапазона от 20 до 30 С (значения временно захрадкодим в YAML файле правила)

суть главное — алерты не могут иметь память на состояние , поэтому делаем правила не зависимые и упростили в рамках реалий Free версии Еlastic (ELK-Stack)