#!/usr/bin/env bash

f1="$1"
f2="$2"

echo "
plot '${f1}' u 1:5 w p pt 6 lc -1 t 'aa', '${f1}' u 1:7 w p pt 4 lc 1 t 'ab', '${f1}' u 1:9 w p pt 5 lc 2 t 'ba', '${f1}' u 1:11 w p pt 7 lc 3 t 'bb',\
    '${f2}' u 1:5 w p pt 6 ps 3 lw 2 lc -1 notitle, '${f2}' u 1:7 w p pt 4 ps 3 lc 1 lw 2 notitle, '${f2}' u 1:9 w p pt 5 ps 3 lc 2 lw 2 notitle, '${f2}' u 1:11 w p pt 7 ps 3 lc 3 lw 2 notitle

pause -1
" > to_plot

gnuplot to_plot