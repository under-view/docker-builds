#!/bin/bash

CDIR="$(pwd)"

HOSTUID="$(id -u $USER)"
HOSTUNAME="$(id -un $USER)"
HOSTGID="$(id -g $USER)"
HOSTGNAME="$(id -gn $USER)"

CTYPE=""     # Container type
DIMAGE=""    # Docker image
COMMAND=""   # Docker command
PASSWORD=""  # Optional: docker container password for user
WORKSPACE="" # Optional: workspace directory docker mounts to /home/$USER

help_msg() {
	fname="$1"

	printf "Usage: ${fname} [options]\n"
	printf "Example: ${fname} --build --image-name <name> --container-type yocto-project --distro-version ubuntu-24.04\n"
	printf "Options:\n"
	printf "\t-b, --build                             " ; printf "\tBuild and save docker image.\n"
	printf "\t-r, --run                               " ; printf "\tRun docker image.\n"
	printf "\t-l, --load                              " ; printf "\tLoad saved docker image.\n"
	printf "\t-i, --image-name     <name>             " ; printf "\tSpecify name of docker image to build,run, or save.\n"
	printf "\t-p, --password       <optional password>" ; printf "\tAssign optional password to docker container user.\n"
	printf "\t-t, --container-type <project>          " ; printf "\tType of docker container. Normally specified to 'yocto-project'.\n"
	printf "\t-d, --distro-version <distro+version>   " ; printf "\tDistro and version used to build image.\n"
	printf "\t-w, --workspace      <workspace>        " ; printf "\tAbsolute path to a directory the docker will mount as /home/\$USER.\n"
	printf "\t-h, --help                              " ; printf "\tSee this message.\n"
}


container_list() {
	carg=$1
	exists=0

	for container in "${CDIR}/containers"/*; do
		container="$(basename "${container}")"
		[[ "${carg}" == "${container}" ]] && exists=1
	done

	[[ "${exists}" -eq 1 ]] && return 0

	help_msg "$0"

	printf "\nSupported Containers\n"
	for container in "${CDIR}/containers"/*; do
		container="$(basename "${container}")"
		printf "\t[x] ${container}\n"
	done

	exit 1
}


distro_list() {
	darg=$1
	exists=0

	for distro in "${CDIR}/containers/${CTYPE}"/*; do
		distro="$(basename "${distro}")"
		[[ "${darg}" == "${distro}" ]] && exists=1
	done

	[[ "${exists}" -eq 1 ]] && return 0

	help_msg "$0"

	printf "\nSupported Distro's\n"
	for distro in "${CDIR}/containers/${CTYPE}"/*; do
		distro="$(basename "${distro}")"
		printf "\t[x] ${distro}\n"
	done

	exit 1
}


[[ $# -eq 0 ]] && {
	help_msg "$0"
	exit 1
}

for ((arg=1; arg<=$#; arg++)); do
	arg_passed_to_flag=$((arg+1))
	case "${!arg}" in
		-b|--build)
			COMMAND="build"
			;;
		-l|--load)
			COMMAND="load"
			;;
		-r|--run)
			COMMAND="run"
			;;
		-i|--image-name)
			DIMAGE="${!arg_passed_to_flag}"
			((arg++))
			;;
		-p|--password)
			OPASSWORD="${!arg_passed_to_flag}"
			((arg++))
			;;
		-t|--container-type)
			CTYPE="${!arg_passed_to_flag}"
			container_list "${CTYPE}"
			((arg++))
			;;
		-d|--distro-version)
			DISTRO_VERSION="${!arg_passed_to_flag}"
			distro_list "${DISTRO_VERSION}" "${CTYPE}"
			((arg++))
			;;
		-w|--workspace)
			WORKSPACE="${!arg_passed_to_flag}"
			((arg++))
			;;
		-h|--help)
			help_msg $0
			exit 1
			;;
		*)
			help_msg $0
			exit 1
			;;
	esac
done

# If no command flags specified display help message
[[ -z "${COMMAND}" ]] && { help_msg $0 ; exit 1 ; }

# If a docker image type not specified display help message
[[ -z "${DIMAGE}" ]] && { help_msg $0 ; exit 1 ; }

# If build flag choosen and container-type flag empty display help message
[[ "${COMMAND}" == "build" ]] && [[ -z "${CTYPE}" ]] && { help_msg $0 ; exit 1 ; }

source "${CDIR}/docker-setup.sh"
