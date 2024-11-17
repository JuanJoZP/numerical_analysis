import metodos.equations.pivoteoEscalado

% cambiar x, y, f, derivadas y a0_init a1_init segun el caso
x = [0.25; 0.75; 1.25; 1.75; 2.25];
y = [0.28; 0.57; 0.68; 0.74; 0.79];

f = @(a0, a1, x) a0*(1-exp(-a1*x));
a0_deriv = @(a1, x) 1-exp(-a1*x);
a1_deriv = @(a0, a1, x) a0*x*exp(-a1*x);

a0_i = 1;
a1_i = 1;
J = [arrayfun(@(x_val) a0_deriv(a1_i, x_val), x), arrayfun(@(x_val) a1_deriv(a0_i, a1_i, x_val), x)];
R = y-arrayfun(@(x_val) f(a0_i, a1_i, x_val), x);
delta_a = pivoteoEscalado((J')*J, (J')*R);
a0_i = a0_i + delta_a(1);
a1_i = a1_i + delta_a(2);

while norm(delta_a) > 1E-5
    J = [arrayfun(@(x_val) a0_deriv(a1_i, x_val), x), arrayfun(@(x_val) a1_deriv(a0_i, a1_i, x_val), x)];
    R = y-arrayfun(@(x_val) f(a0_i, a1_i, x_val), x);
    delta_a = pivoteoEscalado((J')*J, (J')*R);
    a0_i = a0_i + delta_a(1);
    a1_i = a1_i + delta_a(2);
end

f = @(x) a0_i*(1-exp(-a1_i*x));
dom = linspace(0.25, 2.25, 20);
ybar = arrayfun(f, dom);
plot(x, y)
hold on
plot(dom, ybar)