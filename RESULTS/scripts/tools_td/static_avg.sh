#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
PTH=$( dirname "$SOURCE" )
SRC=$PTH

#echo $0 >> tmp
#echo $PWD >> tmp
#echo $SRC >> tmp

echo "Sredniuje..."

module load python-numpy

min="half"
max="last"
if ! [ -z $1 ]; then min=$1; fi
if ! [ -z $2 ]; then max=$2; fi


stpth=$PWD
cd $stpth/R
rm static.avg*
lista=`ls | grep "raw_"`
$SRC/static_avg.py "avg" $min $max "static.avg.dat" $lista 1> static.avg.out 2> static.avg.err
rm *.avg

cd $stpth/R2
rm static.avg*
lista=`ls | grep "raw_"`
$SRC/static_avg.py "avg" $min $max "static.avg.dat" $lista 1> static.avg.out 2> static.avg.err
rm *.avg

cd $stpth