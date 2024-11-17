function [sol1, sol2] = twoEquationsRK4(f1, f2, a, b, initial1, initial2, n)
    arguments
        f1 sym
        f2 sym
        a double
        b double {mustBeGreaterThan(b, a)}
        initial1 double
        initial2 double
        n double
    end
    syms y1 y2 x;
    expectedVars = {'x', 'y1', 'y2'};
    f1Vars = symvar(f1);
    f2Vars = symvar(f2);
    assert(all(ismember(f1Vars, expectedVars)), ...
        'f1 must be a function of variables x, y1, and y2 only.');
    assert(all(ismember(f2Vars, expectedVars)), ...
        'f2 must be a function of variables x, y1, and y2 only.');

    
    f1_func = matlabFunction(f1, 'Vars', [x, y1, y2]);
    f2_func = matlabFunction(f2, 'Vars', [x, y1, y2]);
    h = (b-a)/(n);
    sol1 = zeros(n+1, 1);
    sol2 = zeros(n+1, 1);
    sol1(1) = initial1;
    sol2(1) = initial2;
    for i=2:n+1
        t_i = a + h*(i-2);
        % y1
        k11 = h * f1_func(t_i, sol1(i-1), sol2(i-1));
        k12 = h * f1_func(t_i + (h/2), sol1(i-1) + (k11/2), sol2(i-1));
        k13 = h * f1_func(t_i + (h/2), sol1(i-1) + (k12/2), sol2(i-1));
        k14 = h * f1_func(t_i + h, sol1(i-1) + k13, sol2(i-1));
        sol1(i) = sol1(i-1) + (1/6)*(k11 + 2*k12 + 2*k13 + k14);

        % y2
        k21 = h * f2_func(t_i, sol1(i-1), sol2(i-1));
        k22 = h * f2_func(t_i + (h/2), sol1(i-1), sol2(i-1) + (k21/2));
        k23 = h * f2_func(t_i + (h/2), sol1(i-1), sol2(i-1) + (k22/2));
        k24 = h * f2_func(t_i + h, sol1(i-1), sol2(i-1) + k23);
        sol2(i) = sol2(i-1) + (1/6)*(k21 + 2*k22 + 2*k23 + k24);
    end

    sol1 = sol1(1:end)';
    sol2 = sol2(1:end)';
end