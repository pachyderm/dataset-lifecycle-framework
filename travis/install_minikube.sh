#!/usr/bin/env bash

sudo apt-get install -y socat

curl -Lo minikube https://storage.googleapis.com/minikube/releases/$MINIKUBE_VERSION/minikube-linux-amd64 \
  && chmod +x minikube

sudo mv ./minikube /usr/local/bin/minikube

sudo minikube start --vm-driver=none
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

sudo chown -R $USER $HOME/.kube $HOME/.minikube

while [[ $(kubectl get nodes -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]];
do echo "waiting for nodes to be ready" && sleep 5; done

kubectl get nodes
