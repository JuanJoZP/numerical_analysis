function intx = integrateFunction(f, x0, xn, n, options)
    arguments
        f sym
        x0 double
        xn double {mustBeGreaterThan(xn, x0)}
        n double {mustBeInteger, mustBeInRange(n, 0, 4)}
        options.open = false
    end

    import methods.integration.integratePoints
    import methods.utils.evalf

    open = options.open;
    if open
        dom = linspace(x0, xn, n+3);
    else
        dom = linspace(x0, xn, n+1);
    end

    ran = arrayfun(@(x) evalf(f, x), dom);
    points = dictionary(string(dom), ran);

    intx = integratePoints(points, x0, xn, n, "open", open);
end