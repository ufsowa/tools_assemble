#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
PTH=$( dirname "$SOURCE" )
SRC=$PTH

echo $0 >> tmp
echo $PWD >> tmp
echo $SRC >> tmp

export LC_ALL=C

echo "Sredniuje..."

module load python-numpy

stpth=$PWD
cd $stpth/R
rm static.avg*

lista=`ls | grep "raw_"`
for file in $lista; do
    sort -n -k1,1 $file > tmp; mv tmp $file
done
min="half"
max="last"
every=1
$SRC/static_avg.py "avg" $min $max "static.avg.dat" $lista $1>static.avg.out $2>static.avg.err

cd $stpth/R2
rm static.avg*

lista=`ls | grep "raw_"`
for file in $lista; do
    sort -n -k1,1 $file > tmp; mv tmp $file
done
min="half"
max="last"
every=1
$SRC/static_avg.py "avg" $min $max "static.avg.dat" $lista $1>static.avg.out $2>static.avg.err


cd $stpth