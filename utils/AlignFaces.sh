#!/usr/bin/env bash

# Default values
PREDICTOR="/pretrained/shape-predictor.dat"

PARAMS=""
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        # Flags
        -h|--help)
            echo "Required inputs: --input, and --output"
            exit 1
            ;;  
        # Variables
        -i|--input)
            INPUT_DIR="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --json)
            JSON="$2"
            shift 2
            ;;

        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2
            shift
            ;;
        *) # preserve positional arguments
            PARAMS="$PARAMS $1"
            ;;
    esac
done

# set positional arguments in their proper place
eval set -- "$PARAMS"

if [[ -z "$INPUT_DIR" ]]
then
    echo "Please choose an input directory"
    exit 1
fi

if [[ -z "$OUTPUT_DIR" ]]
then
    echo "Please choose an output directory"
    exit 1
fi

if [[ -z "$JSON" ]]
then
    JSON="--json=$OUTPUT_DIR/test.json"
fi

docker run --gpus all -it --rm --shm-size=8g \
	-v `pwd`:/input \
    -v $HOME/github/stylegan-tools:/stylegan \
    -w /stylegan -e DNNLIB_CACHE_DIR=/stylegan/.cache \
    --user $(id -u):$(id -g) \
	stylegan:pytorch python3 alignFaces.py \
    --predictor=/input/$PREDICTOR \
    --input=/input/$INPUT_DIR \
    --output=/input/${OUTPUT_DIR} $JSON
