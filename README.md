# saxyz.jl
A Small Angle X-Ray Scattering (SAXS) calculator from coordinate files such as XYZ in Julia.

<div align="center">
<img src="https://github.com/user-attachments/assets/256df5a0-6134-4ec2-ac09-8d89f41757c6" width="60%">
</div>

## Introduction
This Julia package is built to compute the X-ray scattering response of atomic clusters at small angles (SAXS). To do so, the Debye formula is utilized:

$$  I(q) = \sum_i^N \sum_j^N f_i(q,E) f_j^*(q,E) \frac{\text{sin}(q r_{ij})}{q r_{ij}} $$ 

where f are atomic form factors, q is the magnitude of transferred momentum and $r_{ij}$ is the distance of atom $i$ to atom $j$. 

Functions to parse xyz/extxyz files are provided, yet at its core the code only requires atomic coordinates and the corresponding chemical species - you can use any other code to obtain them and feed those to the desired functions.

## Model

The atomic form factors can be written as:

$$ f(q,E) = f(q) + f_1(E) + if_2(E) $$

They contain :
1. A part dependent on transferred momentum q , deriving from Thomson scattering
2. A part dependent on the energy of the incoming X-ray , or _resonant_ part

The momentum dependent contribution is written using the Cromer-Mann parametrization:

$$ f(q) = \sum_{i=1}^{4} a_i \exp\left(-b_i \left( \frac{q}{4\pi} \right)^2 \right) + c $$

Where the a,b and c are empirical parameters.

## Installation

saxyz.jl is now packaged as a Julia package. You can now run it by:

```Julia
using Pkg
Pkg.activate("PATH/TO/SAXYZ-JL/saxyz.jl")
```
To import the calcolator as a regular package, you have to include the saxyz.jl folder to the 
JULIA_LOAD_PATH environment variable.

```bash
export JULIA_LOAD_PATH="/PATH/TO/saxyz.jl:$JULIA_LOAD_PATH"
```
Then, in Julia scripts run

```Julia
using saxyz
```

## Fitting utilities

A python library to fit spectra is provided including Porod's and Guinier's laws.

## License

This code is released under an MIT license. 
Please acknowledge nanoMLMS @ University of Milan if you use this code in your work.

## Notes

Units used are : KeV for energies , Angstrom for distances , Angstrom <sup>-1</sup> for momenta. 

## References
