import kafka.consumer.Consumer;
import kafka.consumer.ConsumerConfig;
import kafka.consumer.KafkaStream;
import kafka.javaapi.consumer.ConsumerConnector;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class BasaKafkaConsumer {
    private final ConsumerConnector consumer;
    private final String topic;

    public BasaKafkaConsumer(String zookeeper, String groupId, String topic) {
        consumer = Consumer.createJavaConsumerConnector(createConsumerConfig(zookeeper, groupId));
        this.topic = topic;
    }

    private static ConsumerConfig createConsumerConfig(String zookeeper, String groupId) {
        Properties props = new Properties();
        props.put("zookeeper.connect", zookeeper);
        props.put("group.id", groupId);
        props.put("zookeeper.session.timeout.ms", "400");
        props.put("zookeeper.sync.time.ms", "200");
        props.put("auto.commit.interval.ms", "1000");

        return new ConsumerConfig(props);
    }

    public void consume() {
        Map<String, Integer> topicCountMap = new HashMap();
        topicCountMap.put(topic, 1);
        Map<String, List<KafkaStream<byte[], byte[]>>> consumerMap = consumer.createMessageStreams(topicCountMap);
        KafkaStream<byte[], byte[]> stream = consumerMap.get(topic).get(0);

        for (kafka.consumer.ConsumerIterator<byte[], byte[]> it = stream.iterator(); it.hasNext(); ) {
            System.out.println(new String(it.next().message()));
        }
    }

    public static void main(String[] args) {
        String zookeeper = "zookeeper:2181";
        String groupId = "test-consumer-group";
        String topic = "topico-rafael-4";
        BasaKafkaConsumer simpleConsumer = new BasaKafkaConsumer(zookeeper, groupId, topic);
        simpleConsumer.consume();
    }
}
