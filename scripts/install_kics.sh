#!/usr/bin/env bash

GIT_URL=$1
GIT_TAG=$2

git clone $GIT_URL --branch $GIT_TAG --single-branch
cd kics
make build
cd -
