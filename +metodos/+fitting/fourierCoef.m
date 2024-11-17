function [a0, an, bn] = fourierCoef(f, t, n)
    arguments
        f (1,1) sym
        t (1,1) double {mustBePositive}
        n (1,1) double {mustBeInteger, mustBePositive}
    end
    % f so that f(x) = f(x + t) 
    import metodos.integration.integrateFunctionComposite
    
    l = t/2;
    w = (2*pi)/t;
    a0 = (1/l)*integrateFunctionComposite(f, 0, t, "simpson3_8", t*6);
    
    an = zeros(1, n);
    bn = zeros(1, n);
    syms x
    for i=1:n
        an(i) = (1/l)*integrateFunctionComposite(f*cos(i*w*x), 0, t, "simpson3_8", t*6);
        bn(i) = (1/l)*integrateFunctionComposite(f*sin(i*w*x), 0, t, "simpson3_8", t*6);
    end
end