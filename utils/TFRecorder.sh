#!/usr/bin/env bash

DATASET_NAME="$1"
DATASET_ROOT="/data"

echo "Directory: $DATASET_ROOT/$DATASET_NAME"

python dataset_tool.py --source=$DATASET_ROOT/$DATASET_NAME --dest=$DATASET_ROOT/$DATASET_NAME.zip
