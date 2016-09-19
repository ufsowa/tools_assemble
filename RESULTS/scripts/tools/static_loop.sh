#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
PTH=$( dirname "$SOURCE" )


module load python-numpy

stpth=$PWD
BIN=20

cd $stpth
cd R
rm static.factors.dat *.bin
#cp $stpth/static_avg.py .
lista=`ls | grep "raw_"`
min="half"
end=0
every=1

for i in $lista ; do
    nr=`awk 'END{print $1}' $i`
    echo $nr $end
    if [ ${nr} -gt ${end} ]; then end=${nr} ; fi
done
max=`awk -v lasti=$end -v step=$BIN 'BEGIN{printf "%d", lasti/step;exit;}'`
#echo $end, $max
$PTH/static_avg.py "loop" $max $BIN "static.factors.dat" $lista $1>static.factors.out $2>static.factors.err


cd $stpth
cd R2
rm static.factors.dat *.bin
#cp $stpth/static_avg.py .
lista=`ls | grep "raw_"`
min="half"
end=0
every=1

for i in $lista ; do
    nr=`awk 'END{print NR}' $i`
#    echo $nr $end
    if [ ${nr} -gt ${end} ]; then end=${nr} ; fi
done
max=`awk -v lasti=$end -v step=$BIN 'BEGIN{printf "%d", lasti/step;exit;}'`
#echo $end, $max
$PTH/static_avg.py "loop" $max $BIN "static.factors.dat" $lista $1>static.factors.out $2>static.factors.err


cd $stpth