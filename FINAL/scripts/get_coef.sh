#!/bin/bash



echo "Coef..."

module load python-numpy
module load python-scipy

stpth=$PWD

./get_coef.py 0.01 "f_tracer.dat" "f_coll.dat" "f_therm.dat"

