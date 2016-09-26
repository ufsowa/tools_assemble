#!/usr/bin/env bash

name="results_coef.dat"
name="results_rnd.dat"


echo "
file='${name}'

set key center top

#plot file u 1:2 t 'Da', file u 1:3 t 'Db'
#plot file u 1:4 t 'fia', file u 1:5 t 'fib'
#plot file u 1:6 t 'ra', file u 1:7 t 'rb'
plot file u 1:8 t 'DIa', file u 1:9 t 'DIb'
#plot file u 1:10 t 'D'
#plot file u 1:11 t 'S'

#plot file u 1:12 t 'DIa_np', file u 1:13 t 'DIb_np'
#plot file u 1:14 t 'D_np'

pause -1
" > to_plot

gnuplot to_plot

#tests for faa*fbb - fab*fba
    #faa*fbb - fab*fba = xa*fb*(faa+fab) + xb*fa*(fbb+fba)
    #faa*fbb - fab*fba = fa*fbb + fb*faa -fa*fb
    #faa*fbb - fab*fba = fa*(fbb + fbb)		#for A atoms
    #faa*fbb - fab*fba = fb*(faa + fab)		#for B atoms

#tests for fab*fba
    # fab*fba = (faa-fa)*(fbb-fb) 
    # fab*fba = faa*fbb - (xa*fb*(faa + fab) + cb*fa*(fbb + fba) )
    # fab*fba = faa + fbb - fa*(fbb + fba)
    # fab*fba = faa + fbb - fb*(faa + fab)


#hints

#	if xa -> 0 then faa -> fa 
#	if xa -> 1 then faa -> 1	fa -> f0	fab -> 0
#	
#	
#	
#	