#!/usr/bin/env bash

DC_URL=$1
DC_HOME=$2

wget -q -O /opt/dependency-check.zip ${DC_URL}
unzip /opt/dependency-check.zip
mv /opt/dependency-check ${DC_HOME}
rm -rf /opt/dependency-check.zip
