function intx = integrateFunctionRombergIterative(f, x0, xn, tol, maxIter)
    h = (xn - x0);
    R = zeros(maxIter, maxIter);
    
    R(1, 1) = (h/2) * (f(x0) + f(xn));
    
    for j = 2:maxIter
        h = h / 2;  
        sumTerm = 0;
        for i = 1:2^(j-2)
            sumTerm = sumTerm + f(x0 + (2*i - 1) * h);
        end
        
        R(j, 1) = 0.5 * R(j-1, 1) + sumTerm * h;
        
        for k = 2:j
            R(j, k) = R(j, k-1) + (R(j, k-1) - R(j-1, k-1)) / (4^(k-1) - 1);
        end
        
        if abs(R(j, j) - R(j-1, j-1)) < tol
            intx = R(j, j);
            return;
        end
    end
    
    intx = R(maxIter, maxIter);
    warning('No se alcanzó la tolerancia dentro del número máximo de iteraciones');
end