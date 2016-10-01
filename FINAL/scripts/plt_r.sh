#!/usr/bin/env bash

name="f_coll.dat"
name1="f_tracer.dat"


echo "
file='${name}
plot file u 1:2 t 'aa', file u 1:8 t 'bb',\
    file u 1:4 t 'ab', file u 1:6 t 'ba'

pause -1
" > to_plot

gnuplot to_plot