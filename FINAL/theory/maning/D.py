#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt

#ca,faa,fab,fba,fbb=np.loadtxt("cf.dat", usecols=(0,2,4,6,8),unpack=True)
ca,faa,fab,fba,fbb=np.loadtxt("col_maning", unpack=True)

cb=1.0-ca
fIa=faa - fab*ca/cb
fIb=fbb - fba*cb/ca

#ca,Fa,Fb=np.loadtxt("F.dat", usecols=(0,1,2),unpack=True)
#ca,wa,wb=np.loadtxt("freq.dat", usecols=(0,1,2),unpack=True)
wa=0.630*np.ones_like(ca)
wb=0.13*np.ones_like(ca)
Fa=Fb=1.0*np.ones_like(ca)

a2=3.0
D0a=wa*a2/6.0
D0b=wb*a2/6.0

DIa=fIa*Fa*D0a
DIb=fIb*Fb*D0b

D=cb*DIa + ca*DIb

np.savetxt("D_maning",zip(ca,cb,D,fIa,fIb,DIa,DIb,wa,wb,Fa,Fb),fmt='%.6f',newline='\n')

plt.plot(ca,fIa,'.',ca,fIb,'-')
plt.show()

plt.plot(ca,DIa,label = 'DIa')
plt.plot(ca,DIb,label = 'DIb')
plt.plot(ca,D,label = 'D')
plt.legend()
plt.show()
