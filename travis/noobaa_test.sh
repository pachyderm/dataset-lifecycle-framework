#!/usr/bin/env bash

./examples/noobaa/noobaa status

./examples/noobaa/create_dataset_desc.sh

kubectl create -f ./examples/noobaa/dataset-noobaa.yaml
kubectl create -f ./examples/templates/example-pod.yaml

kubectl get datasets

echo "waiting for pods to be ready"
kubectl wait --for=condition=ready pod/nginx --timeout=90s
kubectl describe pod/nginx
kubectl get pvc
contents=$(kubectl exec nginx -- ls /mount/dataset1)
if [[ $contents != *"file1.txt"* ]]; then
  echo "file1.txt NOT FOUND!"
  exit 1
fi
if [[ $contents != *"file2.txt"* ]]; then
  echo "file2.txt NOT FOUND!"
  exit 1
fi
echo $contents

echo "done"
