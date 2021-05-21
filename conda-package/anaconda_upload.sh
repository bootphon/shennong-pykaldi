#!/bin/bash
PKG_NAME=shennong-pykaldi
BLD_PATH=/usr/local/conda-bld/linux-64/

git pull origin master
conda build $1
for f in $(find $BLD_PATH -type f -name "*.tar.bz2"); do
    anaconda -t $CONDA_UPLOAD_TOKEN upload -u $CONDA_USER -c $CONDA_CHANNEL $f
done
