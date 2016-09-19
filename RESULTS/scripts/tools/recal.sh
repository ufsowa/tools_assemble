#!/bin/bash

export LC_ALL=C
SOURCE="${BASH_SOURCE[0]}"
PTH=$( dirname "$SOURCE" )
SRC=$PTH

echo $0 >> tmp
echo $PWD >> tmp
echo $SRC >> tmp

echo "Recalculating..."

module load python-numpy

stpth=$PWD
cd $stpth/R/
#remove empty files
for i in r_*; do if ! [ -s $i ]; then rm $i; fi; done;

for i in ./r_* ; do
#	linie=`awk 'END{print NR}' $i`
#	start=`awk -v od=$linie 'BEGIN{C=(1-3/4);printf "%5.d", od*C }'`
	if [ -s $i ] ; then
	nfile=${i#./}
	scr=${nfile#r}
	printf "%s %s " $scr $nfile
	$SRC/recal_r.py $nfile $scr $STEP		# 1 - input; 2 - output
	if [ -s "raw${scr}" ]; then 
	file="raw${scr}"
	sort -n -k1,1 $file > tmp; mv tmp $file
	echo "--> ok";
	else echo "--> miss"; fi
	fi
done

cd $stpth/R2
for i in r2_*; do if ! [ -s $i ]; then rm $i; fi; done;

for i in ./r2_* ; do
#	linie=`awk 'END{print NR}' $i`
#	start=`awk -v od=$linie 'BEGIN{C=(1-3/4);printf "%5.d", od*C }'`
	if [ -s $i ] ; then
	nfile=${i#./}
	scr=${nfile#r2}
	printf "%s %s " $scr $nfile
	$SRC/recal_r2.py $nfile $scr $STEP		# 1 - input; 2 - output
	if [ -s "raw${scr}" ]; then 
	file="raw${scr}"
	sort -n -k1,1 $file > tmp; mv tmp $file
	echo "--> ok";
	else echo "--> miss"; fi
	fi
done
cd $stpth
