function intx = integrateFunctionComposite(f, x0, xn, rule, n)
    arguments
        f sym
        x0 double
        xn double {mustBeGreaterThan(xn, x0)}
        rule string {mustBeMember(rule, ["simpson", "trapezoidal", "midpoint"])}
        n double {mustBeInteger, mustBeGreaterThan(n, 0)}
    end

    import methods.integration.integrateComposite
    import methods.utils.evalf

    if rule == "simpson" || rule =="midpoint"
        if mod(n, 2) ~= 0
            error("n must be even")
        end
    end

    if rule == "midpoint"
        dom = linspace(x0, xn, n+3);
    else
        dom = linspace(x0, xn, n+1);
    end

    ran = arrayfun(@(x) evalf(f, x), dom);
    points = dictionary(string(dom), ran);

    intx = integrateComposite(points, x0, xn, rule, n);
end