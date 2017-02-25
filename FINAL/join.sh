#!/usr/bin/env bash

name=`pwd`
name=${name##*/}
rm $name.dat
for i in *_avg.*; do
    T=${i##*T}; T=${T%%_S*}
    S=${i##*_S}; S=${S%%_*}
    fil=`cat $i`
    lin=$T" "$S" "$fil
    echo $lin >> $name.dat
done