function value = evalf(f, x)
    value = double(subs(f, x));
end