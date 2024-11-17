function intx = integrateFunctionRomberg(f, x0, xn, k, order)
    arguments
        f sym
        x0 double
        xn double {mustBeGreaterThan(xn, x0)}
        k double {mustBeInteger, mustBeGreaterThan(k, 0)}
        order double {mustBeInteger, mustBeGreaterThan(order, 0)}
    end

    import metodos.integration.integrateFunctionComposite

    calculated = zeros(k, order); % pairs (k, j)
    for j=1:order
        for k_it=j:k
            if j == 1
                R_kj = integrateFunctionComposite(f, x0, xn, "trapezoidal", 2^(k_it-1));
            else
                R_kj = calculated(k_it, j-1) + (calculated(k_it, j-1) - calculated(k_it-1, j-1))/(4^(j-1) - 1);
            end
            
            calculated(k_it, j) = R_kj;
        end
    end

    intx = calculated(k, j);
end