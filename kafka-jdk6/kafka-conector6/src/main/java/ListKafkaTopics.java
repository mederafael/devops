import kafka.utils.ZKStringSerializer;
import kafka.utils.ZkUtils;
import org.I0Itec.zkclient.ZkClient;
import org.I0Itec.zkclient.ZkConnection;
import org.apache.zookeeper.ZooDefs;
import kafka.javaapi.producer.Producer;
import kafka.producer.KeyedMessage;
import kafka.producer.ProducerConfig;

import java.util.Properties;
import java.util.List;

public class ListKafkaTopics {
    public static void main(String[] args) {
        // Configurações do produtor
        Properties props = new Properties();
        props.put("metadata.broker.list", "localhost:9092");
        props.put("serializer.class", "kafka.serializer.StringEncoder");
        props.put("request.required.acks", "1");

        // Criação do produtor Kafka
        ProducerConfig config = new ProducerConfig(props);
        Producer<String, String> producer = new Producer<String, String>(config);

        // Mensagem de teste
        String topic = "test-topic";
        String key = "test-key";
        String value = "test-message";

        try {
            // Envio da mensagem
            KeyedMessage<String, String> data = new KeyedMessage<String, String>(topic, key, value);
            producer.send(data);
            System.out.println("Mensagem enviada com sucesso para o tópico " + topic);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Fechamento do produtor
            producer.close();
        }
    }
}