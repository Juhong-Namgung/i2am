# delete and create topics
$KAFKA_HOME/bin/kafka-topics.sh --delete --zookeeper MN.eth:22181 --topic input
$KAFKA_HOME/bin/kafka-topics.sh --delete --zookeeper MN.eth:22181 --topic output
$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper MN.eth:22181 --replication-factor 3 --partitions 1 --topic input
$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper MN.eth:22181 --replication-factor 3 --partitions 1 --topic output


# run storm topology
$STORM_HOME/bin/storm jar ./benchmark-storm-and-spark-0.0.1-SNAPSHOT-jar-with-dependencies.jar i2am.benchmark.storm.PerformanceTestTopology MN.eth 22181 input output


# run producer and consumer
java -cp ./benchmark-storm-and-spark-0.0.1-SNAPSHOT-jar-with-dependencies.jar:/tools/storm/lib/* i2am.benchmark.App MN.eth,SN01.eth,SN02.eth,SN03.eth,SN04.eth,SN05.eth,SN06.eth,SN07.eth,SN08.eth MN.eth 9092 22181 input output 100 60