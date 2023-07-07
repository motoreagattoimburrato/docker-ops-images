#!/usr/bin/env bash

KUBECTL_VERSION="$1"
#curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg 
#echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list 
#apt-get update && apt-get install -y kubectl

cd /tmp
curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

brew install derailed/k9s/k9s
brew install krew
kubectl krew update
kubectl krew install ktop kubesec-scan resource-capacity
cd -