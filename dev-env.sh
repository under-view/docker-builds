#!/bin/bash

CDIR="$(pwd)"

HOSTUID=$(id -u $USER)
HOSTUNAME=$(id -un $USER)
HOSTGID=$(id -g $USER)
HOSTGNAME=$(id -gn $USER)

CTYPE="" # Container type
COMMAND=""
OPASSWORD="" # Optional password
WORKSPACE="" # Optional workspace directory

help_msg() {
	fname=$1

	printf "Usage: ${fname} [options]\n"
	printf "Example: ${fname} --build --image-name <name> --container-type yocto-project --distro-version ubuntu-24.04\n"
	printf "Options:\n"
	printf "\t-b, --build                           " ; printf "\tBuild and save docker image.\n"
	printf "\t-r, --run                             " ; printf "\tRun docker image.\n"
	printf "\t-l, --load                            " ; printf "\tLoad saved docker image.\n"
	printf "\t-i, --image-name   <name>             " ; printf "\tSpecify name of docker image to build,run, or save.\n"
	printf "\t-p, --password     <optional password>" ; printf "\tAssign optional password to docker container user.\n"
	printf "\t-t, --container-type <project>        " ; printf "\tType of docker container. Normally specified to 'yocto-project'.\n"
	printf "\t-d, --distro-version <distro+version> " ; printf "\tDistro and version used to build image.\n"
	printf "\t-d, --workspace-dir <workspace>       " ; printf "\tAbsolute path to a directory the docker will mount as /home/\$USER.\n"
	printf "\t-h, --help                            " ; printf "\tSee this message.\n"
}

[[ $# -eq 0 ]] && {
	help_msg $0
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
			((arg++))
			;;
		-d|--distro-version)
			DISTRO_VERSION="${!arg_passed_to_flag}"
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

[[ -z "${COMMAND}" ]] && { help_msg $0 ; exit 1 ; }
[[ -z "${DIMAGE}" ]] && { help_msg $0 ; exit 1 ; }
[[ "${COMMAND}" == "build" ]] && [[ -z "${CTYPE}" ]] && { help_msg $0 ; exit 1 ; }

source "${CDIR}/docker-setup.sh"
