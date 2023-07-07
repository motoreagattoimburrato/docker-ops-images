#!/usr/bin/env bash

SS_URL=$1
SS_HOME=$2
SS_ASC=$3
SS_PUBKEY=$4

wget -q -O /opt/sonar-scanner.zip $SS_URL
wget -q -O /opt/sonar-scanner.zip.asc $SS_ASC
wget -q -O /opt/sonarsource-public.key $SS_PUBKEY
gpg --import /opt/sonarsource-public.key
gpg --verify /opt/sonar-scanner.zip.asc /opt/sonar-scanner.zip
unzip sonar-scanner.zip
rm -rf /opt/sonar-scanner.zip /opt/sonar-scanner.zip.asc
mv sonar-scanner-*-linux $SS_HOME
