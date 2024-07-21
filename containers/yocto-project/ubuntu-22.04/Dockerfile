FROM ubuntu:22.04

ENV TZ=US/Detroit
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y gawk wget git diffstat \
    unzip texinfo gcc build-essential chrpath socat cpio \
    python3 python3-pip python3-pexpect xz-utils debianutils \
    iputils-ping python3-git python3-jinja2 libegl1-mesa \
    libsdl1.2-dev python3-subunit mesa-common-dev zstd \
    liblz4-tool file locales libacl1 vim sudo screen \
    bash-completion net-tools && \
    rm -rf /var/lib/apt/lists/*

RUN rm /bin/sh && ln -s bash /bin/sh

RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY startup.sh /startup.sh
COPY enter-env.sh /enter-env.sh

ENTRYPOINT source /startup.sh
