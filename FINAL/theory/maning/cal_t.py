#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt

wa=0.630
wb=0.063
wb=0.13

dc=0.01
ca=np.arange(0,1+dc,dc)
cb=1.0-ca

f0=0.7272

w= ca*wb + cb*wa
wv = ca*wa + cb*wb
M0= 2*f0/(1-f0)

h=0.5*(-2*w + M0*wv + np.sqrt( 8*M0*wa*wb + (2*w - M0*wv)*(2*w - M0*wv) ) )

IA=-2*h*w - h*M0*wb + 2*M0*wa*wb + h*M0*wv + np.sqrt( (2*h*w + h*M0*wb - 2*M0*wa*wb - h*M0*wv)*(2*h*w + h*M0*wb - 2*M0*wa*wb - h*M0*wv) + 4*h*M0*wb*(2*h*wa + 4*w*wa + 2*M0*wa*wb + h*M0*wv) )
IIA= 2*(2*h*wa + 4*w*wa + 2*M0*wa*wb + h*M0*wv)

fa=IA/IIA

IB=-2*h*w - h*M0*wa + 2*M0*wa*wb + h*M0*wv + np.sqrt( (2*h*w + h*M0*wa - 2*M0*wa*wb - h*M0*wv)*(2*h*w + h*M0*wa - 2*M0*wa*wb - h*M0*wv) + 4*h*M0*wa*(2*h*wb + 4*w*wb + 2*M0*wa*wb + h*M0*wv) )
IIB= 2*(2*h*wb + 4*w*wb + 2*M0*wa*wb + h*M0*wv)

fb=IB/IIB

ifaL=np.interp(0.0,ca,fa)
ifbL=np.interp(0.0,ca,fb)

ifaR=np.interp(1.0,ca,fa)
ifbR=np.interp(1.0,ca,fb)

print ifaL,ifaR,ifbL,ifbR


plt.plot(ca,fa,'-.',ca,fb,'-.')
plt.show()

np.savetxt("tr_maning", zip(ca,fa,fb))

