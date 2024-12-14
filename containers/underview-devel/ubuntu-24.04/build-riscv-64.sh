#!/bin/bash

# Building RISCV GNU toolchain for CVA6 (64-bit)
# https://hackmd.io/@yrr-itri/Hk3uMlzI3

RISCV_TOOLCHAIN="/opt/riscv-gnu-toolchain"
RISCV_TOOLCHAIN_BUILD="/opt/riscv-gnu-toolchain-build"

git clone https://github.com/riscv/riscv-gnu-toolchain "${RISCV_TOOLCHAIN_BUILD}"
cd "${RISCV_TOOLCHAIN_BUILD}"
git submodule update --init --recursive

mkdir -p build "${RISCV_TOOLCHAIN}"

cd build
../configure --prefix="${RISCV_TOOLCHAIN}" \
             --with-arch=rv64gc \
             --with-abi=lp64d \
             --enable-linux
make -j$(nproc) linux

rm -rf "${RISCV_TOOLCHAIN_BUILD}"
