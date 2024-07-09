#!/bin/bash

# Variáveis
KAFKA_VERSION="0.8.2.2"
SCALA_VERSION="2.10"
KAFKA_DIR="kafka_${SCALA_VERSION}-${KAFKA_VERSION}"

start () {
    echo "Iniciando ZooKeeper..."
    $KAFKA_DIR/bin/zookeeper-server-start.sh $KAFKA_DIR/config/zookeeper.properties > /dev/null 2>&1 &
    echo "Iniciando Kafka..."
    $KAFKA_DIR/bin/kafka-server-start.sh $KAFKA_DIR/config/server.properties > /dev/null 2>&1 &
    echo "Verificar logs..."
}

start
