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
POD=$(kubectl get pod -l app.kubernetes.io/name=kafka -o jsonpath='{.items[0].metadata.name}')
```

```bash
kubectl exec -it "${POD}" -- /bin/bash
```

```bash
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic "test-topic-1" 
```

**Terminal 2:**

```bash
POD=$(kubectl get pod -l app.kubernetes.io/name=kafka -o jsonpath='{.items[0].metadata.name}')
```

```bash
kubectl exec -it "${POD}" -- /bin/bash
```

```bash
echo 'A-ha!' | /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server kafka:9092 --topic "test-topic-1"
```


## Use from outside the cluster

Note: port 9095

**Terminal 0:**

```bash
POD=$(kubectl get pod -l app.kubernetes.io/name=kafka -o jsonpath='{.items[0].metadata.name}')
```

```bash
kubectl port-forward "${POD}" 9095:9095
```

**Terminal 1:**

```bash
POD=$(kubectl get pod -l app.kubernetes.io/name=kafka -o jsonpath='{.items[0].metadata.name}')
```

```bash
kcat -b localhost:9095 -t "test-topic-1" -C -o end
```

**Terminal 2:**

```bash
POD=$(kubectl get pod -l app.kubernetes.io/name=kafka -o jsonpath='{.items[0].metadata.name}')
```

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
