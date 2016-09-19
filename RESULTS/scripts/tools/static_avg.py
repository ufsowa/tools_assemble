#!/usr/bin/env python

#import scipy
#import math
import numpy as np
#from scipy import interpolate
import sys

nazwa=sys.argv[4]
fout = open(nazwa,"a")

def cal_mean(mini,maxi,data,fname,k):
    TMP=[]
    ind = (data[0] >= mini) & (data[0] < maxi)
    for i in data:
	new=i[ind]
	TMP.append(new)
    RESULTS=[]
    for i in TMP:
	if not i.size:
	    RESULTS=[]
	    break;
	finite=i[np.isfinite(i)]
	new=np.mean(finite)
	RESULTS.append(new)
#    print mini,maxi,fname,k, len(RESULTS)
    if RESULTS:
	fout1 = open(fname,"a")
	fout1.write("%s" % (k))
	for i in RESULTS:
	    fout1.write(" %f" % (i))
	fout1.write("\n")
	fout1.close()
    return len(RESULTS)

def total_mean(DATA):
    if(len(DATA)==0):
	print "no data in the bin";exit(1);
    nr_row=DATA[0].size
    if(nr_row>1):
	#do nothing if only one row in the bin
	#col=len(DATA)
	#DATA=np.reshape(DATA,(col,1))
	RESULTS=[]; 
	for i in range(0,len(DATA)):
	    d=DATA[i]
	    finite=d[np.isfinite(d)]
	    new=np.nanmean(finite)
	    sig=np.nanstd(finite)
	    RESULTS.append(new)
	    RESULTS.append(sig)
	fout.write("%f" % (RESULTS[0]))
	for i in RESULTS[1:]:
	    fout.write(" %f" % (i))
	fout.write("\n")

MAX=-1;BIN=-1;
BEG=-1;LAST=-1;

pliki = sys.argv[5:]
biny=[]
ncol=0


for k in pliki:
    lenght=len(open(k,'r').readline().split())
    DATA=[]
    if(lenght==10):
	step,time,r2a,r2b,fa,fb,na1,na2,nb1,nb2=np.loadtxt(k, unpack=True )
	Da=r2a/time
	Db=r2b/time
	Na1=na1/time
	Na2=na2/time
	Nb1=nb1/time
	Nb2=nb2/time
	DATA=[step,time,Da,Db,fa,fb,Na1,Na2,Nb1,Nb2]
    elif(lenght==6):
    	step,time,Da,Db,fa,fb=np.loadtxt(k, unpack=True )
    	DATA=[step,time,Da,Db,fa,fb]
    else:
	print "wrong data format in file"
	sys.exit();

    if(sys.argv[1]=="loop"):
	MAX=int(sys.argv[2])
	BIN=float(sys.argv[3])
    elif(sys.argv[1]=="avg"):
	if(sys.argv[2]=="half"):
	    ind=int(2*len(step)/3)
	    BEG=step[ind]
	else:
	    BEG=float(sys.argv[2])
	if(sys.argv[3]=="last"):
	    LAST=step[-1]
	else:
	    LAST=float(sys.argv[2])
    else:
	print "wrong option"; exit(1);

    if(MAX>0):							#loop
	for i in range(0,MAX):
	    mini=i*BIN
	    maxi=i*BIN+BIN
	    fname=str(i)+".bin"
	    if fname not in biny:
		biny.append(fname)
	    tmp_col=cal_mean(mini,maxi,DATA,fname,k)
	    if(tmp_col > ncol):
		ncol=tmp_col

    if(BEG>0):							#avg
	    fname="static.avg"
	    tmp_col=cal_mean(BEG,LAST,DATA,fname,k)
	    if(tmp_col > ncol):
		ncol=tmp_col

if(MAX>0):
    for fname in biny:
	DATA=np.loadtxt(fname, usecols=range(1,ncol+1), unpack=True)
	total_mean(DATA)
if(BEG>0):
    DATA=np.loadtxt("static.avg", usecols=range(1,ncol+1), unpack=True )
    total_mean(DATA)
fout.close()

print sys.argv[:4]
