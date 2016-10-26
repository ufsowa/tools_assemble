#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
PTH=$( dirname "$SOURCE" )
SRC=$PTH

#echo $0 >> tmp
#echo $PWD >> tmp
#echo $SRC >> tmp

echo "Sredniuje..."

module load python-numpy

stpth=$PWD
avg(){
    rm static.avg*
    lista=`ls | grep "raw_"`
    $SRC/static_avg.py "avg" $min $max "static.avg.dat" $lista 1> static.avg.out 2> static.avg.err
    rm *.avg
}

min="half"
max="last"
if ! [ -z $1 ]; then min=$1; fi
if ! [ -z $2 ]; then max=$2; fi

for k in * ; do
    if [ -d $k ]; then
    echo $k
    cd $stpth/$k
    avg
    cd $stpth
    fi
done
