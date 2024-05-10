#!/usr/bin/env bash

GIT_URL=$1
GIT_TAG=$2

git clone $GIT_URL --branch $GIT_TAG --single-branch
cd kics
make build
mv ./bin/kics /usr/local/bin/
cd -

# Check if binary exists
/usr/local/bin/kics version 

if [[ $? -eq 1 ]]
then
    echo "kics not present - check installation steps"
    exit -1 
fi