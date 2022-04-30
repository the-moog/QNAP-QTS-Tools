#!/bin/bash

BASE_DIR=$(dirname $0)
BUILD_SCRIPT_NAME="build-git.sh"
BUILD_SCRIPT="${BASE_DIR}/${BUILD_SCRIPT_NAME}"
CONTAINER="moog/c7-systemd"
#CONTAINER="sdhuang32/c7-systemd"

if [ ! -d /share/Public/toolchain ]; then
    mkdir /share/Public/toolchain
fi

if [ -z "$(system-docker ps | grep 'builder')" ]; then
    system-docker run --name builder --privileged -v /share/Public/toolchain:/share/Public/toolchain -d ${CONTAINER}
fi

system-docker cp ${BUILD_SCRIPT} builder:/root/${BUILD_SCRIPT_NAME}
system-docker exec -t builder bash /root/${BUILD_SCRIPT_NAME}

if [ -z "$(cat /etc/profile | grep 'toolchain')" ]; then
    echo "PATH=/share/Public/toolchain/bin:\$PATH" >> /etc/profile
fi

system-docker stop builder; system-docker rm builder
