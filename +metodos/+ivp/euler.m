function w = euler(f, a, b, initial, n)
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
        w(i) = w(i-1) + h*subs(f, [y, t], [w(i-1), a + h*(i-2)]);
    end

    w = w(1:end)';
end



