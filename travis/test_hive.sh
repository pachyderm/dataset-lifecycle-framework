#!/usr/bin/env bash

cd ./examples/noobaa

export NOOBAA_HOME=`pwd`
cd ../hive/k8s
make minikube-install
./test-hive.sh
cd ../sampleapp
./run_sample.sh

kubectl get pvc