#!/bin/sh
set -e

# Corrige permissões dos volumes
chown -R kafka:kafka /var/lib/kafka /opt/kafka/config /var/log/kafka/


echo "broker.id=${KAFKA_BROKER_ID}
listeners=${KAFKA_LISTENERS}
advertised.listeners=${KAFKA_ADVERTISED_LISTENERS}
zookeeper.connect=${KAFKA_ZOOKEEPER_CONNECT}
log.dirs=${KAFKA_LOG_DIRS:-/var/log/kafka}
num.partitions=3
default.replication.factor=3
min.insync.replicas=2
message.max.bytes=1000012
auto.leader.rebalance.enable=true
request.timeout.ms=30000" > "/opt/kafka/config/server2.properties"


KAFKA_CONFIG="/opt/kafka/config/server2.properties"

# Função para verificar se um contêiner Kafka está pronto
check_container_ready() {
  local container_name=$1
  while ! ping -c 1 $container_name &>/dev/null; do
    echo "Aguardando contêiner Kafka $container_name ficar pronto..."
    sleep 5
  done
  return 0
}

# Loop para verificar todos os contêineres zookeeper2 e kafka
while true; do
  if check_container_ready zookeeper1 && check_container_ready zookeeper2 && check_container_ready zookeeper3 && check_container_ready kafka1 && check_container_ready kafka2 && check_container_ready kafka3; then
    # Iniciar o Kafka
    echo "Iniciando o Kafka..."
    su-exec kafka kafka-server-start.sh $KAFKA_CONFIG
    break
  else
    echo "Nem todos os contêineres Kafka estão prontos. Tentando novamente em 5 segundos..."
    sleep 5
  fi
done
