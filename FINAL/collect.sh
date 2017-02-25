#!/bin/bash

export LC_ALL=C

NAME="DIFF_2"
#NAME="SYS_ORD_ASY"
ST=$PWD
DEST=$ST/../RESULTS/results

SRC=$ST/$NAME
mkdir $SRC

#mkdir $NAME/results
#SRC="$ST/$NAME/results"


cd $DEST
for stech in T*; do
    cd $stech
#    echo "For $stech raw in R: " `ls results/R/r_* | wc -l` "R2:" `ls results/R2/r2_* | wc -l`
#    echo "For $stech raw in R: " `ls results/R/raw_* | wc -l` "R2:" `ls results/R2/raw_* | wc -l`

    echo "For $stech " 
    ls -l ./r/static.*.dat
    ls -l ./r2/static.*.dat

#    cd ..

#    echo $stech
#    mv $stech/results $SRC/$stech

	cp ./r/static.avg.dat $SRC/${stech}_avg.r
	cp ./r/static.factors.dat $SRC/${stech}_loop.r
	cp ./r2/static.avg.dat $SRC/${stech}_avg.r2
	cp ./r2/static.factors.dat $SRC/${stech}_loop.r2
	cp ./n/static.avg.dat $SRC/${stech}_avg.n
	cp ./n/static.factors.dat $SRC/${stech}_loop.n
	cp ./bar/static.avg.dat $SRC/${stech}_avg.bar
	cp ./bar/static.factors.dat $SRC/${stech}_loop.bar
	cp ./j/static.avg.dat $SRC/${stech}_avg.j
	cp ./j/static.factors.dat $SRC/${stech}_loop.j
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
