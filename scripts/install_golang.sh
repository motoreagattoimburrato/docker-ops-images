#!/usr/bin/env bash

GO_URL=$1
GO_HOME=/usr/local/go

mkdir -p $GO_HOME
wget -q -O /opt/go-linux-amd64.tar.gz $GO_URL
tar -C /usr/local -xzf /opt/go-linux-amd64.tar.gz
rm -rf /opt/go-linux-amd64.tar.gz
