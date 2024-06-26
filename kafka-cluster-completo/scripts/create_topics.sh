#!/bin/bash

# Função para verificar se o Kafka está pronto
wait_for_kafka() {
  local retry_count=0
  local max_retries=20
  local wait_seconds=5

  while [ $retry_count -lt $max_retries ]; do
    if kafka-topics --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9094 --list > /dev/null 2>&1; then
      echo "Kafka está pronto!"
      return 0
    else
      echo "Aguardando Kafka iniciar... Tentativa $((retry_count+1)) de $max_retries"
      retry_count=$((retry_count+1))
      sleep $wait_seconds
    fi
  done

  echo "Kafka não está pronto após $max_retries tentativas."
  exit 1
}

# Espera Kafka estar pronto
wait_for_kafka

# Cria tópicos
IFS=',' read -ra TOPIC_CONFIGS <<< "$KAFKA_CREATE_TOPICS"
for TOPIC_CONFIG in "${TOPIC_CONFIGS[@]}"; do
  IFS=':' read -ra CONFIG <<< "$TOPIC_CONFIG"
  TOPIC="${CONFIG[0]}"
  PARTITIONS="${CONFIG[1]}"
  REPLICATION="${CONFIG[2]}"
  kafka-topics --create --topic "$TOPIC" --partitions "$PARTITIONS" --replication-factor "$REPLICATION" --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9094
done

# Imprime todos os tópicos
kafka-topics --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9094 --list
