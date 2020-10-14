## ПО для JIRA 
    https://jira.dds.lanit.ru/browse/NKR-783
    взято за основу проект https://hub.docker.com/r/jertel/elastalert-docker/
    и он же в GitHub https://github.com/jertel/elastalert-docker
## Состав:
```
+ elastalert_rules_yaml -- папка YAML файлов
++ elastalert_config.yaml -- конфиг для запуска скрипов (конфигов других по alert)
++ elk_alert_socket_adapter.yaml -- проба пера для Socker Адаптер по alert
```

## как запускать на машине логов без докера или внутри докера
### как пример: 
```
user@datana-logs:~/datana-work/elk-alert$ elastalert-test-rule elk_alert_socket_adapter.yaml 
```
   
