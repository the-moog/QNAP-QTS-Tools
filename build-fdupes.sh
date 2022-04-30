#!/bin/bash

# Main Ingredients
TARGET_VERSION_TAG="v2.1.2"

APP=fdupes

GIT_URL="https://github.com/adrianlopezroche/fdupes"


# Secret sauce
yum install -y ncurses-devel pcre2-devel

# Receipe
SANDBOX=${APP}-build

cd ~

if ! [ -d ${SANDBOX} ]; then
  git clone ${GIT_URL} ${SANDBOX}
fi

cd ${SANDBOX}

git checkout ${TARGET_VERSION_TAG}


# Bake in the oven.....
autoreconf --install
./configure --prefix=/share/Public/tools --disable-shared
make


# Enjoy
make install

 
      
