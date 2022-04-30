#!/bin/bash

# Main Ingredients
TARGET_VERSION_TAG="v5.9"

APP=ncurses

GIT_URL="https://github.com/mirror/ncurses"


# Secret sauce
yum install -y libtool

# Receipe
SANDBOX=${APP}-build

cd ~

if ! [ -d ${SANDBOX} ]; then
  git clone ${GIT_URL} ${SANDBOX}
fi

cd ${SANDBOX}

git checkout ${TARGET_VERSION_TAG}


# Bake in the oven.....
./autogen.sh
./configure --prefix=/share/Public/tools \
    --with-normal --enable-widec --with-shared \
    --without-debug --enable-overwrite \
    --with-libtool \
    CFLAGS='-std=c99'
make


# Enjoy
make install

 
      
