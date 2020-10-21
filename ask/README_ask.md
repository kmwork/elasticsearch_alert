само правило <this project>/elastalert_rules_yaml/elk_alert_ui_video_adapter.yaml

## как запускать на машине логов без докера
### как пример: 
```
elastalert-test-rule  elk_alert_ui_video_adapter.yaml --config ./../temp_work/elastalert_config.yaml
```
лог <this project>/ask/console.log
где elastalert_config.yaml -- то же что и elastalert_rules_yaml/elastalert_config_with_params.yaml но с постановкой 
параметров 

## Отладка правил
```
python3 -m elastalert.elastalert --config ./../temp_work/elastalert_config.yaml --rule elk_alert_ui_video_adapter.yaml --verbose --es_debug_trace ./../ask/alert.log
```
лог <this project>/ask/alert.log