#!/usr/bin/env bash

#VARIABLES
NAME="T"
DEST=${PWD}"/data/"
SRC=$PWD/scripts

cd ${DEST}
for i in ${NAME}*; do
    cd $i
    echo $i
    $SRC/generate 1 300
    cd ${DEST}
done
