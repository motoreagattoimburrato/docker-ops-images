#!/usr/bin/env bash

curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec

# Check if binary exists
/bin/inspec --version

if [[ $? -eq 1 ]]
then
    echo "inspec not present - check installation steps"
    exit -1 
fi