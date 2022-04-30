#!/bin/bash

# Main Ingredients
TARGET_VERSION_TAG="pcre2-10.40"

APP=pcre2

GIT_URL="https://github.com/PCRE2Project/pcre2"


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
    --enable-pcre2-16 --enable-pcre2-32 \
    --enable-jit \
    CFLAGS='-std=c99'
make


# Enjoy
make install

 
      
