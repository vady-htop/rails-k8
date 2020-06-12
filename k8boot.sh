#!/bin/zsh

minikube start --memory 4096
minikube addons enable ingress
helm repo add stable https://kubernetes-charts.storage.googleapis.com && helm repo update
cd helm/Jenkins
kubectl create secret generic dockercredentials --from-file credentials.xml
kubectl create serviceaccount helm
kubectl create clusterrolebinding helm \
  --clusterrole cluster-admin \
  --serviceaccount=default:helm
helm upgrade --install jenkins  stable/jenkins -f values.yaml
MINIKUBE_IP=$(minikube ip)
sudo -- sh -c "echo $MINIKUBE_IP  "www.jenkins.dev.com" >> /etc/hosts"
sudo -- sh -c "echo $MINIKUBE_IP  "www.rails-app.com" >> /etc/hosts"
