function poly = legendrePoly(k)
    % generate k+1 legendre orthogonal polynomials
    arguments
        k (1,1) double {mustBeInteger, mustBeNonnegative}
    end

    poly = cell(1, k+3);
    poly(1) = {sym(0)};
    poly(2) = {sym(1)};
    syms x
    for i=3:k+3
        k_iter = sym(i-3);
        poly(i) = {((2*k_iter+1)*x*poly(i-1) - k_iter*poly(i-2))/(k_iter+1)};
    end

    poly = poly(3:end);
end