#!/usr/bin/env python

import cmath
import numpy as np
import matplotlib.pyplot as plt

wa=0.630
wb=0.063


f0=0.7272
M0= 2*f0/(1-f0)


def SIGMA(x,ca,cv):
    c=1-cv
    cb=c-ca
    w= ca*wb + cb*wa
    wv = ca*wa + cb*wb
    delta=wa-wb
    f0=0.7272
    M0= 2*f0/(1-f0)

    a=1.0
    b=-1*( M0*wv + M0*cv*(wa+wb) + 2*w )
    c=2*M0*( ca*cb*delta*delta + cv*(ca*wb*wb + cb*wa*wa) )
    val=( x*x*a + x*b + c )
    return (val,a,b,c)

def faa(x,cb):
    return (1.0 - 2*wa*cb/x)
def fab(x,ca):
    return (2*wb*ca/x)
def fbb(x,ca):
    return (1.0 - 2*wb*ca/x)
def fba(x,cb):
    return (2*wa*cb/x)


def call_coll(ca,cv):
    c=1-cv
    cb=c-ca
    x=np.arange(-10,10,0.01)
    results=SIGMA(x,ca,cv)
    sigma=results[0];a=results[1];b=results[2];c=results[3]
    d=(b**2) - (4*a*c)
    sol1 = (-b-cmath.sqrt(d))/(2*a)
    sol2 = (-b+cmath.sqrt(d))/(2*a)

    print cv,ca
    print a,b,c,d
    print sol1,sol2
    print faa(sol1,cb),fab(sol1,ca),fba(sol1,ca),fbb(sol1,cb)
    print faa(sol2,cb),fab(sol2,ca),fba(sol2,ca),fbb(sol2,cb)
    
    fout1.write("%f %f %f %f %f %f\n" % (cv,ca,faa(sol1,cb),fab(sol1,ca),fba(sol1,ca),fbb(sol1,cb)))
    fout2.write("%f %f %f %f %f %f\n" % (cv,ca,faa(sol2,cb),fab(sol2,ca),fba(sol2,ca),fbb(sol2,cb)))

#    plt.plot(x,sigma,'.-')
#    plt.show()

fout1=open("sol1.coll","w")
fout2=open("sol2.coll","w")

wa=0.630
wb=0.063

cv=0.10
c=1-cv

#def Cv(x):
#    return 0.2*x

def Cv(x):
    if(x < 0.5):
	return 0.0
    elif(x == 0.5):
	return 0.1
    elif(x > 0.5):
	return 0.6
    else:
	return 0.0
#ca=0.5*c
dc=0.05
ca=np.arange(0.1,0.9+dc,dc)
for i in ca:
    call_coll(i,Cv(i))

fout1.close()
fout2.close()
