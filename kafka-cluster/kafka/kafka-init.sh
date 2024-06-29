#!/bin/bash

# Espera o Kafka estar disponível
while ! nc -z localhost 9092; do   
  sleep 2
done

# Função para criar tópico se não existir
create_topic() {
  TOPIC_NAME=$1
  if /opt/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092 | grep -q $TOPIC_NAME; then
    echo "Tópico '$TOPIC_NAME' já existe."
  else
    /opt/kafka/bin/kafka-topics.sh --create --topic $TOPIC_NAME --bootstrap-server localhost:9092 --partitions 3 --replication-factor 3
    echo "Tópico '$TOPIC_NAME' criado com sucesso."
  fi
}

# Criação de tópicos de transações bancárias
create_topic "credit-card-transactions"

# Você pode adicionar mais tópicos ou outras configurações aqui, se necessário
