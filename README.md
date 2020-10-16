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

## как запускать на машине логов без докера
### как пример: 
```
user@datana-logs:~/datana-work/elk-alert$ elastalert-test-rule elk_alert_socket_adapter.yaml 
```
### в докере
```
elastalert-test-rule /datana_alert_rules/elk_alert_socket_adapter.yaml --config /opt/config/elastalert_config.yaml
```
 
### докер переменные окружения для dev стенда
ES_HOST=datana-logs.datana.ru
ES_PORT=9200
ES_USERNAME=elastic
ES_PASSWORD=changeme
ES_USE_SSL=False

### вредный перефик, с ним не работает
###ES_URL_PREFIX=dev

## адрес ELK
## http://datana-logs.datana.ru:9200/


## Как запустить докер
### на сборку докера
```
docker build .
```
### на запуск
```
docker run --env-file=./env_folder/env_dev_stand.env -p 3030:3030 -it 1ee7aaa809e0
```
где 1ee7aaa809e0 -- хеш-код от первой команды `docker build .`