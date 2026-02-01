# Helm-Kafka

A single node KRaft Kafka helm chart based on
[apache/kafka](https://hub.docker.com/r/apache/kafka/).

Intended to be used for development and testing purposes only.


## Start

```bash
minikube start
```

```bash
helm install kafka ./chart
```


## Test

```bash
helm test kafka
```


## Use From inside the cluster

Note: port 9092

**Terminal 1:**

```bash
kubectl exec -it kafka-0 -- /bin/bash
```

```bash
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic "test-topic-1" 
```

**Terminal 2:**

```bash
kubectl exec -it kafka-0 -- /bin/bash
```

```bash
echo 'A-ha!' | /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server kafka:9092 --topic "test-topic-1"
```


## Use from outside the cluster

Note: port 9095

**Terminal 1:**

```bash
kubectl port-forward kafka-0 9095:9095
```

**Terminal 2:**

```bash
kcat -b localhost:9095 -t "test-topic-1" -C -o end
```

**Terminal 3:**

```bash
echo 'A-ha!' | kcat -b localhost:9095 -t "test-topic-1" -P
```

## Stop

```bash
helm uninstall kafka
```

```bash
minikube stop
```

## With `gradle`/`kotlin`/`JUnit`

```shell
./gradlew :helmInstallKafkaToDefault
```

```shell
./gradlew test # TODO
```

```shell
./gradlew :helmUninstallKafkaFromDefault
```
