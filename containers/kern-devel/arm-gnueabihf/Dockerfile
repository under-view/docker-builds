FROM ubuntu:24.04

ENV TZ=US/Detroit
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y build-essential cmake clang automake autoconf autopoint autotools-dev
RUN apt install -y libtool bison flex m4 bc nasm dos2unix software-properties-common
RUN apt install -y pkg-config python3 python3-pip ninja-build curl wget git vim gperf
RUN apt install -y texinfo libmount-dev locales gettext unzip lzop help2man sudo libssl-dev
RUN apt install -y libmpc-dev libmpfr-dev libgmp-dev gawk patchutils zlib1g-dev libexpat-dev
RUN apt install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf device-tree-compiler
RUN rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install meson==1.3.1 Mako jinja2 --break-system-packages

RUN rm /bin/sh && ln -s bash /bin/sh
RUN userdel -r ubuntu

RUN locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ARG USER_NAME=developer
ARG HOST_UID=1001
ARG HOST_GID=1001
RUN groupadd -g $HOST_GID $USER_NAME && \
    useradd -g $HOST_GID -m -s /bin/bash -u $HOST_UID $USER_NAME

RUN echo "$USER_NAME:$USER_NAME" | chpasswd
RUN adduser $USER_NAME sudo

COPY extra-alias.sh /etc/profile.d
COPY extra-env-vars.sh /etc/profile.d
COPY set-bash-prompt.sh /etc/profile.d
COPY compile-env.sh /etc/profile.d

USER $USER_NAME

WORKDIR /home/$USER_NAME
