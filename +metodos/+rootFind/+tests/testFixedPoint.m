clear all; close all; clc;
import algorithms.find_root.iteracion_punto_fijo
a = 1;
b = 2;
tol = 1E-5;

syms x;
f = exp(x) - 4 + x;
g1 = 4 - exp(x); % no converge
g2 = exp(x) - 4 + 2*x; % no converge
g3 = log(4 - x); % converge

% en gppsol debe ir la raiz de gpp = 0
iteracion_punto_fijo(a, b, tol, f, g3, a) 