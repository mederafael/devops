$ bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic meu-topico
$ bin/kafka-console-producer.sh --broker-list localhost:9092 --topic meu-topico --property "parse.key=true" --property "key.separator=:"
> chave1:valor1
> chave2:valor2

$ bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic meu-topico --from-beginning --property print.key=true
$ ./producer.sh | bin/kafka-console-producer.sh --broker-list localhost:9092 --topic topico-rafael-2
