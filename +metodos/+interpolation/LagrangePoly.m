classdef LagrangePoly< handle
    properties(Access=private)
        points (:, 2) double
        poly sym
    end

    methods
        function obj = LagrangePoly(points)
            arguments
                points (:, 2) double
            end
            obj.points = points;

            coef_polys = {};
            syms x;
            for k=1:length(points)
                numerator = sym(1);
                denominator = sym(1);
                for j=1:length(points)
                    if j ~= k
                        numerator = numerator * (x - points(j,1));
                        denominator = denominator * (points(k,1) - points(j, 1));
                    end
                end
                coef_polys{k} = numerator/denominator;
            end

            poly = sym(0);
            for k=1:length(points)
                poly = poly + points(k, 2)*coef_polys{k};
            end
            obj.poly = poly;
        end

        function x = eval(obj, v)
            import methods.utils.evalf
            x = evalf(obj.poly, v);
        end

        function show(obj)
            import methods.utils.evalf
            p = obj.points;
            x = linspace(p(1,1), p(end,1), 100);
            y = arrayfun(@(x) evalf(obj.poly, x), x);
            
            plot(x, y, "-", 'Color', [0 0.4470 0.7410]);
            hold on;
            plot(p(:, 1), p(:, 2), ".", 'Color', [0.8500 0.3250 0.0980], MarkerSize=15)
            hold off;
        end

        function spline = getSpline(obj, i)
            spline = obj.poly(1, i);
        end
    end

end