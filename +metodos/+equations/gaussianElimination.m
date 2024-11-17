function x = gaussianElimination(A, b)
    if length(b) ~= size(A, 1)
        error("b length must be equal to rows of A")
    end
    if size(A, 1) ~= size(A,2) 
        error("A must be a square matrix")
    end

    [rows, columns] = size(A);
    % forma escalonada
    for i=1:(rows-1)
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