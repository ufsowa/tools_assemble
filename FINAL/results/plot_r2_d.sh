#!/usr/bin/env bash

f1="$1"
f2="$2"

echo "
plot '${f1}' u 1:(\$5) w p pt 6 lc -1 t 'Da','${f1}' u 1:(\$7) w p pt 7 lc 1 t 'Db',\
    '${f2}' u 1:(\$5) w p pt 6 ps 3 lc -1 notitle,'${f2}' u 1:(\$7) w p pt 7 ps 3 lc 1 notitle

pause -1
" > to_plot

gnuplot to_plot