sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm//jdk1.6.0_45/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_45/bin/javac 1


sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-6-openjdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-6-openjdk-amd64/bin/javac 1

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-11-openjdk-amd64/bin/java 2
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-11-openjdk-amd64/bin/javac 2


sh zookeeper-server-start.sh ../config/zookeeper.properties
sh kafka-server-start.sh ../config/server.properties


sh kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
sh kafka-topics.sh --list --zookeeper localhost:2181
sh kafka-topics.sh --describe --zookeeper localhost:2181 --topic test

bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning
