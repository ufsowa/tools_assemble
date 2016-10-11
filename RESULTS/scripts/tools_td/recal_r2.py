#!/usr/bin/env python

import numpy as np
import sys
plik = sys.argv[1]
name = sys.argv[2]

#out1="int"+name
#file_out=open(out1,'w')

#print sys.argv[0]

#delta=int(sys.argv[3])
#dc=1
#mc=0

NN=np.sqrt(3.0)	#kwadrat dlugosci skoku w NN
NNN=np.sqrt(4.0)	#kwadrat dlugosci skoku w NNN


main_s,time,vx,vy,vz,NV,ax,ay,az,NA,bx,by,bz,NB,v1,v2,a1,a2,b1,b2=np.loadtxt(plik, skiprows=1, unpack=True)

step=(v1+v2)/NV
#na = (a1 + a2)/NA
#nb = (b1 + b2)/NB
ja = (a1*NN*NN + a2*NNN*NNN)/NA
jb = (b1*NN*NN + b2*NNN*NNN)/NB
Ra=(ax+ay+az)/NA
Rb=(bx+by+bz)/NB
fa=Ra/ja
fb=Rb/jb
Da=Ra/time
Db=Rb/time
a1=a1/NA
a2=a2/NA
b1=b1/NB
b2=b2/NB

out2="raw"+name
np.savetxt(out2,zip(step,time,Ra,Rb,fa,fb,a1,a2,b1,b2), "%f")


#end=len(Ra);dt=0; deltaT=0;T=0;Sna1=0;Sna2=0;Snb1=0;Snb2=0;Sra=0;Srb=0;Sfa=0;Sfb=0;counter=0;numerl=0;

#for i in np.arange(1,end,1):
#    if deltaT<= delta:
#     dt=time[i]-time[i-1]
#     deltaT=deltaT+dt
#     Sna1=Sna1+dt*(a1[i]+a1[i-1])/2;
#     Sna2=Sna2+dt*(a2[i]+a2[i-1])/2;
#     Snb1=Snb1+dt*(b1[i]+b1[i-1])/2;
#     Snb2=Snb2+dt*(b2[i]+b2[i-1])/2;
#     Sra=Sra+dt*(Da[i]+Da[i-1])/2;
#     Srb=Srb+dt*(Db[i]+Db[i-1])/2;
#     Sfa=Sfa+dt*(fa[i]+fa[i-1])/2;
#     Sfb=Sfb+dt*(fb[i]+fb[i-1])/2;
#    else:
#     T=T+delta
#     counter=counter+dc
#     delta=delta+counter*mc
#     file_out.write('%10.5f %10.5f %10.5f %10.5f %10.5f %10.5f %10.5f %10.5f %10.5f\n' % (T,Sra/deltaT,Srb/deltaT,Sfa/deltaT,Sfb/deltaT,Sna1/deltaT,Sna2/deltaT,Snb1/deltaT,Snb2/deltaT))
#     numerl=numerl+1
#     deltaT=0
#     Sna1=0
#     Snb1=0
#     Sna2=0
#     Snb2=0
#     Sra=0
#     Srb=0
#     Sfa=0
#     Sfb=0

#print numerl
