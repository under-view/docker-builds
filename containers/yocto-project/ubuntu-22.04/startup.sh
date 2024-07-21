#!/bin/bash

groupadd -g "${HOST_GID}" "${HOST_GNAME}" > /dev/null 2>&1 || ret=$?
useradd -g "${HOST_GID}" -m -s /bin/bash -u "${HOST_UID}" "${HOST_UNAME}" > /dev/null 2>&1 || ret=$?
usermod -aG sudo "${HOST_UNAME}" > /dev/null 2>&1

echo "${HOST_UNAME}:${DOCKER_PASSWORD}" | chpasswd > /dev/null 2>&1
echo "${HOST_UNAME} ALL=(ALL:ALL) ALL" >> /etc/sudoers

chown "${HOST_UNAME}":"${HOST_GNAME}" "/home/${HOST_UNAME}" > /dev/null 2>&1
mv /env-spice.sh "/home/${HOST_UNAME}" > /dev/null 2>&1
chown "${HOST_UNAME}":"${HOST_GNAME}" "/home/${HOST_UNAME}/enter-env.sh" > /dev/null 2>&1

su -s /bin/bash - ${HOST_UNAME}
