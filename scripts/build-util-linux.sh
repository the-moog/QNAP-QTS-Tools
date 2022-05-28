#!/bin/bash

# Utencils
INSTALL_DIR="/share/Public/tools"
GIT="https://github.com"

# Main Ingredients
TARGET_VERSION_TAG="v2.38"
EXZT=".git"
GIT_PATH="util-linux/util-linux${EXT}"

# Secret sauce
yum install -y bison ncurses-devel python3


# Receipe
APP=$(basename ${GIT_PATH} ${EXT})
GIT_URL=${GIT}/${GIT_PATH}
SANDBOX=${APP}-build

cd ~

if ! [ -d ${SANDBOX} ]; then
  git clone ${GIT_URL} ${SANDBOX}
fi

cd ${SANDBOX}

git checkout ${TARGET_VERSION_TAG}

./autogen.sh
./configure --with-python=3 --prefix=/share/Public/tools

# Bake in the oven.....
make

make install

