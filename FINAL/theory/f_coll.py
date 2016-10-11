#!/usr/bin/env python

import cmath
import numpy as np
import matplotlib.pyplot as plt


DATA=np.loadtxt("f_tracer.dat",unpack=True)

wa=DATA[9]
wb=DATA[13]
ca=DATA[0]
cb=1.0-ca

Faa=DATA[1]
Fbb=DATA[7]


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
    return (a,b,c)

def faa(x,cb):
    return (1.0 - 2*wa*cb/x)
def fab(x,ca):
    return (2*wb*ca/x)
def fbb(x,ca):
    return (1.0 - 2*wb*ca/x)
def fba(x,cb):
    return (2*wa*cb/x)

def f(x,a,b,c):
    return ( x*x*a + x*b + c )



def call_coll(ca,cv):
    c=1-cv
    cb=c-ca
    x=np.arange(-10,10,0.01)
    results=SIGMA(x,ca,cv)
    a=results[0];b=results[1];c=results[2]
    d=(b**2) - (4*a*c)
    sol1 = (-b-np.sqrt(d))/(2*a)
    sol2 = (-b+np.sqrt(d))/(2*a)
    print cv,ca
    print a,b,c,d
    print sol1,sol2
    print faa(sol1,cb),fab(sol1,ca),fba(sol1,ca),fbb(sol1,cb)
    print faa(sol2,cb),fab(sol2,ca),fba(sol2,ca),fbb(sol2,cb)
    
    np.savetxt("sol1.coll", zip(ca,faa(sol1,cb),fab(sol1,ca),fba(sol1,ca),fbb(sol1,cb)))
    np.savetxt("sol2.coll", zip(ca,faa(sol2,cb),fab(sol2,ca),fba(sol2,ca),fbb(sol2,cb)))

#    plt.plot(x,sigma,'.-')
#    plt.show()




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


#wa=0.630
#wb=0.063
#dc=0.01

cv=0.01
#cv=np.arange(0.01,0.5+dc,dc)
#cv=np.arange(0.01,0.5+dc,dc)
#for i in cv:
#    c=1-i
#    ca=0.5*c
call_coll(ca,cv)
