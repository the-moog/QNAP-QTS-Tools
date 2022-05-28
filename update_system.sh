#!/bin/bash

if [ "$(whoami)" != "admin" ]; then
  echo -e "YOU MUST RUN THIS SCRIPT SUDO"
  exit -1
fi

BASE_DIR=$(dirname $0)
CONTAINER="moog/builder"
DEST="/share/Public"

TOOLS=${DEST}/tools
LIBS=${TOOLS}/lib
BINS=${TOOLS}/bin


if [ ! -d ${TOOLS} ]; then
  echo -e "tools folder missing"
  exit -3
fi

if [ ! -d ${LIBS} ]; then
  echo -e "lib folder missing"
  exit -4
fi

if [ ! -d ${BINS} ]; then
  echo -e "bin folder missing"
  exit -5
fi


if [ -z "$(cat /etc/profile | grep 'Public/tools')" ]; then
  echo PATH=${DEST}/tools/bin:\$PATH >> /etc/profile
fi

if [ -z "$(cat /etc/ld.so.conf | grep 'Public/tools')" ]; then
  echo ${DEST}/tools/lib >> /etc/ld.so.conf
fi

ldconfig -v -n ${DEST}/tools/lib && ldconfig

echo -e "\n$0 DONE\n\n"
