#!/usr/bin/env bash

export DOCKER_REGISTRY_COMPONENTS="$DOCKER_REGISTRY"
export DOCKER_REGISTRY_SECRET="regcred"

cd dataset-lifecycle-framework/examples/noobaa

export NOOBAA_HOME=`pwd`
cd ../hive/k8s
make minikube-install
./test-hive.sh
cd ../sampleapp
./run_sample.sh

kubectl get pvc