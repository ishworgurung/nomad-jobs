#!/usr/bin/env bash

set -e

# total 4 nodes
spark-submit \
  --class org.apache.spark.examples.JavaWordCount \
  --master nomad \
  --deploy-mode cluster \
  --conf spark.nomad.dockerImage=rcgenova/spark \
  --conf spark.executor.instances=3 \
  --conf spark.executor.memory=10G \
  --conf spark.driver.cores=1 \
  --conf spark.driver.memory=4G \
  --conf spark.nomad.cluster.monitorUntil=complete \
  --conf spark.eventLog.enabled=true \
  --conf spark.eventLog.dir=hdfs://hdfs.service.consul/spark-events \
  --conf spark.nomad.sparkDistribution=https://github.com/hashicorp/nomad-spark/releases/download/v2.3.1-nomad-0.7.0-20180825/spark-2.3.1-bin-nomad-0.7.0-20180825.tgz \
  https://s3.amazonaws.com/nomad-spark/spark-examples_2.11-2.1.0-SNAPSHOT.jar \
  hdfs://hdfs.service.consul/pb-dump
