function x = refinamientoIterativo(A, b, tol)
    import metodos.equations.gaussianElimination

    x = gaussianElimination(A, b);
    r = b - A*x;
    y = gaussianElimination(A, r);
    while norm(y) > tol
        x = x + y;
        r = b - A*x;
        y = gaussianElimination(A, r);
    end
    x = x + y;
end