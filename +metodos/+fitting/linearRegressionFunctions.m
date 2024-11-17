function coefs = linearRegressionFunctions(f_ind, f_dep, lower, upper)
    % LEAST SQUARES WITH FUNCTIONS
    arguments
        f_ind (1, :) sym % independent functions used to aprox f_dep
        f_dep sym 
        lower (1,1) double 
        upper (1,1) double
    end
    % aprox: f_dep(x) = a0 + a1*f_ind(1)(x) + a2*f_ind(2)(x) ...
    % in the interval [lower, upper]
    import metodos.equations.pivoteoEscalado
    import metodos.integration.integrateFunctionComposite
    import metodos.utils.polynomial

    intervals = (upper-lower)*4; % so h=0.25
    n = length(f_ind) + 1; % + constant coef
    A = zeros(n, n);
    b = zeros(n, 1);

    f_ind = [1, f_ind]; % add constant
    for i=1:n
        b(i) = integrateFunctionComposite(f_dep*f_ind(i), lower, upper, "simpson", intervals);
        for j=1:n
            A(i, j) = integrateFunctionComposite(f_ind(i)*f_ind(j), lower, upper, "simpson", intervals);
        end
    end

    coefs = pivoteoEscalado(A, b);
end