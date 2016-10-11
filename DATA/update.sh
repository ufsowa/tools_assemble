#!/usr/bin/env bash

# input variables
MANY="2"
f_step="$PWD/step.input"
files="stech"
NAME="S"

# paths
SOURCE=${PWD}"/../INPUT/data/"
DEST=${PWD}"/data/"
TEMPLATE=${PWD}"/template"
STEP="NULL"
ST=$PWD

#main body
cd ${DEST}
for i in ${NAME}*; do
    stech=${i##*S}
#    rm -r $i/data $i/template
    STEP=`awk -v stech=$stech 'BEGIN{out=-1}{stech=stech*100;stech=int(stech+.5);stech=stech/100;if($1==stech){out=$2}}END{if(out>=0){print out}else{print "NULL"}}' $f_step`
    if [ $STEP != "NULL" ];then
    cp -R -u ${TEMPLATE}/* $i
    cd $i/template
    sed -i 's/NAZWA/'${i}'SAMPLE/' run_sim
    sed -i 's/STEP/'${STEP}'/' conf.in
    outputs=$outputs" Pepared: $i $stech $STEP"

    cd ${DEST}
    fi
done

echo $outputs