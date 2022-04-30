#!/bin/bash


TARGET_VERSION="4.3"

# Yet another tool missing is make.
# Stock Centos 7 Can't do the latest make (4.3) as that needs a newer autoconf than exists
# in Centos 7 - We'd either have to build it from scratch or upgrade to Centos 8
# make 4.2 is way too old to be useful for building, e.g. gcc
# 3rd party automake is required.  The following lines are added to the Dockerfile
# RUN cd /etc/yum.repos.d && wget https://download.opensuse.org/repositories/home:jayvdb:autotools/CentOS_7/home:jayvdb:autotools.repo
# RUN cd /etc/yum.repos.d yum install -y automake


cd ~

if ! [ -d make_build ]; then
  git clone https://github.com/mirror/make make_build
fi

cd make_build

git checkout ${TARGET_VERSION}

./bootstrap
./configure
make check MAKE_MAINTAINER_MODE= MAKE_CFLAGS=
make install

        
      
