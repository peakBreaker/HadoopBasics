#!/usr/bin/env bash
export CLUSTER_NAME=tmpcluster-hadoop-wordcount
export GCP_REGION=europe-north1
export GCP_ZONE=europe-north1-a
export IN_BUCKET=demobucket-hadoop-wordcount-in
export OUT_BUCKET=demobucket-hadoop-wordcount-out

echo "Running in GCP project : ${GCP_PROJECT?Set GCP_PROJECT Before running! \$ export GCP_PROJECT=<google project to run in>}"
if [[ $1 = 'setup' ]]; then

  # Bucket
  gsutil mb -l $GCP_REGION -p $GCP_PROJECT gs://$IN_BUCKET
  gsutil mb -l $GCP_REGION -p $GCP_PROJECT gs://$OUT_BUCKET
  gsutil -m cp gs://pub/shakespeare/*.txt gs://$IN_BUCKET/input-shakespeare

  # Set up dataproc cluster
  gcloud dataproc clusters create $CLUSTER_NAME --region $GCP_REGION --subnet default --zone $GCP_ZONE --single-node --master-machine-type n1-standard-1 --master-boot-disk-size 15 --image-version 1.3-deb9 --project $GCP_PROJECT

elif [[ $1 = 'run' ]]; then

  # Compile and run on dataproc
  mvn clean install && gcloud dataproc jobs submit hadoop --region europe-north1 --cluster $CLUSTER_NAME --class com.test.wordcount.WordCount --jars target/wordcount-1.0-SNAPSHOT.jar -- gs://$IN_BUCKET/input-shakespeare gs://$OUT_BUCKET/output-shakespeare-wc/

elif [[ $1 = 'clean' ]]; then
    read -p "Deleting all cloud resources for this repo.  Are you sure? [Y/n]" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi

    # remove buckets and cluster
    gsutil rb gs://$IN_BUCKET
    gsutil rb gs://$OUT_BUCKET
    gcloud dataproc clusters delete $CLUSTER_NAME --quiet --region $GCP_REGION
else
    echo "ERR: Provide either 'run', 'setup' or 'clean' as first arg"
fi

