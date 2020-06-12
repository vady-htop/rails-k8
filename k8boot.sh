#!/bin/zsh

minikube start
minikube addons enable ingress
helm repo add stable https://kubernetes-charts.storage.googleapis.com && helm repo update
cd helm/Jenkins
helm upgrade --install jenkins  stable/jenkins -f values.yaml
MINIKUBE_IP=$(minikube ip)
#sudo -- sh -c "echo $MINIKUBE_IP  "jenkins.dev.com" >> /etc/hosts"
