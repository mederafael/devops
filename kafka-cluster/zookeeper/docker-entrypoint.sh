#!/bin/sh
set -e

echo -e "
tickTime=2000\n\
initLimit=10\n\
syncLimit=5\n\
dataDir=/tmp/zookeeper\n\
dataLogDir=/var/log/zookeeper\n\
autopurge.snapRetainCount=3\n\
autopurge.purgeInterval=1\n\
clientPort=$ZOO_CLIENT_PORT\n\
$ZOO_SERVER1\n\
$ZOO_SERVER2\n\
$ZOO_SERVER3" > /opt/zookeeper/conf/zoo.cfg

# Criar o arquivo myid
mkdir -p /tmp/zookeeper
echo ${ZOO_MY_ID} > /tmp/zookeeper/myid
# Função para verificar se um contêiner Kafka está pronto
check_container_ready() {
  local container_name=$1
  while ! ping -c 1 $container_name &>/dev/null; do
    echo "Aguardando contêiner zookeeper $container_name ficar pronto..."
    sleep 5
  done
  return 0
}

# Loop para verificar todos os contêineres zookeeper
while true; do
  if check_container_ready zookeeper1 && check_container_ready zookeeper2 && check_container_ready zookeeper3; then
    # Iniciar o Kafka
    echo "Iniciando o zookeeper..."o
    exec zkServer.sh start-foreground
    break
  else
    echo "Nem todos os contêineres zookeeper estão prontos. Tentando novamente em 5 segundos..."
    sleep 5
  fi
done


# Permite executar comandos arbitrários, se fornecidos
# if [ "${1:0:1}" = '-' ]; then
#    set -- zkServer.sh "$@"
# fi

# Troca para o usuário zookeeper se o comando for zkServer.sh
# if [ "$1" = 'zkServer.sh' ]; then
#    exec su-exec zookeeper "$@"
# fi

# exec "$@"
