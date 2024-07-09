# Usando uma imagem base leve do Alpine
FROM debian:bookworm-slim

# Definindo variáveis de ambiente
ENV KAFKA_VERSION=2.10-0.8.2.2
ENV SCALA_VERSION=2.10
ENV KAFKA_HOME=/opt/kafka
ENV JAVA_HOME=/opt/java
ENV PATH=$JAVA_HOME/bin:$PATH

# Atualizando a lista de pacotes e instalando dependências
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    net-tools \
    supervisor \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

# Copiando o Kafka fornecido externamente e descompactando
COPY resources/kafka/kafka_2.10-0.8.2.2.tgz /tmp/kafka.tgz
RUN mkdir -p ${KAFKA_HOME} && \
    tar -xzf /tmp/kafka.tgz -C ${KAFKA_HOME} --strip-components=1 && \
    rm /tmp/kafka.tgz

# Copiando o Java fornecido externamente e instalando
COPY resources/java/jdk-6u45-linux-x64.bin /tmp/jdk-6u45-linux-x64.bin
RUN mkdir -p ${JAVA_HOME} && \
    chmod +x /tmp/jdk-6u45-linux-x64.bin && \
    sh /tmp/jdk-6u45-linux-x64.bin -noregister && \
    mv jdk1.6.0_45/* ${JAVA_HOME}/ && \
    rm -rf jdk1.6.0_45 /tmp/jdk-6u45-linux-x64.bin

# Copiando arquivos de configuração para o contêiner
#COPY resources/kafka/server.properties ${KAFKA_HOME}/config/server.properties
#COPY resources/zookeeper/zookeeper.properties ${KAFKA_HOME}/config/zookeeper.properties
#COPY resources/kafka/kafka.conf /etc/supervisor/conf.d/kafka.conf
#COPY resources/zookeeper/zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf
#COPY resources/zookeeper/zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf
# COPY resources/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

# Copiando e executando o script de teste
#COPY resources/test/test-ambiente.sh /usr/local/bin/test-ambiente.sh
#RUN chmod +x /usr/local/bin/test-ambiente.sh

#Executando o script de teste e mantendo o contêiner em execução
#CMD /usr/local/bin/test-ambiente.sh && supervisord -c /etc/supervisor/supervisord.conf

CMD /opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties & \
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties

# Expondo as portas necessárias
EXPOSE 9092 2181
