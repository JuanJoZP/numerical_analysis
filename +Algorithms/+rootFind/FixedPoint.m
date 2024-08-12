function [root] = iteracion_punto_fijo(a, b, tol, f, g, gppsol)
    % existe raiz en [a, b]
    fa = double(subs(f, a));
    fb = double(subs(f, b));
    if (fa > 0) && (fb > 0)
       error("No hay solucion en el intervalo")
    end
    if (fa < 0) && (fb < 0)
        disp("No hay solucion en el intervalo")
    end

    % |g(x)| < 1 para x en [a, b]
    gp = diff(g);
    %gpp = diff(gp);
    % por ahora ingresamos manual la solucion de gpp == 0
    extremes = [double(subs(gp, a)) double(subs(gp, b)) double(subs(gp, gppsol))];
    for val=extremes
        if abs(val) >= 1
            error("Error: |g(x)| < 1. El metodo no converge")
        end
    end

    root = (a+b)/2; % eleccion inicial
    err = 1E6;
    while err > tol
        prev = root;
        root = subs(g, prev);
        err = abs((root - prev)/root);
    end

    root = double(root);
end