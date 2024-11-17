function plotLinspace(y, lower, upper)
    arguments
        y (1, :) double
        lower double
        upper double {mustBeGreaterThan(upper, lower)}
    end
    % plots y in the interval [lower, upper]
    x = linspace(lower, upper, length(y));
    plot(x, y);
end