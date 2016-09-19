#!/usr/bin/env bash

# variables
ID="s"

# paths
TO=$PWD
NAME="S*"
DEST=${TO}"/data/"
SRC=$PWD/scripts

cd ${DEST}
for i in ${NAME}; do
    cd $i
    name="${ID}$i"
    screen -dmS $name
    screen -S $name -X screen $SRC/calculate
    cd ${DEST}
done

sleep 5s

screen -ls