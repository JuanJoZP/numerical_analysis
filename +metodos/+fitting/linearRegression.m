function s = linearRegression(x_mat, y)
    % MULTIVARIATE LINEAR REGRESSION / ORDINARY LEAST SQUARES
    arguments
        x_mat (:, :) double % [x1; x2; ...]
        y (1, :) double
    end
    import metodos.equations.EquationSystem
    import metodos.utils.polynomial

    assert(size(y,2) == size(x_mat,2))
    deegre = size(x_mat,1) + 1;
    n = size(y, 2);

    A = zeros(deegre, deegre);
    b = zeros(deegre, 1);

    x_mat = [ones(1, n); x_mat]; % to generalize construction process
    for i=1:deegre
        b(i) = dot(x_mat(i, :), y);
        for j=1:deegre
            A(i, j) = dot(x_mat(j, :), x_mat(i, :));
        end
    end

    eq = EquationSystem(A,b);
    s.coefs = eq.solve_gauss();
    
    sum_y = dot(y, ones(1, n));
    mean_error = dot(y - sum_y/n, y - sum_y/n); % squared error if estimating with y_mean
    y_bar = 0;
    for i=1:size(s.coefs,2)
        y_bar = y_bar + s.coefs(i).*x_mat(i,:);
    end

    squared_residues = dot(y - y_bar, y - y_bar);
    s.estimation_error = sqrt(squared_residues/(n-2));
    s.r_squared = (mean_error - squared_residues)/mean_error;
end