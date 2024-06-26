#!/bin/bash

# Carrega variáveis de ambiente
source ../.env

# Carrega dados no tópico transactions
docker exec -i kafka-cluster_kafka1_1 kafka-console-producer --topic transactions --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9094 << EOF
{"transaction_id": "1", "amount": "1000", "type": "deposit"}
{"transaction_id": "2", "amount": "200", "type": "withdrawal"}
EOF
