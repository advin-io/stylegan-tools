#!/bin/bash

docker run --shm-size=2g --gpus all -it --rm \
    -v `pwd`:/scratch --user $(id -u):$(id -g) \
    -v $HOME/Datasets:/data/ -v $HOME/Models:/models/ \
    -w /scratch -e HOME=/scratch -e WEBHOOK_URL=$WEBHOOK_URL \
    stylegan:latest