#!/usr/bin/env python

import numpy as np
import sys
plik = sys.argv[1]
name = sys.argv[2]

DATA=np.loadtxt(plik, skiprows=1, unpack=True)
step=DATA[0]
time=DATA[1]

size=0
BAR=[step,time]

for col in DATA[2:]:
    size+=1

for i in range(2,size+1,3):
    e=DATA[i];b=DATA[i+1];n=DATA[i+2];
    bar=b/n
#    ID=np.invert(np.isfinite(bar))
#    bar[ID]=0
    BAR.append(bar)

out2="raw"+name
np.savetxt(out2,np.transpose(BAR), "%f")
