#!/bin/bash

IVERILOG="/opt/iverilog"
IVERILOG_BUILD="${IVERILOG}-build"

git clone https://github.com/steveicarus/iverilog.git "${IVERILOG_BUILD}"

cd "${IVERILOG_BUILD}"
autoreconf -i

mkdir -p build
cd build

../configure --prefix="${IVERILOG}"
make -j$(nproc)
make install

rm -rf "${IVERILOG_BUILD}" 
