function [w_next, w_next_sup]= calc_w_next(f, h, ti, w_prev) 
    syms y t;
    k1 = double(h * subs(f, [t, y], [ti, w_prev]));
    k2 = double(h * subs(f, [t, y], [ti + h/4, w_prev + (1/4)*k1]));
    k3 = double(h * subs(f, [t, y], [ti + (3*h)/8, w_prev + (3/32)*k1 + (9/32)*k2]));
    k4 = double(h * subs(f, [t, y], [ti + (12*h)/13, w_prev + (1932/2197)*k1 - (7200/2197)*k2 + (7296/2197)*k3]));
    k5 = double(h * subs(f, [t, y], [ti + h, w_prev + (439/216)*k1 - 8*k2 + (3680/513)*k3 - (845/4104)*k4]));
    k6 = double(h * subs(f, [t, y], [ti + (h/2), w_prev - (8/27)*k1 + (2)*k2 - (3544/2565)*k3 + (1859/4104)*k4 - (11/40)*k5]));
    
    w_next = double(w_prev + (25/216)*k1 + (1408/2565)*k3 + (2197/4104)*k4 - (1/5)*k5);
    w_next_sup = double(w_prev + (16/135)*k1 + (6656/12825)*k3 + (28561/56430)*k4 - (9/50)*k5 + (2/55)*k6);
end