#!/bin/bash

export LC_ALL=C

NAME="TD_C2"
#NAME="SYS_ORD_ASY"
ST=$PWD
DEST=$ST/../RESULTS/results

SRC=$ST/$NAME
mkdir $SRC

#mkdir $NAME/results
#SRC="$ST/$NAME/results"


cd $DEST
for stech in S*; do
    cd $stech
#    echo "For $stech raw in R: " `ls results/R/r_* | wc -l` "R2:" `ls results/R2/r2_* | wc -l`
#    echo "For $stech raw in R: " `ls results/R/raw_* | wc -l` "R2:" `ls results/R2/raw_* | wc -l`

    echo "For $stech " 
    ls -l ./R/static.*.dat
    ls -l ./R2/static.*.dat

#    cd ..

#    echo $stech
#    mv $stech/results $SRC/$stech

	cp ./R/static.avg.dat $SRC/${stech}_static_f.r
	cp ./R/static.factors.dat $SRC/${stech}_static.r
	cp ./R2/static.avg.dat $SRC/${stech}_static_f.r2
	cp ./R2/static.factors.dat $SRC/${stech}_static.r2


    cd ..

#    if [ -e $DEST/$stech ]; then
#        cd $DEST/$stech
#        MAX=`ls data | sort -n | tail -1 | grep -o '[0-9]*'`
#        ((MAX++))
#        MAX=S$MAX
#    else
#        MAX="S1"
#fi
done
