function [root] = newton_raphson(a, b, tol, f, initial_guess)
    % existe raiz en [a, b]
    fa = double(subs(f, a));
    fb = double(subs(f, b));
    if ((fa > 0) && (fb > 0)) || ((fa < 0) && (fb < 0))
       error("No hay solucion en el intervalo")
    end
    
    fp = diff(f);
    root = initial_guess;
    err = 1E10;
    while err > tol
        prev = root;
        root = root - double(subs(f, root))/double(subs(fp, root));
        err = abs((prev - root)/root);
    end
end