function intx = integratePoints(points, x0, xn, n, options)
    arguments
        points dictionary % string -> double dict (x and f(x))
        x0 double % integral from x0 to xn
        xn double {mustBeGreaterThan(xn, x0)}
        n double {mustBeInteger, mustBeInRange(n, 0, 4)} % deegre
        options.open = false
    end

    keys = points.keys;
    for i = 1:length(keys)
        mustBeA(keys(i), 'string');
    end
    
    format long
    

    if options.open
        h = (xn - x0)/(n+2);
        x0 = x0 + h;
        if n == 0
            intx = 2*h*points(num2str(x0));
        elseif n == 1
            intx = ((3*h)/2)*(points(num2str(x0)) + points(num2str(x0 + h)));
        elseif n == 2
            intx = ((4*h)/3)*(2*points(num2str(x0)) + (-1)*points(num2str(x0 + h)) + 2*points(num2str(x0 + 3*h)));
        elseif n == 3
            intx = ((5*h)/24)*(11*points(num2str(x0)) + points(num2str(x0 + h)) + points(num2str(x0 + 2*h)) + 11*points(num2str(x0 + 3*h)));
        elseif n == 4
            error("Open formulas do not support n=4. Try setting open=false")
        end
    else
        h = (xn - x0)/n;
        if n == 0
            error("Closed formulas do not support n=0. Try setting open=true")
        elseif n == 1
            intx = (h/2)*(points(num2str(x0)) + points(num2str(x0 + h)));
        elseif n == 2
            intx = (h/3)*(points(num2str(x0)) + 4*points(num2str(x0 + h)) + points(num2str(x0 + 2*h)));
        elseif n == 3
            intx = ((3*h)/8)*(points(num2str(x0)) + 3*points(num2str(x0 + h)) + 3*points(num2str(x0 + 2*h)) + points(num2str(x0 + 3*h)));
        elseif n == 4
            intx = ((2*h)/45)*(7*points(num2str(x0)) + 32*points(num2str(x0 + h)) + 12*points(num2str(x0 + 2*h)) + 32*points(num2str(x0 + 3*h)) + 7*points(num2str(x0 + 4*h)));
        end
    end
end