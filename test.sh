#!/usr/bin/env bash

echo "Clearing directory"
rm -f ./youtube/*

START_TIME=17
LENGTH=1
VIDEO_NAME="guitar"
OUTPUT_DIR="youtube"
ffmpeg -y -hide_banner -loglevel panic \
        -ss $START_TIME \
        -t $LENGTH \
        -i ./$VIDEO_NAME.mp4 $OUTPUT_DIR/$VIDEO_NAME%05d.png \
        -q:a 0 -map a $VIDEO_NAME.mp3
