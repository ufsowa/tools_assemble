#!/usr/bin/env python

import numpy as np
import sys
plik = sys.argv[1]
name = sys.argv[2]

DATA=np.loadtxt(plik, skiprows=1, unpack=True)
step=DATA[0]
time=DATA[1]

size=0
BAR_s=[step,time]
FREQ=[step,time]

DATA_SUM=[step,time];
for col in DATA[2:]:
    tmp=0.0;new_col=[]
    for row in col:
	tmp=tmp+row;
	new_col.append(tmp)
    DATA_SUM.append(new_col)

DATA_SUM=np.array(DATA_SUM)


for col in DATA_SUM[2:]:
    size+=1

for i in range(2,size+1,3):
    e=DATA_SUM[i];b=DATA_SUM[i+1];n=DATA_SUM[i+2];
    j=n/time
    FREQ.append(j)

#    bar=b/n
#    BAR_s.append(bar)


out2="raw"+name
np.savetxt(out2,np.transpose(FREQ), "%f")

#out2="rawb"+name
#np.savetxt(out2,np.transpose(BAR_s), "%f")
