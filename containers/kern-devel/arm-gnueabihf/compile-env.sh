#!/bin/bash

export ARCH="arm"
export CROSS_COMPILE="arm-linux-gnueabihf-"
export CC="${CROSS_COMPILE}gcc --sysroot=/usr/arm-linux-gnueabihf"
export CXX="${CROSS_COMPILE}g++ --sysroot=/usr/arm-linux-gnueabihf"
export CPP="${CROSS_COMPILE}g++ --sysroot=/usr/arm-linux-gnueabihf"
export AR="${CROSS_COMPILE}ar"
export AS="${CROSS_COMPILE}as"
export RANLIB="${CROSS_COMPILE}ranlib"
export LD="${CROSS_COMPILE}ld --sysroot=/usr/arm-linux-gnueabihf"
export STRIP="${CROSS_COMPILE}strip"
