# MATLAB Numerical methods
Repository with MATLAB implementation of a large number of numerical methods.

## Get Started
To be accessible to MATLAB, the folder `+methods` must be on the MATLAB path. In the MATLAB command window run:
```
addpath('+methods')  
savepath
```
## Root finding
root finding methods are implemented in `+methods/rootFind`. All of them inherit from the same class and can be used following the same structure:
```
import Algorithms.rootFind.Bisection
 
syms x;
f1 = x^3 + 4*x^2 -10;
    
bisec = Bisection(-2, 2, 1E-5, f1);
bisec.solve()
```
aqui va el output
