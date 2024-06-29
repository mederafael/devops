#!/bin/sh
set -e

# Corrige permissões dos volumes
/usr/local/bin/fix-permissions.sh

# Define os argumentos padrão do Kafka
KAFKA_CONFIG="/opt/kafka/config/server.properties"

# Inicia o Kafka
su-exec kafka kafka-server-start.sh $KAFKA_CONFIG &

# Espera o Kafka iniciar
while ! nc -z localhost 9092; do
  sleep 1
done

# Executa o script de inicialização, se existir
#if [ -x /usr/local/bin/kafka-init.sh ]; then
  #su-exec kafka /usr/local/bin/kafka-init.sh
#fi

# Mantém o contêiner ativo
wait
