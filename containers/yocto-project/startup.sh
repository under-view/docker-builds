#!/bin/bash

groupadd -g ${HOST_GID} ${HOST_GNAME} || ret=$?
useradd -g ${HOST_GID} -m -s /bin/bash -u ${HOST_UID} ${HOST_UNAME} > /dev/null 2>&1 || ret=$?
usermod -aG sudo ${HOST_UNAME}

echo "${HOST_UNAME}:${DOCKER_PASSWORD}" | chpasswd
echo "${HOST_UNAME} ALL=(ALL:ALL) ALL" >> /etc/sudoers

chown -v ${HOST_UNAME}:${HOST_GNAME} /home/${HOST_UNAME}
cp -av /enter-env.sh /home/${HOST_UNAME}
chown -v ${HOST_UNAME}:${HOST_GNAME} /home/${HOST_UNAME}/enter-env.sh

su -s /bin/bash - ${HOST_UNAME}
