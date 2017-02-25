#!/usr/bin/env bash

# input variables
MANY="300"
f_step="$PWD/step.input"
files="pic"
NAME="T"

# paths
SOURCE=${PWD}"/../INPUT/data/"
DEST=${PWD}"/data/"
TEMPLATE=${PWD}"/template"
STEP="NULL"
ST=$PWD

#main body
mkdir -p $DEST
cd ${SOURCE}
for i in ${NAME}*; do
    temp=${i##*T};temp=${temp%%_S*};
    stech=${i##*_S};

    STEP=`awk -v stech=$stech -v temp=$temp 'BEGIN{out=-1}{
	stech=stech*100;stech=int(stech+.5);stech=stech/100;
	temp=temp*100;temp=int(temp+.5);temp=temp/100;
	if($1==temp && $2==stech){out=$3}}END{if(out>=0){print out}else{print "NULL"}}' $f_step`
    
    outputs="Created: $temp $stech $STEP"
    if [ $STEP != "NULL" ] ;then
    mkdir -p ${DEST}${i}
    fi
done

STEP="NULL"
cd ${DEST}
for i in ${NAME}*; do
    temp=${i##*T};TEMP=${temp%%_S*};
    stech=${i##*_S};

    STEP=`awk -v stech=$stech -v temp=$temp 'BEGIN{out=-1}{
	stech=stech*100;stech=int(stech+.5);stech=stech/100;
	temp=temp*100;temp=int(temp+.5);temp=temp/100;
	if($1==temp && $2==stech){out=$3}}END{if(out>=0){print out}else{print "NULL"}}' $f_step`

    if [ $STEP != "NULL" ];then
    cp -R -u ${TEMPLATE}/* $i
    cd $i/template
    sed -i 's/NAZWA/'${i}'SAMPLE/' run_sim
    sed -i 's/STEP/'${STEP}'/' conf.in
    sed -i 's/TEMPERATURA/'${TEMP}'/' conf.in
    outputs=$outputs" Pepared: $i $temp $stech $STEP"

    cd ${DEST}
    fi
done

cd ${SOURCE}
for i in ${NAME}*; do
#    NUMBER=0
#    LAST=0
    cd $i
    rm `ls *pic.xyz | grep "^[0-9]pic.xyz"`
    rm `ls *pic.xyz | grep "^[0-9][0-9]pic.xyz"`
    rm `ls *pic.xyz | grep "^[0-9][0-9][0-9]pic.xyz"`
#        for j in *${files}.xyz; do
#    	NUMBER=${j%%stech.xyz}
#	#	NUMBER=${NUMBER##*_}
#    	if [ ${NUMBER} -gt ${LAST} ]; then
#    	    LAST=${NUMBER}
#    	fi
#        done
#        echo $i *${LAST}${files}.xyz
#        cp *${LAST}${files}.xyz ${DEST}/$i/S1/
    GOAL=${DEST}/$i/S1
    if [ -d $GOAL ]; then
    for file in $(ls -p *${files}.xyz | grep -v / | tail -${MANY}); do
	mv $file ${GOAL}
    done
    fi
    cd ..
    outputs=$outputs" Inputs: "`ls $GOAL |wc -l`
done

echo $outputs