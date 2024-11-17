function y = polynomial(x, coefs)
    arguments
        x (1, :) double
        coefs (1, :) double
    end
    % computes y = coefs(1) + coefs(2)*x + coefs(3)*x^2 ...
    y = zeros(1, size(x, 2));
    for i=1:size(coefs,2)
        y = y+coefs(i)*x.^(i-1);
    end
end