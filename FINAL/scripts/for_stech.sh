#!/usr/bin/env bash

ST=$PWD
PTH=${ST}/.update
DEST=${ST}/results


tryb="r2"
tryb="r"


for cf_l in S*_static.${tryb}; do

    cf_s=${cf_l%%.${tryb}}_f.${tryb}
    echo $cf_l $cf_s

    ./plot_${tryb}_j.sh $cf_l $cf_s
    ./plot_${tryb}_w.sh $cf_l $cf_s
    ./plot_${tryb}_d.sh $cf_l $cf_s
    ./plot_${tryb}.sh $cf_l $cf_s
    ./plot_${tryb}_j.sh $cf_l $cf_s

done