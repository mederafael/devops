#!/bin/bash

# Carrega variáveis de ambiente
source ../.env

# Cria tópicos
docker exec -it kafka-cluster_kafka_1 kafka-topics --create --topic transactions --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1
