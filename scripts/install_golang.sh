#!/usr/bin/env bash

GO_URL=$1
GO_SHA256=$2
GO_HOME=/usr/local/go
GO_TMP_PATH=/opt/go-linux-amd64.tar.gz

wget -q -O $GO_TMP_PATH $GO_URL

CHECKSUM=$(sha256sum "${GO_TMP_PATH}" | awk '{print $1}')

if [[ "${CHECKSUM}" == "${GO_SHA256}" ]]; then
    mkdir -p $GO_HOME
    tar -C /usr/local -xzf $GO_TMP_PATH
    #chmod a+x /usr/local/go/?
else
    echo "Invalid checksum for $GO_URL"
    echo "Calculated: $CHECKSUM"
    echo "Declared: $GO_SHA256"
    echo "ABORTING"
    exit 1
fi

rm -rf $GO_TMP_PATH
