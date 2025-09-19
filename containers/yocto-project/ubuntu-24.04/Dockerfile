FROM ubuntu:24.04

ENV TZ=US/Detroit
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y sudo gawk wget git diffstat \
    unzip texinfo gcc build-essential chrpath socat cpio \
    python3 python3-pip python3-pexpect xz-utils debianutils \
    iputils-ping python3-git python3-jinja2 python3-subunit \
    zstd liblz4-tool file locales libacl1 vim tmux curl \
    bash-completion net-tools iproute2 iptables && \
    rm -rf /var/lib/apt/lists/*

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

USER $USER_NAME

WORKDIR /home/$USER_NAME
