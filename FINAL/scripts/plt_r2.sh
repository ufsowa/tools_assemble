#!/usr/bin/env bash

name="f_coll.dat"
name1="f_tracer.dat"

fitted="results_raw.dat"
echo "
file='${name1}'
file_f='${fitted}'
SC=1000.0

set key left
set key spacing 5
set xlabel 'A_xB_{1-x}'
set ylabel 'n_i/time [(MC time)^{-1}]'
plot file u 2:(\$3*SC) w p pt 7 lc 1 t 'Da', file u 2:(\$4*SC) w p pt 4 lc 1 t 'Db',\
    file u 2:(\$5) w p pt 7 lc 2 t 'ta',file u 2:(\$6) w p pt 4 lc 2 t 'tb',\
    file u 2:(\$7*3.0*SC) w p pt 7 lc 3 t 'a1',file u 2:(\$9*3.0*SC) w p pt 4 lc 3 t 'b1',\
    file u 2:(\$8*3.0*SC) w p pt 7 lc 4 t 'a2',file u 2:(\$10*3.0*SC) w p pt 4 lc 4 t 'b2'


#plot file u 2:5 t 'fa', file u 2:6 t 'fb',\
    file_f u 1:4 t 'ffa', file_f u 1:5 t 'ffb'

set label \"E^{I}_{a} = 0.4; E^{II}_{a} = 1.2;\" at screen 0.65,0.9
set label \"E^{I}_{b} = 0.6; E^{II}_{b} = 0.5;\" at screen 0.65,0.85

#set term jpeg enhanced; set output 'jump_freq.jpeg'

#plot [0.3:0.7] file u 2:(\$3/\$5/3.0) w p pt 6 lc 1 t 'v_a', file u 2:(\$7) w p pt 4 lc 1 t 'v^I_a',\
 file u 2:(\$8) w p pt 10 lc 1 t 'v^{II}_a',\
 file u 2:(\$4/\$6/3.0) w p pt 7 lc -1 t 'v_b',file u 2:(\$9) w p pt 4 lc -1 t 'v^I_b',file u 2:(\$10) w p pt 10 lc -1 t 'v^{II}_b'

#plot file u 1:(\$10/\$18) t 'wa'
#plot file u 1:(\$14*\$1) t 'ja'

pause -1
" > to_plot

gnuplot to_plot