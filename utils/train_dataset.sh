#!/usr/bin/env bash

DATASET_NAME=$1
DATASET_ROOT="/data"

python train.py --outdir=$DATASET_ROOT/training-runs --data=$DATASET_ROOT/$DATASET_NAME.zip --gpus=1

# --dry-run
