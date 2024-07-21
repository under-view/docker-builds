#!/bin/bash

# Script stores all docker commands
# to build, load, & run a docker image.

DOCKER_IMAGE_NAME="${DIMAGE}:latest"

[[ -z "${WORKSPACE}" ]] && WORKSPACE="${CDIR}/workspace"
[[ -z "${OPASSWORD}" ]] && OPASSWORD="password"

[[ "${COMMAND}" == "build" ]] && [[ -n "${CTYPE}" ]] && {
	docker build \
	      --no-cache \
	      --tag "${DOCKER_IMAGE_NAME}" \
	      "${CDIR}/containers/${CTYPE}/${DISTRO_VERSION}"

	docker image \
	       save -o "${CDIR}/${DIMAGE}.tar.xz" \
	       "${DOCKER_IMAGE_NAME}"
}

[[ "${COMMAND}" == "load" ]] && {
	docker image load -i "${CDIR}/${DIMAGE}.tar.xz"
}

[[ "${COMMAND}" == "run" ]] && {
	mkdir -p "${WORKSPACE}"
	docker run --rm -ti \
		-v "${WORKSPACE}":"/home/${USER}" \
		-eHOST_UID="${HOSTUID}" \
		-eHOST_UNAME="${HOSTUNAME}" \
		-eHOST_GID="${HOSTGID}" \
		-eHOST_GNAME="${HOSTGNAME}" \
		-eDOCKER_PASSWORD="${OPASSWORD}" \
		"${DOCKER_IMAGE_NAME}" /bin/bash
}
