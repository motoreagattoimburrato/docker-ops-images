#!/usr/bin/env bash

export SDKMAN_DIR="$1"
curl -s "https://get.sdkman.io?rcupdate=false" | bash

# Check if binary exists
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

if [[ $? -eq 1 ]]
then
    echo "sdk not present - check installation steps"
    exit -1 
fi
