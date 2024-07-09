#!/bin/bash

# Verificando a presença do arquivo java
if [ ! -f "/opt/java/bin/java" ]; then
    echo "Java executável não encontrado em /opt/java/bin/java"
    exit 1
fi

# Garantindo que o Java tem permissões de execução
chmod +x /opt/java/bin/java

# Testando a versão do Java
echo "Verificando a versão do Java..."
/opt/java/bin/java -version

# Verificando a existência e permissões dos arquivos de configuração do Kafka
echo "Verificando arquivos de configuração do Kafka..."
if [ -f "/opt/kafka/config/server.properties" ]; then
    echo "server.properties encontrado."
    ls -l /opt/kafka/config/server.properties
else
    echo "server.properties não encontrado."
    exit 1
fi

# Verificando a existência e permissões dos arquivos de configuração do Zookeeper
echo "Verificando arquivos de configuração do Zookeeper..."
if [ -f "/opt/kafka/config/zookeeper.properties" ]; then
    echo "zookeeper.properties encontrado."
    ls -l /opt/kafka/config/zookeeper.properties
else
    echo "zookeeper.properties não encontrado."
    exit 1
fi

# Verificando a existência e permissões dos arquivos de configuração do Supervisor
echo "Verificando arquivos de configuração do Supervisor..."
if [ -f "/etc/supervisor/conf.d/kafka.conf" ]; then
    echo "kafka.conf encontrado."
    ls -l /etc/supervisor/conf.d/kafka.conf
else
    echo "kafka.conf não encontrado."
    exit 1
fi

if [ -f "/etc/supervisor/conf.d/zookeeper.conf" ]; then
    echo "zookeeper.conf encontrado."
    ls -l /etc/supervisor/conf.d/zookeeper.conf
else
    echo "zookeeper.conf não encontrado."
    exit 1
fi

echo "Todos os testes passaram com sucesso."
