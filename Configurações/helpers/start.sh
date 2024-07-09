#!/bin/bash

# Variáveis
KAFKA_VERSION="0.8.2.2"
SCALA_VERSION="2.10"
KAFKA_DIR="kafka_${SCALA_VERSION}-${KAFKA_VERSION}"
KAFKA_TGZ="${KAFKA_DIR}.tgz"
KAFKA_URL="https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_TGZ}"

# Função para instalar Java 6 (Apenas para Debian/Ubuntu)
install_java6() {
    echo "Instalando Java 6..."
    sudo apt-get update
    sudo apt-get install -y openjdk-6-jdk
}

# Verificar se o Java 6 está instalado
check_java6() {
    java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ "$java_version" =~ "1.6" ]]; then
        echo "Java 6 já está instalado."
    else
        echo "Java 6 não encontrado."
        install_java6
    fi
}

# Baixar e extrair Kafka
download_kafka() {
    echo "Baixando Kafka ${KAFKA_VERSION}..."
    wget $KAFKA_URL
    echo "Extraindo Kafka..."
    tar -xzf $KAFKA_TGZ
}

# Iniciar ZooKeeper
start_zookeeper() {
    echo "Iniciando ZooKeeper..."
    $KAFKA_DIR/bin/zookeeper-server-start.sh $KAFKA_DIR/config/zookeeper.properties > /dev/null 2>&1 &
    sleep 5
}

# Iniciar Kafka
start_kafka() {
    echo "Iniciando Kafka..."
    $KAFKA_DIR/bin/kafka-server-start.sh $KAFKA_DIR/config/server.properties > /dev/null 2>&1 &
    sleep 5
}

# Criar tópico de teste
create_test_topic() {
    echo "Criando tópico de teste..."
    $KAFKA_DIR/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
}

# Produzir mensagens de teste
produce_messages() {
    echo "Produzindo mensagens de teste..."
    echo -e "Mensagem 1\nMensagem 2" | $KAFKA_DIR/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
}

# Consumir mensagens de teste
consume_messages() {
    echo "Consumindo mensagens de teste..."
    $KAFKA_DIR/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning --timeout-ms 5000
}

# Executar funções
check_java6
download_kafka
start_zookeeper
start_kafka
create_test_topic
produce_messages
consume_messages

echo "Configuração do Kafka 0.8.2.2 concluída com sucesso."
