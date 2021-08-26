#!/usr/bin/env bash

DATASET_NAME=celeba-hq-male

PARAMS=""
case "$1" in
    -d|--dataset)
        DATASET_NAME="$2"
        shift 2;
        ;;
    -*|--*=) # unsupported flags
        echo "Error: Unsupported flag $1" >&2
        exit 1
        ;;
    *) # preserve positional arguments
        PARAMS="$PARAMS $1"
        ;;
esac

if [ $DATASET_NAME == "" ]; then
echo "Enter dataset name with -d"
exit
fi

# set positional arguments in their proper place
eval set -- "$PARAMS"

curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"username": "T4x1", "content": "Training started..."}' \
    $WEBHOOK_URL

python train.py \
    --outdir=./training-runs \
    --data=./$DATASET_NAME.zip \
    --gpus=1 --mirror=1 --kimg=1000 \
#    --batch=32

curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"username": "T4x1", "content": "Training finished!"}' \
    $WEBHOOK_URL
