#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
PTH=$( dirname "$SOURCE" )

module load python-numpy

stpth=$PWD
BIN=20
if ! [ -z $1 ]; then BIN=$1; fi

loop(){
    rm static.factors.dat *.bin
    lista=`ls | grep "raw_"`
    end=0
    end_step=0

    for i in $lista ; do
	end_step=`awk -v buf=$end_step 'END{if($1 > buf){print $1}else{print buf}}' $i`
	nr=`cat $i | wc -l`
	if [ ${nr} -gt ${end} ]; then end=${nr} ; fi
	#echo $nr $end, $end_step
    done
    bin=`awk -v lasti=$end -v step=$BIN -v jumps=$end_step 'BEGIN{printf "%.1f", (jumps*step)/lasti;exit;}'`
    max=`awk -v step=$bin -v jumps=$end_step 'BEGIN{printf "%.0f", jumps/step;exit;}'`
    echo $end, $end_step, $max, $bin
    $PTH/static_avg.py "loop" $max $bin "static.factors.dat" $lista 1> static.factors.out 2> static.factors.err
    rm *.bin
}

for k in * ; do
    if [ -d $k ]; then
    echo $k
    cd $stpth/$k
    loop
    cd $stpth
    fi
done
