#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt

X=[];Y1=[];Y2=[];
def tf2cf(x,wa,wb,fa,fb):
    f0=0.72725
#    X.append(x);
    m=x*wa*fa + (1.0-x)*wb*fb;
    l=x*wa*fa
    faa = fa*(1.0 + ((1.0-f0)/f0) * ( l/m ))
#    y=fa*(1.0 + ((1.0 - f0)/f0))
#    Y1.append(m);
    l=(1.0-x)*wb*fb
    fbb = fb*(1.0 + ((1.0-f0)/f0) * ( l/m ))
#   y=fb*(1.0 + ((1.0 - f0)/f0))
#   Y2.append(fbb);
    fab = ((1.0-f0)/f0) * ( ( (1.0-x)*wb*fa*fb )/(x*wa*fa + (1.0-x)*wb*fb) )
    fba = ((1.0-f0)/f0) * ( ( x*wa*fa*fb )/(x*wa*fa + (1.0-x)*wb*fb) )
    return faa,fab,fba,fbb

fin=open("tr_maning","r")
fout=open("col_maning","w")

wa=0.63; wb=0.063; wb=0.13
X=[];AA=[];BB=[];AB=[];BA=[];
for line in fin:
    x,fa,fb=line.split()
    faa,fab,fba,fbb=tf2cf(float(x),wa,wb,float(fa),float(fb))
    X.append(x)
    AA.append(faa)
    BB.append(fbb)
    AB.append(fab)
    BA.append(fba)
    fout.write("%f %f %f %f %f\n" % (float(x),faa,fab,fba,fbb))

#foutw=open("freq.dat","w")
#foutw.write("%f %f" % (wa,wb))

plt.plot(X,AA,'.',X,BB,'-',X,AB,'.',X,BA,'-')
plt.show()


