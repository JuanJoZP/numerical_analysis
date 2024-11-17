function A = inverseLU(A)
    [L, U] = factorizacionLU(A);

    % solve Ld = c
    [rows, ~] = size(L);
    
    for n=1:rows
        c = zeros(rows, 1);
        c(n) = 1; 
        d = zeros(rows, 1);
        for i=1:rows
            d(i) = (c(i) - L(i, 1:i-1) * d(1:i-1)) / L(i, i);
        end
    
        x = zeros(rows, 1);
        for i = rows:-1:1
            x(i) = (d(i) - U(i, i+1:rows) * x(i+1:rows)) / U(i, i);
        end
        A(:, n) = x;
    end
end

function [L, U] = factorizacionLU(A)
    arguments
        A (:, :) double
    end
    [rows, columns] = size(A);
    assert(rows==columns);

    U = A;
    L = eye(rows);  
    for k = 1:rows-1
        for i = k+1:rows
            L(i, k) = U(i, k) / U(k, k); 
            U(i, k:rows) = U(i, k:rows) - L(i, k) * U(k, k:rows); 
        end
    end
end