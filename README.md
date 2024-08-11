# docker-builds

Repo with scripts and docker files for different types of builds.
This repo will take another approach by not writing wrapper scripts
around docker commands.

1. [Dependencies](#dependencies)
2. [Building Docker Images](#building)
	1. [Underview Devel Ubuntu 22.04](#udevel-ubuntu22.04)
	1. [Underview Devel Ubuntu 24.04](#udevel-ubuntu24.04)
	2. [Yocto Project Devel Ubuntu 22.04](#ypdevel-ubuntu22.04)
	3. [Yocto Project Devel Ubuntu 24.04](#ypdevel-ubuntu24.04)
3. [Saving Docker Images](#saving)
4. [Loading Docker Image](#loading)
5. [Running Docker Image](#running)

## Dependencies <a name="dependencies"></a>

Follow one of the [docker install](https://docs.docker.com/engine/install) instructions.

## Building Docker Images <a name="building"></a>

### Underview Devel Ubuntu 22.04 <a name="udevel-ubuntu22.04"></a>

```bash
$ docker build --no-cache \
               --tag "myimage:latest" \
               --build-arg "HOST_UID=$(id -u)" \
               --build-arg "HOST_GID=$(id -g)" \
               $(pwd)/containers/underview-devel/ubuntu-22.04
```

### Underview Devel Ubuntu 24.04 <a name="udevel-ubuntu24.04"></a>

```bash
$ docker build --no-cache \
               --tag "myimage:latest" \
               --build-arg "HOST_UID=$(id -u)" \
               --build-arg "HOST_GID=$(id -g)" \
               $(pwd)/containers/underview-devel/ubuntu-24.04
```

### Yocto Project Devel Ubuntu 22.04 <a name="ypdevel-ubuntu22.04"></a>

```bash
$ docker build --no-cache \
               --tag "myimage:latest" \
               --build-arg "HOST_UID=$(id -u)" \
               --build-arg "HOST_GID=$(id -g)" \
               $(pwd)/containers/yocto-project/ubuntu-22.04
```

### Yocto Project Devel Ubuntu 24.04 <a name="ypdevel-ubuntu24.04"></a>

```bash
$ docker build --no-cache \
               --tag "myimage:latest" \
               --build-arg "HOST_UID=$(id -u)" \
               --build-arg "HOST_GID=$(id -g)" \
               $(pwd)/containers/yocto-project/ubuntu-24.04
```

## Saving Docker Images <a name="saving"></a>

```bash
$ mkdir -p $(pwd)/docker-images
$ docker image save -o $(pwd)/docker-images/myimage.tar.xz
```

## Loading Docker Image <a name="loading"></a>

```bash
$ docker image load -i myimage.tar.xz
```

## Running Docker Image <a name="running"></a>

```bash
$ export DOCKER_IMAGE_NAME="myimage:latest"
$ export WORKSPACE="${HOME}/workspace"
$ mkdir -p $WORKSPACE
$ source $(pwd)/composes/default-env.sh
$ docker compose -f $(pwd)/composes/default-compose.yaml run --rm development
```
