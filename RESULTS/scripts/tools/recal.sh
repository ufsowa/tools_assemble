#!/bin/bash

export LC_ALL=C
SOURCE="${BASH_SOURCE[0]}"
PTH=$( dirname "$SOURCE" )
SRC=$PTH

#echo $0 >> tmp
#echo $PWD >> tmp
#echo $SRC >> tmp

module load python-numpy


echo "Recalculating..."

stpth=$PWD

recal(){
    #remove empty files
    name=$1
    for i in ${name}_*; do if ! [ -s $i ]; then rm $i; fi; done;
    for i in ${name}_* ; do
	linie=`awk 'END{print NR}' $i`
	start=`awk -v od=$linie 'BEGIN{C=(1-3/4);printf "%5.d", od*C }'`
	if [ -s $i ] ; then
	    nfile=${i#./}
	    scr=${nfile#${name}}
	    printf "%s %s " $scr $nfile
	    $SRC/recal_${name}.py $nfile $scr $STEP		# 1 - input; 2 - output
	    if [ -s "raw${scr}" ]; then 
		file="raw${scr}"
		sort -n -k1,1 $file > tmp; mv tmp $file
		echo "--> ok";
	    else echo "--> miss"; fi
	fi
done
}


for k in $1 ; do
    if [ -d $k ]; then
    echo $k
    cd $stpth/$k
    recal $k
    cd $stpth
    fi
done

