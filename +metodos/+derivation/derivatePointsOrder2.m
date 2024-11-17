function fppx = derivatePointsOrder2(points, x0, h)
    arguments
        points dictionary
        x0 (1, 1) double
        h (1, 1) double
    end

    keys = points.keys;
    for i = 1:length(keys)
        mustBeA(keys(i), 'string');
    end

    format long
    fppx = (1 / (h^2)) * (points(num2str(x0-h)) - 2*points(num2str(x0)) + points(num2str(x0 + h)));
end
