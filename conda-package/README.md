# Upload shennong-pykaldi to conda

This is a conda recipe in order to publish `shennong-pykaldi` to conda.

## Environment definition

First, we build a docker image with CentOS 7 and all the dependencies needed to
build the package:

```bash
docker build --tag condapkg_centos7 --build-arg CACHEBUST=$(date +%s) .
```

The build arg is used to force docker to download a new copy of this repo
everytime we build the image.

## Building the conda package

The entrypoint for this docker image is `anaconda_upload.sh`. This script takes as an argument the name of the folder we want to build for and upload to anaconda.

```bash
docker run -it --rm \
    -e CONDA_UPLOAD_TOKEN=<TOKEN> -e CONDA_USER=<USER> -e CONDA_CHANNEL=<CHANNEL> \
    --storage-opt size=50G condapkg_centos7 shennong-pykaldi
```

`CONDA_UPLOAD_TOKEN` is the token obtained from anaconda.org, `CONDA_USER` is
your username on anaconda.org, `CONDA_CHANNEL` is the channel you are uploading the
image to.

## Debugging

To debug the process, we can bypass the docker entrypoint as

```bash
docker run -it --rm -e CONDA_UPLOAD_TOKEN='<TOKEN>' --entrypoint bash condapkg_centos7
```
