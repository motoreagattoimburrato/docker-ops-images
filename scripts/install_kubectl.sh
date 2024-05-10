#!/usr/bin/env bash

KUBECTL_URL="$1"
#curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg 
#echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list 
#apt-get update && apt-get install -y kubectl

cd /tmp
curl -LO "${KUBECTL_URL}/kubectl"
curl -LO "${KUBECTL_URL}/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# Check if binary exists
/usr/local/bin/kubectl version --client

if [[ $? -eq 1 ]]
then
    echo "kubectl not present - check installation steps"
    exit -1 
fi

brew install derailed/k9s/k9s
brew install krew
# Do optional
#kubectl krew update
#kubectl krew install ktop kubesec-scan resource-capacity
cd -