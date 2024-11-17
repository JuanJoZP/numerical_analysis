function w = rungeKutta(f, a, b, initial, n)
    arguments
        f sym
        a double
        b double {mustBeGreaterThan(b, a)}
        initial double
        n double
    end

    syms y t;

    h = (b-a)/(n);
    w = zeros(n+1, 1);
    w(1) = initial;
    for i=2:n+1
        t_i = a + h*(i-2);
        k1 = h * double(subs(f, [y, t], [w(i-1), t_i]));
        k2 = h * double(subs(f, [y, t], [w(i-1) + (k1/2), t_i + (h/2)]));
        k3 = h * double(subs(f, [y, t], [w(i-1) + (k2/2), t_i + (h/2)]));
        k4 = h * double(subs(f, [y, t], [w(i-1) + k3, t_i + h]));
        w(i) = w(i-1) + (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    end

    w = w(1:end)';
end
