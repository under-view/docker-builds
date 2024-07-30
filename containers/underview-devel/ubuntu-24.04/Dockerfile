FROM ubuntu:24.04

ENV TZ=US/Detroit
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y build-essential cmake clang automake autoconf autopoint libtool flex bison m4 yasm dos2unix software-properties-common
RUN apt install -y pkg-config python3-pip ninja-build curl wget git gperf texinfo libmount-dev locales gettext unzip
RUN python3 -m pip install meson==1.3.1 Mako jinja2 --break-system-packages

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt update -y
RUN apt install -y gcc-13 gcc-12 gcc-11 g++-13 g++-12 g++-11
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 --slave /usr/bin/g++ g++ /usr/bin/g++-13 --slave /usr/bin/gcov gcov /usr/bin/gcov-13
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 90 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 80 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11

RUN rm /bin/sh && ln -s bash /bin/sh

RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY startup.sh /startup.sh
COPY env-spice.sh /env-spice.sh

ENTRYPOINT source /startup.sh
