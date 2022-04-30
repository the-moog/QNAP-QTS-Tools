#!/bin/bash

BASE_DIR=$(dirname $0)
BUILD_SCRIPT_NAME="build-fdupes.sh"
BUILD_SCRIPT="${BASE_DIR}/${BUILD_SCRIPT_NAME}"
CONTAINER="moog/builder"

# Dev tools: gcc etc
if [ ! -d /share/Public/toolchain ]; then
    mkdir /share/Public/toolchain
fi

# Non dev tools
if [ ! -d /share/Public/tools ]; then
    mkdir /share/Public/tools
fi


if [ -z "$(system-docker ps | grep 'builder')" ]; then
    system-docker run --name builder --privileged \
    -v /share/Public/toolchain:/share/Public/toolchain \
    -v /share/Public/tools:/share/Public/tools \
    -d ${CONTAINER}
fi

system-docker cp ${BUILD_SCRIPT} builder:/root/${BUILD_SCRIPT_NAME}
system-docker exec -t builder bash /root/${BUILD_SCRIPT_NAME}

if [ -z "$(cat /etc/profile | grep 'Public/tools')" ]; then
    echo "PATH=/share/Public/tools/bin:\$PATH" >> /etc/profile
fi

system-docker stop builder; system-docker rm builder

