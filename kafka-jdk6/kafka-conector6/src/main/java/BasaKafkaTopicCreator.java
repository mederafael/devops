import kafka.admin.AdminUtils;
import kafka.utils.ZKStringSerializer$;
import org.I0Itec.zkclient.ZkClient;

import java.util.Properties;

public class BasaKafkaTopicCreator {
    private static final String ZK_CONNECT = "zookeeper:2181";
    private static final int SESSION_TIMEOUT = 10000;
    private static final int CONNECTION_TIMEOUT = 10000;

    public static void createTopic(String topic, int partitions, int replication) {
        ZkClient zkClient = new ZkClient(ZK_CONNECT, SESSION_TIMEOUT, CONNECTION_TIMEOUT, ZKStringSerializer$.MODULE$);
        AdminUtils.createTopic(zkClient, topic, partitions, replication, new Properties());
        zkClient.close();
    }

    public static void main(String[] args) {
        createTopic("topico-rafael-5", 1, 1);
    }
}
