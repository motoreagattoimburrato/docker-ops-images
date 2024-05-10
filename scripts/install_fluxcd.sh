#!/usr/bin/env bash

curl -s https://fluxcd.io/install.sh | bash
. <(flux completion bash)

# Check if binary exists
/usr/local/bin/flux --version

if [[ $? -eq 1 ]]
then
    echo "flux not present - check installation steps"
    exit -1 
fi