#!/usr/bin/env bash

# variables
ID="relt"

# paths
TO=$PWD
NAME="S*"
DEST=${TO}"/results"
SRC=$PWD/scripts

cd ${DEST}
for i in ${NAME}; do
    cd $i
    name="${ID}$i"
    screen -dmS $name
    screen -S $name -X screen $SRC/calculate
#    $SRC/calculate
    cd ${DEST}
done

sleep 2s

screen -ls