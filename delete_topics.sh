#!/bin/bash
topics=(
  
)

for i in "${topics[@]}"
do
  /usr/bin/kafka-topics --zookeeper localhost:2181 --delete --topic $i
done
