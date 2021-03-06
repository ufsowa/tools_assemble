#!/usr/bin/env bash

#VARIABLES
NAME="T"
DEST=${PWD}"/data/"
SRC=$PWD/scripts

cd ${DEST}
for i in ${NAME}*; do
    cd $i
    echo $i
    name="run$i"
    screen -dmS "$name"
    screen -S $name -X screen /bin/bash -c "$SRC/run 1 > log.run"
    cd ${DEST}
done

screen -ls
sleep 5s
echo "Print log.run:"
cd ${DEST}
for i in ${NAME}*; do
    cd $i
    echo $i
    name="run$i"
    tail -1 log.run
    cd ${DEST}
done
