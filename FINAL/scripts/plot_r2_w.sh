#!/usr/bin/env bash

f1="$1"
f2="$2"

echo "
plot '${f1}' u 1:(\$12) w p pt 6 lc -1 t 'wa','${f1}' u 1:(\$17) w p pt 7 lc 1 t 'wb',\
    '${f2}' u 1:(\$12) w p pt 6 ps 3 lc -1 notitle,'${f2}' u 1:(\$17) w p pt 7 ps 3 lc 1 notitle

pause -1
" > to_plot

gnuplot to_plot