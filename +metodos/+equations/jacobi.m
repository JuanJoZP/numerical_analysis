function x = jacobi(A, b, tolerance, options)
    arguments
        A
        b
        tolerance double
        options.initial = zeros(length(b), 1)
    end
    n = length(b);
    U = zeros(n, n);
    L = zeros(n, n);
    D_inv = zeros(n, n);

    for i=1:n
        for j=1:n
            if i>j
                L(i,j) = -A(i,j);
            elseif i<j
                U(i,j) = -A(i,j);
            else
                D_inv(i,j) = 1/A(i,j);
            end
        end
    end 
    
    x = options.initial;
    T = D_inv*(L+U);
    c = D_inv*b';
    x_prev = x;
    x = T*x + c;

    while norm(x-x_prev) >= tolerance
        x_prev = x;
        x = T*x + c;
    end
end