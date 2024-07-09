import java.util.Properties;
import kafka.producer.KeyedMessage;
import kafka.producer.ProducerConfig;
import kafka.javaapi.producer.Producer;

public class BasaKafkaProducer {
    private Producer producer;
    private String topic;

    public BasaKafkaProducer(String brokerList, String topic) {
        Properties props = new Properties();
        props.put("metadata.broker.list", brokerList);
        props.put("serializer.class", "kafka.serializer.StringEncoder");
        

        props.put("request.required.acks", "1");
        props.put("retry.backoff.ms", "500");
        props.put("message.send.max.retries", "5");
        ProducerConfig config = new ProducerConfig(props);
        producer = new Producer(config);
        this.topic = topic;
    }

    public void produce(String message) {
        KeyedMessage data = new KeyedMessage(topic, message);
        producer.send(data);
    }

    public void close() {
        producer.close();
    }

    public static void main(String[] args) {
        try {
            String brokerList = "localhost:9092";
            String topic = "topico-rafael-3";
            BasaKafkaProducer producer = new BasaKafkaProducer(brokerList, topic);
    
            for (int i = 0; i < 10; i++) {
                String message = "Message " + i;
                producer.produce(message);
                System.out.println("Sent: " + message);
            }
    
            producer.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        
    }

    
}
