#!/bin/bash

if [ -z $1 ]; then
  exit 1
fi

BASE_DIR=$(dirname $0)
BUILD_SCRIPT_NAME="build-$1.sh"
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


if ! [ -f ${BUILD_SCRIPT} ]; then
    echo "Expected script ${BUILD_SCRIPT} required to build $1 is missing"
    exit 1
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
    echo "\n\nPlease run"
    echo "   echo PATH=/share/Public/tools/bin:\$PATH >> /etc/profile"
    echo "as root"
fi

if [ -z "$(cat /etc/ld.so.conf | grep 'Public/tools')" ]; then
    echo "\n\nPlease run"
    echo "   echo /share/Public/tools/lib >> /etc/ld.so.conf"
    echo "as root"
fi

echo "Remember to run"
echo "   ldconfig -v -n /share/Public/tools/lib"
echo "as root"

system-docker stop builder; system-docker rm builder

