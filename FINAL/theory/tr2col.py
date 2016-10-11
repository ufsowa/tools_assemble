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

DATA=np.loadtxt("f_tracer.dat",unpack=True)

wa=DATA[9]
wb=DATA[13]
ca=DATA[0]
fa=DATA[5]
fb=DATA[7]

faa,fab,fba,fbb=tf2cf(ca,wa,wb,fa,fb)

np.savetxt("f_coll.fromtf", zip(ca,faa,fab,fba,fbb))


