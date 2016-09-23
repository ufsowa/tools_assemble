#!/usr/bin/env python

#import scipy
#import math
import numpy as np
from scipy.interpolate import InterpolatedUnivariateSpline
import sys

def get_fits(DATA):
    RESULTS=[]
    x=DATA[0]
    for y in DATA[1:]:
	s = InterpolatedUnivariateSpline(x, y, k=1)
	RESULTS.append(s)
    return RESULTS

dx=float(sys.argv[1])
pliki = sys.argv[2:]


fout1 = "results_raw.dat"
fout2 = open("results_coef.dat","w")
FITS=[];xmin=0;xmax=0;
for k in pliki:
    ncol=len(open(k,'r').readline().split())
    DATA=np.loadtxt(k, unpack=True, usecols=range(0,ncol,1))
    #WAGA=np.loadtxt(k, unpack=True, usecols=range(3,ncol+1,2))
    tmin=np.amin(DATA[0]);tmax=np.amax(DATA[0])
    xmin=min(xmin,tmin); xmax=max(xmax,tmax);
    FITS=FITS+get_fits(DATA)
    print k,ncol,xmin,xmax,len(FITS)

x=np.arange(xmin,xmax+dx,dx)

RAW=[x]
for s in FITS:
    y=s(x)
    RAW.append(y)

np.savetxt(fout1, np.transpose(RAW), fmt="%5.5f" )

COEF=[x]
xb=1.0-x
#tracer
Da= (FITS[0](x))/6.0; Db= (FITS[1](x))/6.0; 
COEF.append(Da);COEF.append(Db)

#intrinsic
#DIa = Da*(faa-fab*xa/xb); Db= (FITS[1](x))/6.0; 
#COEF.append(Da);COEF.append(Db

#manning factor
#S = (fcoll)/(ftracer)
#COEF.append(S);

#thermodynamc factor
#fi = FITS[14](s)
#COEF.append(fi)

#darken
#Dd=xa*DIa*fia + xb*DIb*fib
#COEF.append(Da)

#nerst-plank
#Dnp = Da*Db/(Da+Db)
#COEF.append(Dnp)

np.savetxt(fout2, np.transpose(COEF), fmt="%5.10f" )




