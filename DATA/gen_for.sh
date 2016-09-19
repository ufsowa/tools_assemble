#!/usr/bin/env bash

#VARIABLES
NAME="S"
DEST=${PWD}"/data/"
SRC=$PWD/scripts

cd ${DEST}
for i in ${NAME}*; do
    cd $i
    echo $i
    $SRC/generate 1 2
    cd ${DEST}
done
