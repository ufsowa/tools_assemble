#!/usr/bin/env python

import numpy as np
import sys
plik = sys.argv[1]
name = sys.argv[2]


step,time,v1,v2,a1,a2,b1,b2=np.loadtxt(plik, skiprows=1, unpack=True)

na = (a1 - a2)/(a1+a2)
nb = (b2 - b1)/(b1+b2)
nv = (v1 - v2)/(v1+v2)

#ID=np.invert(np.isfinite(na)); na[ID]=0;
#ID=np.invert(np.isfinite(nb)); nb[ID]=0;
#ID=np.invert(np.isfinite(nv)); nv[ID]=0;

out2="raw"+name
np.savetxt(out2,zip(step,time,nv,na,nb,v1,v2,a1,a2,b1,b2), "%f")
