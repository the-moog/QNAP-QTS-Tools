#!/bin/bash

GCC_VERSION="9.4.0"

cd ~

cd gcc_build

if ! [ -d gcc ]; then
  exit -1
fi

cd gcc
git checkout releases/gcc-${GCC_VERSION}
cd ..

mkdir sandbox
cd sandbox

../gcc/configure \
    --prefix=/share/Public/toolchain/ \
    --host=x86_64-pc-linux-gnu \
    --disable-werror \
    --disable-multilib \
#    --enable-languages=c,c++,fortran \

make BOOT_CFLAGS='-O' bootstrap-lean -j4
make -j4
make install
