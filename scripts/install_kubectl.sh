#!/usr/bin/env bash

curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg 
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list 
apt-get update && apt-get install -y kubectl

brew install derailed/k9s/k9s
brew install krew
kubectl krew update
kubectl krew install ktop kubesec-scan resource-capacity