#!/bin/bash

# Utencils
INSTALL_DIR="/share/Public/tools"
DL_SITE="https://www.python.org"

# Main Ingredients
TARGET_VERSION_TAG="3.7.13"
DL_PATH="/ftp/python/${TARGET_VERSION_TAG}/Python-${TARGET_VERSION_TAG}.tgz"
DL_FILE=$(basename ${DL_PATH})

# Secret sauce
# Python is tasty enough on it's own

# Receipe
DL_URL=${DL_SITE}${DL_PATH}
SANDBOX=$(basename -s .tgz ${DL_FILE})

cd ~

if ! [ -d ${SANDBOX} ]; then
  wget ${DL_URL} -o ${SANDBOX}
  tar -xzvf ${DL_FILE}
fi

# Bake in the oven.....
cd ${SANDBOX}

./configure --prefix=${INSTALL_DIR}
make
make install
