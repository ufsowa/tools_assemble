#!/usr/bin/env python

#import scipy
#import math
import numpy as np
#from scipy import interpolate
import sys
import re

def cal_avg(DATA,WAGA):
    RESULTS=[];
    print "cal avg ... ", len(DATA), len(WAGA)
    for i in range(0,len(DATA)):
	W=[];
	for j in WAGA[i][mini:maxi:every]:
	    if(j==0):
		j=0.00001
	    W.append(j)
	w=1./np.power(W,2)
	d=DATA[i][mini:maxi:every]
	print len(d),len(w)
	new,sig=np.average(d, weights=w,returned=True)
	sig=np.sqrt(1./sig)
	RESULTS.append(new)
	RESULTS.append(sig)
    return RESULTS



nazwa=sys.argv[3]
pliki = sys.argv[4:]

every=1
fout1 = open(nazwa,"w")

for k in pliki:
    ncol=len(open(k,'r').readline().split())
    print k,ncol

    DATA=np.loadtxt(k, unpack=True, usecols=range(2,ncol,2))
    WAGA=np.loadtxt(k, unpack=True, usecols=range(3,ncol+1,2))
    print len(DATA),len(WAGA)

    if(sys.argv[1]=="half"):
	mini=int(2*len(time)/3)
    else:
	mini=int(sys.argv[1])
    if(sys.argv[2]=="last"):
	maxi=-1
    else:
	maxi=int(sys.argv[2])
	
    
    RESULTS=cal_avg(DATA,WAGA)

    stech = re.findall("[-+]?\d+[\.]?\d*", k) 
    if RESULTS:
	fout1.write("%f" % (float(stech[0])))
	for i in RESULTS:
	    fout1.write(" %f" % (i))
	fout1.write("\n")
fout1.close()

