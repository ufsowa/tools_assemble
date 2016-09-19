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

main_s,time,vx,vy,vz,v0,v1,v2,ax,ay,az,a0,a1,a2,bx,by,bz,b0,b1,b2,NV,NA,NB=np.loadtxt(plik, skiprows=1, unpack=True)

step=v0/NV

NN=np.sqrt(3.0)	#kwadrat dlugosci skoku w NN
NNN=np.sqrt(4.0)	#kwadrat dlugosci skoku w NNN

na = (a1*NN*NN + a2*NNN*NNN)
nb = (b1*NN*NN + b2*NNN*NNN)

faa = (ax*ax + ay*ay + az*az)/na
fbb = (bx*bx + by*by + bz*bz)/nb
fab = (ax*bx + ay*by + az*bz)/na
fba = (bx*ax + by*ay + bz*az)/nb

#print len(faa),len(fab),len(fba),len(fbb)
out2="raw"+name
np.savetxt(out2,zip(step,time,faa,fab,fba,fbb), "%f")


#end=len(faa)
#dt=0; deltaT=0;dT=0; T=0; Saa=0;Sbb=0;Sab=0;Sba=0;counter=0; numerl=0

#for i in np.arange(1,end,1):
#    if deltaT<= delta:
#     dt=time[i]-time[i-1]
#     deltaT=deltaT+dt
#     Saa=Saa+dt*(faa[i]+faa[i-1])/2;
#     Sbb=Sbb+dt*(fbb[i]+fbb[i-1])/2;
#     Sab=Sab+dt*(fab[i]+fab[i-1])/2;
#     Sba=Sba+dt*(fba[i]+fba[i-1])/2;
#    else:
#     dT=dT+deltaT
#     T=T+delta
#     counter=counter+dc
#     delta=delta+counter*mc
#     file_out.write('%10.5f %10.5f %10.5f %10.5f %10.5f\n' % (T,Saa/deltaT,Sab/deltaT,Sba/deltaT,Sbb/deltaT))
#     print time[i],T,dT,deltaT,delta
#     numerl=numerl+1
#     deltaT=0
#     Saa=0
#     Sab=0
#     Sba=0
#     Sbb=0

#print numerl

#file_out.close()