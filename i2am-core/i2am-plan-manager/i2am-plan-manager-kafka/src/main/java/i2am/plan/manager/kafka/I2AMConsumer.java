package i2am.plan.manager.kafka;

import java.io.*;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Arrays;
import java.util.Properties;
import java.util.Queue;
import java.util.UUID;
import java.util.concurrent.LinkedBlockingQueue;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

public class I2AMConsumer {

    private KafkaConsumer<String, String> consumer;
    private Socket socket = null;

    public I2AMConsumer(String id, String dstName) {
        String brokers = "114.70.235.43:19092,114.70.235.43:19093,114.70.235.43:19094,"
                + "114.70.235.43:19095,114.70.235.43:19096,114.70.235.43:19097,"
                + "114.70.235.43:19098,114.70.235.43:19099,114.70.235.43:19100";
        String topic = getInputTopic(id, dstName);
        String groupId = UUID.randomUUID().toString();

        Properties props = new Properties();
        props.put("bootstrap.servers", brokers);
        props.put("group.id", groupId);
        props.put("enable.auto.commit", "true");
        props.put("auto.commit.interval.ms", "1000");
        props.put("session.timeout.ms", "30000");
        props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");

        this.consumer = new KafkaConsumer<String, String>(props);
        this.consumer.subscribe(Arrays.asList(topic));
    }


    private DbAdapter getDbInstance() {
        return DbAdapter.getInstance();
    }

    public void close() {
        consumer.close();
    }

    public void receive(Queue<String> qMessages) throws IOException {

        this.socket = new Socket();
        System.out.println("[연결 요청]");
        this.socket.connect(new InetSocketAddress("MN", 5006));
        System.out.println("[연결 성공]");
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
        Thread t = new Thread(new Runnable() {
            @Override
            public void run() {
                while (true) {
                    ConsumerRecords<String, String> records = consumer.poll(100);
                    long rTime = System.currentTimeMillis();
                    for (ConsumerRecord<String, String> record : records) {
                        if (record.value() != null) {
                            // message split by comma
                            String[] msg = record.value().split(",");
                            //original message
                            String org = "";
                            for (int i = 0; i < msg.length - 4; i++) {
                                org += "," + msg[i];
                            }
                            org = org.replaceFirst(",", "");
                            qMessages.offer(org);

//                        String message = msg[msg.length - 3] + "," + rTime + "," + msg[msg.length - 2]+"," + msg[msg.length - 1];
                            //message = sendTime, receiveTime, srcName, userId, count
                            String message = msg[msg.length - 4] + "," + rTime + "," + msg[msg.length - 3] + "," + msg[msg.length - 2] + "," + msg[msg.length - 1];
//							System.out.println("[Message Sending] "+message);
                            try {
                                bw.write(message);
                                bw.newLine();
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            }
        });
        t.start();

    }

    public String getInputTopic(String id, String dstName) {
        return DbAdapter.getInstance().getOutputTopic(id, dstName);
    }
}
