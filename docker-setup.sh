#!/bin/bash

# Script stores all docker commands
# to build, load, & run a docker image.

DOCKER_IMAGE_NAME="${DIMAGE}:latest"

[[ -z "${WORKSPACE}" ]] && WORKSPACE="${CDIR}/workspace"

[[ "${COMMAND}" == "build" ]] && [[ -n "${CTYPE}" ]] && {
	docker build \
	      --no-cache \
	      --tag "${DOCKER_IMAGE_NAME}" \
	      "${CDIR}/containers/${CTYPE}/${DISTRO_VERSION}"

	mkdir -p "${CDIR}/docker-images"

	docker image \
	       save -o "${CDIR}/docker-images/${DIMAGE}.tar.xz" \
	       "${DOCKER_IMAGE_NAME}"
}

[[ "${COMMAND}" == "load" ]] && {
	docker image load -i "${CDIR}/${DIMAGE}.tar.xz"
}

[[ "${COMMAND}" == "run" ]] && {
	mkdir -p "${WORKSPACE}"
	docker run --rm -ti \
		-v "${WORKSPACE}":"/home/${USER}" \
		-v "${HOME}/.ssh":"/home/${USER}/.ssh":ro \
		-v "${HOME}/.Xauthority":"/home/${USER}/.Xauthority":ro \
		-v "/tmp/.X11-unix":"/tmp/.X11-unix":ro \
		-e DISPLAY="localhost:0" \
		-eHOST_UID="${HOSTUID}" \
		-eHOST_UNAME="${HOSTUNAME}" \
		-eHOST_GID="${HOSTGID}" \
		-eHOST_GNAME="${HOSTGNAME}" \
		"${DOCKER_IMAGE_NAME}" /bin/bash
}
