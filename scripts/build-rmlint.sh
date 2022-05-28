#!/bin/bash

# Utencils
INSTALL_DIR="/share/Public/tools"
GIT="https://github.com"

# Main Ingredients
TARGET_VERSION_TAG="v2.10.1"
GIT_PATH="/sahib/rmlint"

# Secret sauce
yum -y install python3 gettext json-glib-devel
yum -y install glib2-devel libblkid-devel elfutils-libelf-devel
python3 -m pip install scons
python3 -m pip install sphinx

# Receipe
APP=$(basename ${GIT_PATH})
GIT_URL=${GIT}${GIT_PATH}
SANDBOX=${APP}-build

cd ~

if ! [ -d ${SANDBOX} ]; then
  git clone ${GIT_URL} ${SANDBOX}
fi

cd ${SANDBOX}

git checkout ${TARGET_VERSION_TAG}

# Bake in the oven.....
scons config
scons
scons  --prefix=${INSTALL_DIR} install
