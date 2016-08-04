#!/bin/bash

# indexing
curl -X 'POST' -H 'Content-Type:application/json' --data-binary @marco-index.json localhost:8090/druid/indexer/v1/task

sleep 5

# pushes data
curl -X 'POST' -H 'Content-Type:application/json' --data-binary @marco-index.json localhost:8090/druid/indexer/v1/tas

sleep 10

# inspects metadata
echo -e "\n================================\n\n"
curl -L -H'Content-Type: application/json' -XPOST ST http://localhost:8082/druid/v2/?pretty -d'
{
    "queryType" : "segmentMetadata",
    "dataSource": "marcolog"
}'
echo -e "\n================================\n\n"

# querying
curl -L -H'Content-Type: application/json' -XPOST --data-binary @marco-query-status-pie-chart.json http://localhost:8082/druid/v2/?pretty
