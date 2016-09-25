#!/usr/bin/env bash

name="f_coll.dat"
name1="f_tracer.dat"


echo "
file='${name1}'

set key center top
#plot file u 1:2 t 'Da', file u 1:4 t 'Db',\
    file u 1:(\$6*\$10*3.0) w l t 'ta',file u 1:(\$8*\$14*3.0) w l t 'tb'


#plot file u 1:6 t 'fa', file u 1:8 t 'fb'

#plot file u 1:10 t 'va', file u 1:14 t 'vb'

plot file u 1:(\$10/\$18) t 'wa'
#plot file u 1:(\$14*\$1) t 'ja'

pause -1
" > to_plot

gnuplot to_plot