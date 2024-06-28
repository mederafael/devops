#!/bin/bash

# Wait for Kafka to be ready
sleep 20

# Create topics
kafka-topics --create --topic test-topic --bootstrap-server kafka1:9092 --partitions 3 --replication-factor 1
