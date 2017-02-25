#!/usr/bin/env python

#import scipy
#import math
import numpy as np
#from scipy import interpolate
import sys
import re

def cal_mean(DATA):
    RESULTS=[];
    print "cal avg ... ", len(DATA)
    for i in range(0,len(DATA)):
	W=[];
	d=DATA[i][mini:maxi:every]
	print len(d),
	new=np.mean(d)
	sig=np.std(d)
	RESULTS.append(new)
#	RESULTS.append(sig)
    return RESULTS



nazwa=sys.argv[3]
pliki = sys.argv[4:]

every=1
fout1 = open(nazwa,"w")

for k in pliki:
    ncol=len(open(k,'r').readline().split())
    print k,ncol

    DATA=np.loadtxt(k, unpack=True, usecols=range(2,ncol))
    print len(DATA)

    if(sys.argv[1]=="half" and len(DATA)>0):
	mini=int(len(DATA[0])/2)
    elif(len(DATA)>0):
	mini=int(sys.argv[1])
    if(sys.argv[2]=="last" and len(DATA)>0):
	maxi=int(2*len(DATA[0])/3)
    elif(len(DATA)>0):
	maxi=int(sys.argv[2])
	
    
    RESULTS=cal_mean(DATA)

    ids = re.findall("[-+]?\d+[\.]?\d*", k) 
    if RESULTS:
	fout1.write("%f" % (float(ids[0])))
	for i in ids[1:]:
	    fout1.write(" %f" % (float(i)))
	for i in RESULTS:
	    fout1.write(" %f" % (i))
	fout1.write("\n")
fout1.close()

