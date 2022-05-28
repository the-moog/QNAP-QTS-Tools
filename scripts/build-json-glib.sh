#!/bin/bash

# Main Ingredients
TARGET_VERSION_TAG="1.4.2"

APP=json-glib

SRC_URL="https://download.gnome.org/sources/json-glib/1.4/${APP}-${TARGET_VERSION_TAG}.tar.xz"


# Secret sauce
yum install -y libtool


# Receipe
SANDBOX=${APP}-build

cd ~

if ! [ -d ${SANDBOX} ]; then
  wget ${SRC_URL} -o ${APP}-${TARGET_VERSION_TAG}.tar.xz
  mkdir ${SANDBOX}
  tar -xjf ${APP}-${TARGET_VERSION_TAG}.tar.xz ${SANDBOX}
fi

cd ${SANDBOX}


# Bake in the oven.....
#./autogen.sh
#./configure --prefix=/share/Public/tools \
#    --enable-pcre2-16 --enable-pcre2-32 \
#    --enable-jit \
#    CFLAGS='-std=c99'
#make


# Enjoy
#make install

 
      
