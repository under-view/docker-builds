FROM ubuntu:22.04

ENV TZ=US/Detroit
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y build-essential cmake clang automake autoconf autopoint autotools-dev
RUN apt install -y libtool flex m4 yasm dos2unix software-properties-common
RUN apt install -y pkg-config python3 python3-pip ninja-build curl wget git gperf
RUN apt install -y texinfo libmount-dev locales gettext unzip help2man device-tree-compiler
RUN apt install -y libmpc-dev libmpfr-dev libgmp-dev gawk patchutils bc zlib1g-dev libexpat-dev
RUN rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install meson==1.3.1 Mako jinja2

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt update -y
RUN apt install -y gcc-13 gcc-12 gcc-11 g++-13 g++-12 g++-11
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 --slave /usr/bin/g++ g++ /usr/bin/g++-13 --slave /usr/bin/gcov gcov /usr/bin/gcov-13
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 90 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 80 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11

COPY build-riscv-64.sh /build-riscv-64.sh
RUN bash /build-riscv-64.sh
RUN rm -f /build-riscv-64.sh

COPY build-icarus-verilog.sh /build-icarus-verilog.sh
RUN bash /build-icarus-verilog.sh
RUN rm -f /build-icarus-verilog.sh

RUN rm /bin/sh && ln -s bash /bin/sh

RUN locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ARG USER_NAME=developer
ARG HOST_UID=1001
ARG HOST_GID=1001
RUN groupadd -g $HOST_GID $USER_NAME && \
    useradd -g $HOST_GID -m -s /bin/bash -u $HOST_UID $USER_NAME

COPY env-spice.sh /home/$USER_NAME/env-spice.sh

USER $USER_NAME

WORKDIR /home/$USER_NAME
