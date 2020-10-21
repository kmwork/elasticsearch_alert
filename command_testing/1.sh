#!/bin/sh -xe
curl -H 'Content-Type: application/json' -XGET 'http://datana-logs.datana.ru:9200/datana-smart-dev-logs-*/_doc/_search?pretty&ignore_unavailable=true&size=0' -d '{
  "aggs": {
    "bucket_aggs": {
      "aggs": {
        "interval_aggs": {
          "aggs": {
            "metric_level_value_count": {
              "value_count": {
                "field": "level"
              }
            }
          },
          "date_histogram": {
            "field": "@timestamp",
            "interval": "1m"
          }
        }
      },
      "terms": {
        "field": "level",
        "min_doc_count": 1,
        "size": 50
      }
    }
  },
  "query": {
    "bool": {
      "filter": {
        "bool": {
          "must": [
            {
              "range": {
                "@timestamp": {
                  "gt": "2020-10-21T09:20:00Z",
                  "lte": "2020-10-21T19:20:00Z"
                }
              }
            },
            {
              "query_string": {
                "query": "(@timestamp <=now+1h)"
              }
            }
          ]
        }
      }
    }
  }
}'