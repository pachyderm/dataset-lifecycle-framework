#!/usr/bin/env bash

export PULL_COMPONENTS="false"

make minikube-install

echo "wait for nooba loading job to finish"
kubectl wait --for=condition=complete jobs --all --timeout=90s
kubectl delete job/example-noobaa-data

echo "waiting for pods to be ready"
kubectl wait --for=condition=ready pods --all --timeout=90s

kubectl get pods

