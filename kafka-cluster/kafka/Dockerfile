# Dockerfile
FROM alpine:3.17

# Instala dependências necessárias
RUN apk add --no-cache \
    openjdk11-jre-headless \
    wget \
    bash \
    su-exec

# Define o diretório de trabalho
WORKDIR /opt/kafka

# Baixa e instala o Kafka
ENV KAFKA_VERSION=3.7.0
RUN wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz \
    && tar -xzf kafka_2.13-${KAFKA_VERSION}.tgz \
    && mv kafka_2.13-${KAFKA_VERSION}/* /opt/kafka/ \
    && rm kafka_2.13-${KAFKA_VERSION}.tgz

# Cria o usuário kafka
RUN addgroup -S kafka && adduser -S kafka -G kafka

# Cria os diretórios necessários e ajusta permissões
RUN mkdir -p /var/lib/kafka/data /opt/kafka/config \
    && chown -R kafka:kafka /opt/kafka /var/lib/kafka

# Define o diretório bin do Kafka no PATH
ENV PATH="/opt/kafka/bin:${PATH}"

# Exponha a porta do Kafka
EXPOSE 9092

# Copia os scripts de inicialização
COPY docker-entrypoint.sh /usr/local/bin/
#COPY kafka-init.sh /usr/local/bin/ /usr/local/bin/kafka-init.sh  /usr/local/bin/kafka-init.sh
COPY server.properties /opt/kafka/config/server.properties
COPY fix-permissions.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/fix-permissions.sh \
    && chown kafka:kafka /usr/local/bin/docker-entrypoint.sh /opt/kafka/config/server.properties

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
