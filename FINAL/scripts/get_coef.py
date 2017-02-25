#!/usr/bin/env python

#import scipy
#import math
import numpy as np
from scipy.interpolate import InterpolatedUnivariateSpline
import sys

#structure
f=0.7272

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
FITS=[];xmin=1.0;xmax=0;
for k in pliki:
    ncol=len(open(k,'r').readline().split())
    DATA=np.loadtxt(k, unpack=True, usecols=range(1,ncol,1))
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
title="xa "
#definition^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#tracer
Da= (FITS[0](x))/6.0; Db= (FITS[1](x))/6.0; 
COEF.append(Da);COEF.append(Db)
title += "Da Db "

#thermodynamc factor
fia = FITS[12](x); fib = FITS[13](x);
COEF.append(fia);COEF.append(fib)
title += "fia fib | "

#partial manning factor
ra = (FITS[8](x) - (x/xb)*FITS[9](x))/(FITS[2](x))				#ra = (faa - fab*x/xb)/fa
rb = (FITS[11](x) - (xb/x)*FITS[10](x))/(FITS[3](x))				#rb = (fbb - fba*xb/x)/fb
COEF.append(ra);COEF.append(rb);
title += "ra rb "

#intrinsic
DIa = Da*ra*fia; DIb = Db*rb*fib;
COEF.append(DIa);COEF.append(DIb);
title += "DIa DIb "

#darken
Dd=x*DIb + xb*DIa
COEF.append(Dd)
title += "Dd "

#total manning factor		S=D/Ddarken
S = Dd/(x*Db*fib + xb*Da*fia)
COEF.append(S);
title += "S "

#nernst-planck model^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^short time

#intrinsic
DIa_np = ( Da*Db/(Da+Db) )*fia; DIb_np = ( Da*Db/(Da+Db) )*fib;
COEF.append(DIa_np);COEF.append(DIb_np);
title += "DIa_np DIb_np "

#interdiffusion
D_np = xb*DIa_np + x*DIb_np
COEF.append(D_np)
title += "Dd_np "

np.savetxt("results_coef.dat", np.transpose(COEF), fmt="%5.10f", header=title )

#random model^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
COEF=[x]; title="xa "
ra_r = 1.0 + ( (1.0-f)/f )*(x*(Da-Db)/(x*Da+xb*Db))		#if Da > Db then 1.0 < ra < 1/f; 0.0 < 1.0
rb_r = 1.0 + ( (1.0-f)/f )*(x*(Db-Da)/(x*Da+xb*Db))
S_r = 1.0 + ( (1.0-f)/f )*( x*xb*(Da-Db)*(Da-Db)/( (x*Da+xb*Db)*(x*Db+xb*Da)) )		#if Da > Db then 1.0 < S < 1/f
DIa_r = Da*ra_r*fia; DIb_r = Db*rb_r*fib;
Dd_r=x*DIb_r + xb*DIa_r
COEF.append(Da);COEF.append(Db)
COEF.append(fia);COEF.append(fib)
COEF.append(ra_r); COEF.append(rb_r);COEF.append(DIa_r); COEF.append(DIb_r); COEF.append(Dd_r); COEF.append(S_r);
COEF.append(DIa_np);COEF.append(DIb_np);
COEF.append(D_np)
title += "x Da Db fia fib ra_r rb_r DIa_r DIb_r Dd_r S_r DIa_np DIb_np D_np"

np.savetxt("results_rnd.dat", np.transpose(COEF), fmt="%5.10f", header=title )




