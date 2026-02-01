#!/bin/bash

set -e

echo "----------------------------------------"
echo
echo "Waiting for Kafka to be ready..."
until /opt/kafka/bin/kafka-broker-api-versions.sh --bootstrap-server localhost:9095 2>/dev/null
do
  echo "Kafka not yet listening. Sleeping 1 second..."
  sleep 1
done

echo "Kafka is ready."

echo
ORIGINAL_IFS=${IFS}
IFS=','
for KAFKA_TOPIC in ${KAFKA_TOPICS}
do
  echo "Creating ${KAFKA_TOPIC} topic..."
  /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9095 --create --if-not-exists --topic "${KAFKA_TOPIC}" --partitions 1 --replication-factor 1
done
IFS=${ORIGINAL_IFS}

echo
echo "All topics:"
/opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9095 --list | sed 's/^/- /'

echo
echo "----------------------------------------"
