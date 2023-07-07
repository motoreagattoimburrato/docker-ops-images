#!/usr/bin/env bash

DC_URL=$1
DC_ASC=$2
DC_PUBKEY=$3
DC_HOME=/usr/local/dependency-check
DC_TMP_PATH=/opt/dependency-check.zip

wget -q -O $DC_TMP_PATH $DC_URL
wget -q -O /tmp/dc.zip.asc $DC_ASC

gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $DC_PUBKEY
gpg --verify /tmp/dc.zip.asc $DC_TMP_PATH

unzip $DC_TMP_PATH
mv $DC_TMP_PATH $DC_HOME

rm -rf $DC_TMP_PATH 
