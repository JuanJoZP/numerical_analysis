function x_mat = polyFeatures(x, d)
    % returns x_mat with polynomial features until deegre 'd'
    % plug x_mat into linearRegression to perform a polynomial regression
    arguments
        x (1, :) double
        d (1, 1) double
    end
    x_mat = ones(d+1, size(x, 2));
    for i=2:d+1
        x_mat(i, :) = x_mat(i-1, :).*x;
    end
    x_mat = x_mat(2:end, :);
end