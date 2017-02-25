#!/usr/bin/env bash

#VARIABLES
NAME="T"
DEST=${PWD}"/data/"


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
