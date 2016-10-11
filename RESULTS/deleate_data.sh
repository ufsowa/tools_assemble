#!/usr/bin/env bash

cd results

for i in S*; do
    cd $i
    for j in R*;do
	echo $i $j
	cd $j
	echo "raw: "`ls raw_* | wc -l`" r: "`ls *.dat | wc -l`
	rm raw_*
	echo "raw: "`ls raw_* | wc -l`" r: "`ls *.dat | wc -l`
	cd ..
    done
    cd ..

done