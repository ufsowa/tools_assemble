#!/usr/bin/env bash

name="f_coll.dat"
name1="f_coll.fromtf"
#name1="sol2.coll"


echo "
set key top center

file='${name}
file1='${name1}
plot file u 1:(\$2) t 'aa', file u 1:(\$8) t 'bb',file u 1:(\$4) t 'ab', file u 1:(\$6) t 'ba',\
    file1 u 1:2 t 'taa', file1 u 1:3 t 'tab',file1 u 1:4 t 'tba', file1 u 1:5 t 'tbb'

pause -1
" > to_plot

gnuplot to_plot