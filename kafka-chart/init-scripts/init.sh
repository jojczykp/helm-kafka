#!/bin/bash

set -e

echo "----------------------------------------"
echo
echo "Waiting for Kafka to be ready..."
until /opt/kafka/bin/kafka-broker-api-versions.sh --bootstrap-server "${BOOTSTRAP_SERVER}"; do
  echo "Kafka not yet listening. Sleeping 1 second..."
  sleep 1
done

sleep 30

echo "Kafka is ready."

echo
echo "Creating topics..."
/opt/kafka/bin/kafka-topics.sh --bootstrap-server "${BOOTSTRAP_SERVER}" --create --topic test-topic-1 --partitions 1 --replication-factor 1

echo
echo "All topics:"
/opt/kafka/bin/kafka-topics.sh --bootstrap-server "${BOOTSTRAP_SERVER}" --list | sed 's/^/- /'

echo
echo "----------------------------------------"
