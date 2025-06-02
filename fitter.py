from scipy.optimize import curve_fit
import numpy as np
from numpy import exp,sqrt,pow

def guinier(q,a,b,bg):
    #Please note that b = R^2 / 3
    return a* exp( - b* q**2 ) + bg

def power_law(q,a,n):
    #Porod law if n=-4
    return a*np.power(q,n)

def fit_guinier_from_file(filein,maxq):
    """
    Fit Guinier law on a I(q) spectrum which is formatted as two tab separated columns 
    which contain :
    q I(q)
    Allows comments after "#"
    """
    qs,iqs=[],[]
    with open(filein,'r') as fin:
        for l in fin.readlines():
            if l.startswith('#'):
                continue
            data = [ float(x) for x in l.strip().split() ]
            if data[0] < maxq :
                qs.append(data[0])
                iqs.append(data[1])
    params,covar=curve_fit(guinier,qs, iqs, p0=[1000,10,10])
    gyr_rad = sqrt(params[1]*3)
    return gyr_rad,params,covar

def fit_guinier_from_file(filein,maxq):
    """
    Fit Guinier law on a I(q) spectrum which is formatted as two tab separated columns 
    which contain :
    q I(q)
    Allows comments after "#"
    """
    qs,iqs=[],[]
    with open(filein,'r') as fin:
        for l in fin.readlines():
            if l.startswith('#'):
                continue
            data = [ float(x) for x in l.strip().split() ]
            if data[0] < maxq :
                qs.append(data[0])
                iqs.append(data[1])
    params,covar=curve_fit(guinier,qs, iqs, p0=[1000,10,10])
    gyr_rad = sqrt(params[1]*3)
    return gyr_rad,params,covar
