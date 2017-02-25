#!/bin/bash

export LC_ALL=C

ST=$PWD
DEST=$ST/data
SRC=$ST/../RESULTS/results

rm -R $SRC
mkdir $SRC

#FROM="$ST/$NAME"
#SRC="$PLG_GROUPS_STORAGE/plgginterdif"
#mv $FROM/results $SRC/$NAME/results

cd $DEST
for stech in T*; do
    cd $stech
    echo "For $stech raw in R:" `ls results/r/r_* | wc -l` "R2:" `ls results/r2/r2_* | wc -l`

#    echo "For $stech " 
#    ls -l results/R/static.*.dat
#    ls -l results/R2/static.*.dat

    echo $stech
    mv results $SRC/$stech
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
