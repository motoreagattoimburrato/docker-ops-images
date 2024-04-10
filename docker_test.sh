#!/usr/bin/env bash

TOOL_NAME=$1
if [ -z "$TOOL_NAME" ]; then
    echo "[$(date --utc) - ERROR]: TOOL_NAME argument is not defined or is empty. Aborting..."
    exit 1
fi

container_user="root"
container_name="uss_testami"
container_image="uss_testami:latest"
dockerfile="./tests/Dockerfile.test.${TOOL_NAME}"

#--no-cache
docker build --progress=plain -t $container_image -f $dockerfile .
if [[ $? -ne 0 ]]
then
    echo "[$(date --utc) - ERROR]: docker build failed."
    exit 1 
fi

docker volume create ${container_name}_operator
docker volume create ${container_name}_root
docker volume create ${container_name}_linuxbrew

docker run --rm --name $container_name --user $container_user -it \
    -v ${container_name}_linuxbrew:/home/linuxbrew \
    -v ${container_name}_operator:/home/operator \
    -v ${container_name}_root:/root \
    -v D:\\cottage_github\\docker-ops-images:/workspace \
    $container_image bash
