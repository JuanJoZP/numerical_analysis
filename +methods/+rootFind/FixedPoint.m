classdef FixedPoint < Algorithms.rootFind.Base
    properties(Access=private)
        root_priv double
        g sym
    end

    methods
        function obj = FixedPoint(a, b, tol, f, g, options)
            arguments
                a
                b
                tol 
                f 
                g sym
                options.check_existance = true 
                options.check_critical_points = false 
                options.absolute_error = false
            end
            import methods.utils.evalf
            obj@Algorithms.rootFind.Base(a, b, tol, f, ...
                check_existance=options.check_existance, ...
                check_critical_points=options.check_critical_points, ...
                absolute_error=options.absolute_error)

            obj.g = g;
            obj.root_priv = (a+b)/2;
            % falta checkear que g es un despeje valido, no se como

            % check condition: |g'(x)| < 1 for all x in [a, b]
            gp = diff(g);
            gpp = diff(gp);
            critical_points = solve(gpp == 0, 'Real', true);
            critical_points = [a, b, critical_points'];
            in_interval = critical_points < b & critical_points > a;
            extreme_values = arrayfun(@(x) evalf(gp, x), critical_points(in_interval));
            if any(abs(extreme_values) > 1)
                disp(extreme_values)
                error("The absolute value of the derivative of g is not less than one for all x, thus the method won't converge. Change g")
            end
        end
    end

    methods(Access=protected)
        function new_root = update(obj)
            import methods.utils.evalf
            new_root = evalf(obj.g, obj.root_priv);
            obj.root_priv = new_root;
        end
    end
end