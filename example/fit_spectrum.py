import sys,os

parent_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.insert(0, parent_dir)

import fitter

gyr,params,_=fitter.fit_guinier_from_file("output.dat",0.5)
print(f"Gyr radius is {gyr:5.3f} Angstrom")
print("Fit parameters",params)
