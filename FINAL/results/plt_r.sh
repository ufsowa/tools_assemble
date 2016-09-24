#!/usr/bin/env bash

name="f_coll.dat"
name1="f_tracer.dat"
fitted="results_raw.dat"

echo "
file='${name}'
file_f='${fitted}'

plot file u 1:2 t 'aa', file u 1:5 t 'bb',\
    file u 1:3 t 'ab', file u 1:4 t 'ba',\
    file_f u 1:10 w l t 'faa', file_f u 1:13 w l t 'fbb',\
    file_f u 1:11 w l t 'fab', file_f u 1:12 w l t 'fba'

pause -1
" > to_plot

gnuplot to_plot