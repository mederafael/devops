# Dockerfile
FROM alpine:3.17
#USER root
# Instala dependências necessárias
RUN apk add --no-cache \
    openjdk11-jre-headless \
    wget \
    su-exec \
    bash

# Define o diretório de trabalho
WORKDIR /opt/zookeeper

# Baixa e instala o ZooKeeper
ENV ZOOKEEPER_VERSION=3.9.2

# Instalar dockerize no Alpine
RUN apk add --no-cache wget \
    && wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz \
    && rm dockerize-linux-amd64-v0.6.1.tar.gz

RUN wget https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz \
    && tar -xzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz \
    && mv apache-zookeeper-${ZOOKEEPER_VERSION}-bin/* /opt/zookeeper/ \
    && rm apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz

# Copia o arquivo de configuração
# COPY zoo.cfg /opt/zookeeper/conf/zoo.cfg

# Cria o usuário zookeeper
RUN addgroup -S zookeeper && adduser -S zookeeper -G zookeeper

# Cria os diretórios necessários e ajusta permissões
RUN mkdir -p /var/lib/zookeeper /datalog \
    && chown -R zookeeper:zookeeper /opt/zookeeper /var/lib/zookeeper /datalog  
    
# Define o diretório bin do Zookeeper no PATH
ENV PATH="/opt/zookeeper/bin:${PATH}"

# Exponha a porta do ZooKeeper
EXPOSE 2181

# Define o comando de inicialização
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]


# Define o comando padrão
CMD ["zkServer.sh", "start-foreground"]
