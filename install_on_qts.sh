#!/bin/bash

if [ -z $1 ]; then
  exit 1
fi

BASE_DIR=$(dirname $0)
BUILD_SCRIPT_NAME="build-$1.sh"
BUILD_SCRIPT="${BASE_DIR}/scripts/${BUILD_SCRIPT_NAME}"
CONTAINER="moog/builder"
DEST="/share/Public"

# Dev tools: gcc etc
if [ ! -d ${DEST}/toolchain ]; then
    mkdir ${DEST}/toolchain
fi

# Non dev tools
if [ ! -d ${DEST}/tools ]; then
    mkdir ${DEST}/tools
fi


if ! [ -f ${BUILD_SCRIPT} ]; then
    echo "The script ${BUILD_SCRIPT} that is required to build $1 is missing"
    exit 1
fi


if [ -z "$(system-docker ps | grep 'builder')" ]; then
    system-docker run --name builder --privileged \
    -v ${DEST}/toolchain:${DEST}/toolchain \
    -v ${DEST}/tools:${DEST}/tools \
    -d ${CONTAINER}
fi

system-docker cp ${BUILD_SCRIPT} builder:/root/${BUILD_SCRIPT_NAME}
system-docker exec -t builder bash /root/${BUILD_SCRIPT_NAME}

if [ -z "$(cat /etc/profile | grep 'Public/tools')" ]; then
    echo -e "\n\nPlease run"
    echo -e "   echo PATH=${DEST}/tools/bin:\$PATH >> /etc/profile"
    echo -e "as root"
fi

if [ -z "$(cat /etc/ld.so.conf | grep 'Public/tools')" ]; then
    echo -e "\n\nPlease run"
    echo -e "   echo ${DEST}/tools/lib >> /etc/ld.so.conf"
    echo -e "as root"
fi

echo -e "\n\nRemember to run"
echo -e "   ldconfig -v -n ${DEST}/tools/lib && ldconfig"
echo -e "as root"

echo -e "\n\n\n"

system-docker stop builder; system-docker rm builder

echo -e "\n$0 DONE\n\n"
