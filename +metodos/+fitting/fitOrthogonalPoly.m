function [coefs, poly] = fitOrthogonalPoly(f, n, options)
    arguments
        f (1,1) sym
        n (1,1) double {mustBeInteger, mustBePositive}
        options.poly {mustBeMember(options.poly, "legendre")} = "legendre"
    end
    % fits: f(x) = coefs(1)*poly(1)(x) + coefs(2)*poly(2)(x) ...
    % in the interval [lower, upper]
    import metodos.fitting.legendrePoly
    import metodos.integration.integrateFunctionComposite

    if strcmp(options.poly, "legendre")
        lower = -1;
        upper = 1;
        poly = legendrePoly(n-1);
        poly_norms = zeros(1, n);
        for i=1:n
            poly_norms(i) = 2/(2*(i) + 1);
        end
    end
    
    intervals = (upper - lower)*4; % so h=.25
    coefs = zeros(1, n);
    for i=1:n
        coefs(i) = (1/poly_norms(i))*integrateFunctionComposite(f*poly(i), lower, upper, "simpson", intervals);
    end
end