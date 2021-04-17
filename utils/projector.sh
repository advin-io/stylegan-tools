#!/usr/bin/env bash


PARAMS=""
case "$1" in
    -d|--dataset)
        DATASET_NAME="$1"
        ;;
    -t|--target)
        TARGET_NAME="$1"
        ;;
    -*|--*=) # unsupported flags
        echo "Error: Unsupported flag $1" >&2
        exit 1
        ;;
    *) # preserve positional arguments
        PARAMS="$PARAMS $1"
        ;;
esac

# set positional arguments in their proper place
eval set -- "$PARAMS"

python projector.py --outdir=out --target=$TARGET_NAME \
    --network=https://nvlabs-fi-cdn.nvidia.com/stylegan2-ada-pytorch/pretrained/$DATASET_NAME.pkl
