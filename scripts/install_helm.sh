#!/usr/bin/env bash

# puzza
#curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
#apt-get update && apt-get install -y helm

HELM_URL=$1
HELM_SHA256=$2
HELM_HOME=/usr/local/bin
HELM_TMP_PATH=/opt/helm-linux-amd64.tar.gz

wget -q -O $HELM_TMP_PATH $HELM_URL

CHECKSUM=$(sha256sum "${HELM_TMP_PATH}" | awk '{print $1}')

if [[ "${CHECKSUM}" == "${HELM_SHA256}" ]]; then
    tar -C /tmp -xzf $HELM_TMP_PATH
    mv /tmp/linux-amd64/helm ${HELM_HOME}/helm
    chmod a+x ${HELM_HOME}/helm
else
    echo "Invalid checksum for $HELM_URL"
    echo "Calculated: $CHECKSUM"
    echo "Declared: $HELM_SHA256"
    echo "ABORTING"
    exit 1
fi

# Check if binary exists
${HELM_HOME}/helm version

if [[ $? -eq 1 ]]
then
    echo "helm not present - check installation steps"
    exit -1 
fi

rm -rf $HELM_TMP_PATH

