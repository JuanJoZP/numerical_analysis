function [w, dom] = rungeKuttaFehlberg(f, a, b, initial, tolerance, h_initial)
    arguments
        f sym
        a double
        b double {mustBeGreaterThan(b, a)}
        initial double
        tolerance double
        h_initial double
    end

    import metodos.ivp.calc_w_next

    h_max = 0.25;
    h_min = 0.01;
    h = h_initial;
    i = a;
    w = [];
    w(1) = initial;
    dom(1) = a;
    index = 2;
    i_prev = i;
    i = i+h;
    while i ~= b
        [w_next, w_next_sup] = calc_w_next(f, double(h), double(i_prev), double(w(index-1)));
        R = double(abs(w_next - w_next_sup));
        q = double(0.84 * (tolerance/R)^(1/4));
        if h*q >= h_max
            h = h_max;
        elseif h*q <= h_min
            h = h_min;
        else
            h = double(h*q);
        end

        if R <= tolerance
            if i+h < b
                i_prev = i;
                i = double(i+h);
            else
                i_prev = i;
                i = b;
            end
            w(index) = w_next;
            dom(index) = i;
            index = index + 1;
        end
    end
end
