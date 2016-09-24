#!/usr/bin/env bash

name="f_coll.dat"
name1="f_tracer.dat"

fitted="results_raw.dat"
echo "
file='${name1}'
file_f='${fitted}'

set key center top
plot file u 1:2 t 'Da', file u 1:3 t 'Db',\
    file u 1:(\$4*\$6*3.0) w l t 'ta',file u 1:(\$5*\$8*3.0) w l t 'tb',\
    file_f u 1:2 t 'fDa', file_f u 1:3 t 'fDb',\
    file_f u 1:(\$4*\$6*3.0) w l t 'fta',file_f u 1:(\$5*\$8*3.0) w l t 'ftb'


#plot file u 1:4 t 'fa', file u 1:5 t 'fb',\
    file_f u 1:4 t 'ffa', file_f u 1:5 t 'ffb'

#plot file u 1:6 t 'va', file u 1:8 t 'vb'

#plot file u 1:(\$10/\$18) t 'wa'
#plot file u 1:(\$14*\$1) t 'ja'

pause -1
" > to_plot

gnuplot to_plot