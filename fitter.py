from scipy.optimize import curve_fit
import numpy as np
from numpy import exp,sqrt,pow

def guinier(q,a,b,bg):
    #Please note that b = R^2 / 3
    return a* exp( - b* q**2 ) + bg

def porod(q,a,n,c):
    return a*pow(n) + c

filein=input("What is the data file?  ")

qs,iqs=[],[]
with open(filein,'r') as fin:
    for l in fin.readlines():
        data = [ float(x) for x in l.strip().split() ]
        if data[0] < 0.5 :
            qs.append(data[0])
            iqs.append(data[1])

params,covar=curve_fit(guinier,qs, iqs, p0=[1000,10,10])
print(params)
gyr_rad = sqrt(params[1]*3)
print("Gyradion radius:", gyr_rad)
