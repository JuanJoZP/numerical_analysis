clear all; close all; clc;
import algorithms.find_root.newton_raphson

a = -10;
b = 10;
tol = 1E-5;

syms x;
f1 = x^5 -2*x^3 - log(x);
guess1 = 1;
sol1 = newton_raphson(a, b, tol, f1, guess1)

f2 = exp(x)*cos(x)- x^2 + 3*x;
guess2 = 2;
sol2 =  newton_raphson(a, b, tol, f2, guess2)

