#!/bin/sh
set -e

echo -e "
tickTime=2000\n\
initLimit=10\n\
syncLimit=5\n\
dataDir=/tmp/zookeeper\n\
dataLogDir=/var/log/zookeeper\n\
autopurge.snapRetainCount=3\n\
autopurge.purgeInterval=1" >> /opt/zookeeper/conf/zoo.cfg

# Configura o clientPort no zoo.cfg
if [ -n "$ZOO_CLIENT_PORT" ]; then
  echo "clientPort=$ZOO_CLIENT_PORT" >> /opt/zookeeper/conf/zoo.cfg
  echo "$ZOO_SERVER1" >> /opt/zookeeper/conf/zoo.cfg
  echo "$ZOO_SERVER2" >> /opt/zookeeper/conf/zoo.cfg
  echo "$ZOO_SERVER3" >> /opt/zookeeper/conf/zoo.cfg
fi

cat /opt/zookeeper/conf/zoo.cfg

# Criar o arquivo myid
mkdir -p /tmp/zookeeper
echo ${ZOO_MY_ID} > /tmp/zookeeper/myid

while ! ping -c 1 "zookeeper1"; do
  echo "Waiting for the host to be reachable..."
  sleep 5
done

while ! ping -c 1 "zookeeper2"; do
  echo "Waiting for the host to be reachable..."
  sleep 5
done

while ! ping -c 1 "zookeeper3"; do
  echo "Waiting for the host to be reachable..."
  sleep 5
done

# Executa o ZooKeeper padrão
exec zkServer.sh start-foreground

# Permite executar comandos arbitrários, se fornecidos
# if [ "${1:0:1}" = '-' ]; then
#    set -- zkServer.sh "$@"
# fi

# Troca para o usuário zookeeper se o comando for zkServer.sh
# if [ "$1" = 'zkServer.sh' ]; then
#    exec su-exec zookeeper "$@"
# fi

# exec "$@"
