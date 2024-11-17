function intx = integrateComposite(points, x0, xn, rule, n)
    arguments
        points dictionary
        x0 double
        xn double {mustBeGreaterThan(xn, x0)}
        rule string {mustBeMember(rule, ["simpson", "trapezoidal", "midpoint", "simpson3_8"])}
        n double {mustBeInteger, mustBeGreaterThan(n, 0)}
    end

    keys = points.keys;
    for i = 1:length(keys)
        mustBeA(keys(i), 'string');
    end
    
    format long

    if rule == "simpson"
        if mod(n, 2) ~= 0
            error("n must be even")
        end
        h = (xn - x0)/n;
        sum1 = 0;
        sum2 = 0;
        for j=1:((n/2)-1)
            sum1 = sum1 + points(num2str(x0 + 2*j*h));
            sum2 = sum2 + points(num2str(x0 + (2*j - 1)*h));
        end
        sum2 = sum2 + points(num2str(x0 + (2*(n/2) - 1)*h));
        intx = (h/3) * (points(num2str(x0)) + 2*sum1 + 4*sum2 + points(num2str(xn)));
    elseif rule == "trapezoidal"
        h = (xn - x0)/n;
        sum = 0;
        for j=1:(n-1)
            sum = sum + points(num2str(x0 + j*h));
        end
        intx = (h/2) * (points(num2str(x0)) + 2*sum + points(num2str(xn)));
    elseif rule == "midpoint"
        if mod(n, 2) ~= 0
            error("n must be even")
        end
        h = (xn - x0)/(n+2);
        sum = 0;
        for j=0:(n/2)
            sum = sum + points(num2str(x0 + ((2*j) + 1)*h));
        end
        intx = (2*h) * sum;
    elseif rule == "simpson3_8"
        h = (xn - x0)/(3*n);
        sum = 0;
        for j=0:(n-1)
            sum = sum + 3*points(num2str(x0 + (3*j + 1)*h));
            sum = sum + 3*points(num2str(x0 + (3*j + 2)*h));
            sum = sum + 2*points(num2str(x0 + (3*(j+1))*h));
        end
        intx = ((3*h)/8) * (points(num2str(x0)) + sum - points(num2str(xn)));
    end
end