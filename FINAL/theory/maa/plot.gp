#!/usr/bin/gnuplot

set encoding iso_8859_1
set term postscript eps enhanced color "Roman,32"
set output 'D_theory.eps'

unset key

#set xtics 0.1
set ytics 0.01
set xlabel 'x in A_{x}B_{(1-x)}'
set ylabel 'D [ {\305}^2/s ]' offset 2


plot 'D.dat' u 1:3 w p pt 7 ps 3 lc 1 lw 2,'D_nocv.dat' u 1:3 w p pt 6 ps 3 lc -1 lw 2


pause -1





