#!/usr/bin/env bash

f1="$1"
f2="$2"

echo "
plot '${f1}' u 1:9 w p pt 5 lc 2 t 'fa', '${f1}' u 1:11 w p pt 7 lc 3 t 'fb',\
     '${f2}' u 1:9 w p pt 5 ps 3 lc 2 lw 2 notitle, '${f2}' u 1:11 w p pt 7 ps 3 lc 3 lw 2 notitle

pause -1
" > to_plot

gnuplot to_plot