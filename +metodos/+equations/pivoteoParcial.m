function x = pivoteoParcial(A, b)
    if length(b) ~= size(A, 1)
        error("b length must be equal to rows of A")
    end
    if size(A, 1) ~= size(A,2) 
        error("A must be a square matrix")
    end

    [rows, columns] = size(A);
    % forma escalonada
    for i=1:(rows-1)
        pivot = get_pivot(A, i);
        [A, b] = swap_rows(A, b, i, pivot);
        for j=i+1:columns
            multiply = (A(j, i)/A(i, i));
            A(j, :) = A(j, :) - A(i, :)*multiply; 
            b(j) = b(j) - b(i)*multiply;
        end
    end

    % sustitucion hacia atras
    x = zeros(1, rows);
    for i=length(b):-1:1
        x(i) = b(i);
        for j=length(b):-1:i+1
            x(i) = x(i) - A(i,j)*x(j);
        end
        x(i) = x(i)/A(i,i);
    end
    x = x';
end

function pivot = get_pivot(A, k)
    max = 0;
    pivot = k; 
    for i=k:size(A, 1)
        if abs(A(i, k)) > max
            max = abs(A(i,k));
            pivot = i;
        end
    end
end

function [A, b] = swap_rows(A, b, i, j) 
    if i == j
        return
    end
    temp_A = A(i, :);
    temp_b = b(i);

    A(i, :) = A(j, :);
    b(i) = b(j);

    A(j, :) = temp_A;
    b(j) = temp_b;
end