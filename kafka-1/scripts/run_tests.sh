#!/bin/bash

# Carrega variáveis de ambiente
source ../.env

# Testa se o tópico transactions contém mensagens
docker exec -it kafka-cluster_kafka_1 kafka-console-consumer --topic transactions --from-beginning --bootstrap-server localhost:9092 --timeout-ms 5000 > output.txt

if grep -q "transaction_id" output.txt; then
  echo "Teste bem-sucedido: Mensagens encontradas no tópico 'transactions'"
else
  echo "Teste falhou: Nenhuma mensagem encontrada no tópico 'transactions'"
fi

# Limpa arquivo de saída
rm output.txt
