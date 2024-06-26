#!/bin/bash

# Carrega variáveis de ambiente
source ../.env

# Carrega dados no tópico transactions
docker exec -i kafka-cluster_kafka_1 kafka-console-producer --topic transactions --bootstrap-server localhost:9092 << EOF
{"transaction_id": "1", "amount": "1000", "type": "deposit"}
{"transaction_id": "2", "amount": "200", "type": "withdrawal"}
EOF
