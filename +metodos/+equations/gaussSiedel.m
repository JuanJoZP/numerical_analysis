function x = gaussSiedel(A, b, tolerance, options)
    arguments
        A
        b
        tolerance double
        options.initial = zeros(length(b), 1)
    end
    import metodos.equations.inverseLU

    n = length(b);
    U = zeros(n, n);
    L = zeros(n, n);
    D = zeros(n, n);

    for i=1:n
        for j=1:n
            if i>j
                L(i,j) = -A(i,j);
            elseif i<j
                U(i,j) = -A(i,j);
            else
                D(i,j) = A(i,j);
            end
        end
    end 
    
    x = options.initial;
    T = inverseLU(D-L)*U;
    c = inverseLU(D-L)*b';
    x_prev = x;
    x = T*x + c;

    while norm(x-x_prev) >= tolerance
        x_prev = x;
        x = T*x + c;
    end
end