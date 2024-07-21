# docker-builds

Repo with scripts and docker files for different types of builds

### Dependencies

Follow one of the [docker install](https://docs.docker.com/engine/install) instructions.

### Build Docker Image

This will also save the docker image.

```bash
$ ./dev-env.sh --build --image-name myimage --container-type yocto-project --distro-version ubuntu-22.04
```

### Load Docker Image

Tar file with image must be in same directory as docker-setup.sh script

```bash
$ ./dev-env.sh --load --image-name myimage.tar.xz
```

### Run Docker Image

```bash
$ ./dev-env.sh --run --image-name myimage
```
