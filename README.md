# docker-builds

Repo with scripts and docker files for different types of builds.
This repo will take another approach by not writing wrapper scripts
around docker commands.

### Dependencies

Follow one of the [docker install](https://docs.docker.com/engine/install) instructions.

### Build Docker Image

**Underview Devel Ubuntu 22.04**
```bash
$ docker build --no-cache --tag "myimage" $(pwd)/containers/underview-devel/ubuntu-22.04
```

**Yocto Project Devel Ubuntu 22.04**
```bash
$ docker build --no-cache --tag "myimage" $(pwd)/containers/yocto-project/ubuntu-22.04
```

**Yocto Project Devel Ubuntu 24.04**
```bash
$ docker build --no-cache --tag "myimage" $(pwd)/containers/yocto-project/ubuntu-24.04
```

### Save Docker Image

```bash
$ mkdir -p $(pwd)/docker-images
$ docker image save -o $(pwd)/docker-images/myimage.tar.xz
```

### Load Docker Image

Tar file with image must be in same directory as docker-setup.sh script

```bash
$ docker image load -i myimage.tar.xz
```

### Run Docker Image

```bash
$ export DOCKER_IMAGE_NAME="myimage:latest"
$ export WORKSPACE="${HOME}/workspace"
$ mkdir -p $WORKSPACE
$ source $(pwd)/composes/default-env.sh
$ docker compose -f $(pwd)/composes/default-compose.yaml run development
```
