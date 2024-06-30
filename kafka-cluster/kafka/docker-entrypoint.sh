#!/bin/sh
set -e

# Corrige permissões dos volumes
chown -R kafka:kafka /var/lib/kafka /opt/kafka/config

#auto.leader.rebalance.enable=true
#min.insync.replicas=2
#export KAFKA_JVM_PERFORMANCE_OPTS="-server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+DisableExplicitGC -Djava.awt.headless=true"


echo "broker.id=${KAFKA_BROKER_ID}
listeners=${KAFKA_LISTENERS}
advertised.listeners=${KAFKA_ADVERTISED_LISTENERS}
zookeeper.connect=${KAFKA_ZOOKEEPER_CONNECT}
log.dirs=${KAFKA_LOG_DIRS}
num.partitions=1
default.replication.factor=1
min.insync.replicas=1
message.max.bytes=1000012
request.timeout.ms=30000" >> "/opt/kafka/config/server2.properties"


# Define os argumentos padrão do Kafka
KAFKA_CONFIG="/opt/kafka/config/server2.properties"

# Espera o Kafka iniciar
while ! ping -c 1 "kafka1"; do
  echo "Waiting for the host to be reachable..."
  sleep 5
done

# Espera o Kafka iniciar
while ! ping -c 1 "kafka2"; do
  echo "Waiting for the host to be reachable..."
  sleep 5
done

# Espera o Kafka iniciar
while ! ping -c 1 "kafka3"; do
  echo "Waiting for the host to be reachable..."
  sleep 5
done

# Inicia o Kafka
su-exec kafka kafka-server-start.sh $KAFKA_CONFIG &

#Função para criar tópico se não existir
 create_topic() {
  TOPIC_NAME="credit-card-transactions"
  if /opt/kafka/bin/kafka-topics.sh --list --bootstrap-server ${KAFKA_BROKER_HOST_NAME} | grep -q $TOPIC_NAME; then
    echo "Tópico '$TOPIC_NAME' já existe."
  else
    /opt/kafka/bin/kafka-topics.sh --create --topic $TOPIC_NAME --bootstrap-server ${KAFKA_BROKER_HOST_NAME} --partitions 3 --replication-factor 3
    echo "Tópico '$TOPIC_NAME' criado com sucesso."
  fi
}

# Criação de tópicos de transações bancárias
create_topic "credit-card-transactions"

# Mantém o contêiner ativo
wait
