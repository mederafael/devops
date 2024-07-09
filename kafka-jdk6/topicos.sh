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