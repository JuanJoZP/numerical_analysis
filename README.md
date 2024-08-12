# MATLAB Numerical methods
Complete and exhaustive repository with MATLAB implementation of 50+ numerical methods.
Easy to use programming interface.

## Get Started
To be accessible to MATLAB, the folder `+Algorithms` must be on the MATLAB path. In the MATLAB command window run:
```
addpath('+Algorithms')  
savepath
```
## Root finding
root finding methods are implemented in `+Algorithms/rootFind`. All of them can be used following a similar structure:
```
import Algorithms.rootFind.Bisection
 
syms x;
f1 = x^3 + 4*x^2 -10;
    
bisec = Bisection(-2, 2, 1E-5, f1);
bisec.solve()
```
aqui va el output
