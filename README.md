# docker-builds

Repo with scripts and docker files for different types of builds

### Dependencies

Follow one of the [docker install](https://docs.docker.com/engine/install) instructions.

### Build Docker Image

This will also save the docker image.

```bash
$ ./docker-setup.sh --build --image-name myimage --container-type yocto-project
```

### Load Docker Image

Tar file with image must be in same directory as docker-setup.sh script

```bash
$ ./docker-setup.sh --load --image-name myimage
```

### Run Docker Image

```bash
mkdir -p $(pwd)/workspace
$ ./docker-setup.sh --run --image-name myimage
```
