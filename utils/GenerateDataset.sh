#!/usr/bin/env bash

RESOLUTION="128"
DATA_DIR="./datasets/celeba_hq/train/male/"

PARAMS=""
case "$1" in
    -d|--dir)
        DATA_DIR="$2"
        shift 2;
        ;;
    -r|--resolution)
        RESOLUTION="$2"
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

if [ $DATA_DIR == "" ]; then
echo "Enter dataset directory -d"
exit
fi

# set positional arguments in their proper place
eval set -- "$PARAMS"

if [ $DATASET_NAME == "" ]; then

curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"username": "T4x1", "content": "Building dataset..."}' \
    $WEBHOOK_URL

python dataset_tool.py \
    --source=$DATA_DIR \
    --dest=celeba-hq-male.zip \
    --width=$RESOLUTION \
    --height=$RESOLUTION

curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"username": "T4x1", "content": "Built dataset!"}' \
    $WEBHOOK_URL
