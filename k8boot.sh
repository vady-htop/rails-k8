#!/bin/zsh

minikube start
helm repo add stable https //kubernetes-charts.storage.googleapis.com/
cd helm/Jenkins
helm upgrade --install jenkins  stable/jenkins -f values.yaml
