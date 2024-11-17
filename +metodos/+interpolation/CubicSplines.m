classdef CubicSplines < handle
    properties(Access=public)
        points (:, 2) double
        splines (1, :) sym
    end

    methods
        function obj = CubicSplines(points, options)
            arguments
                points
                options.frontier_values (1, 2) double = [0 0] % array [a b] where a = f'(x_0) ; b = f'(x_n)
            end
            obj.points = points;
            varnames = {};
            coefs = ["a", "b", "c", "d"];
            for i=0:length(points)-2
                for j=0:3
                    varnames = [varnames, coefs(mod(j,4)+1) + i];
                end
            end

            import metodos.utils.EqSystem
            eq = EqSystem(varnames);

            splines_coefs_names = strings(length(points)-1, 4);
            for i=1:length(points)-1
                for j=1:4
                    splines_coefs_names(i, j) = varnames((i-1)*4+j);
                end
            end
            
            % first condition
            for i=1:size(splines_coefs_names, 1)
                % S_i(x_i) = y_i
                d = dictionary;
                d(splines_coefs_names(i, 1)) = 1; % (1)*a_i 
                eq.addEq(d, points(i, 2)) % (1)*a_i = y_i

                % S_i(x_{i+1}) = y_{i+1}
                d = dictionary;
                d(splines_coefs_names(i, 2)) = points(i+1, 1) - points(i, 1); % (x_{i+1} - x_i) * b_i
                d(splines_coefs_names(i, 3)) = (points(i+1, 1) - points(i, 1))^2; % (x_{i+1} - x_i)^2 * c_i
                d(splines_coefs_names(i, 4)) = (points(i+1, 1) - points(i, 1))^3; % (x_{i+1} - x_i)^3 * d_i
                eq.addEq(d, points(i+1, 2) - points(i, 2)) % (x_{i+1} - x_i) * b_i + (...)^2 * c_i + ... = y_{i+1} - a_i    (a_i = y_i)
            end

            for i=2:size(splines_coefs_names, 1)
                % S_i'(x_i) = S_i-1'(x_i)
                d = dictionary;
                d(splines_coefs_names(i, 2)) = -1; % (-1)b_i
                d(splines_coefs_names(i-1, 2)) = 1; % (1)b_{i-1}
                d(splines_coefs_names(i-1, 3)) = 2*(points(i, 1) - points(i-1, 1)); % (2)(x_i - x_{i-1}) * c_{i-1}
                d(splines_coefs_names(i-1, 4)) = 3*(points(i, 1) - points(i-1, 1))^2; % (3)(x_i - x_{i-1})^2 * d_{i-1}
                eq.addEq(d, 0); % (-1)b_i + ... = 0

                % S_i''(x_i) = S_i-1''(x_i)
                d = dictionary;
                d(splines_coefs_names(i, 3)) = -2; % (-2)c_i
                d(splines_coefs_names(i-1, 3)) = 2; % (2)c_{i-1}
                d(splines_coefs_names(i-1, 4)) = 6*(points(i, 1) - points(i-1, 1)); % (6)(x_i - x_{i-1}) * d_{i-1}
                eq.addEq(d, 0); % (-2)c_i + ... = 0
            end

            if isequal(options.frontier_values, [0 0])
                % natural frontier
                % S_0''(x_0) = 0
                d = dictionary;
                d(splines_coefs_names(1, 3)) = 1;
                eq.addEq(d, 0); % c_0 = 0
            
                % S_n''(x_n) = 0
                d = dictionary;
                d(splines_coefs_names(end, 3)) = 2;
                d(splines_coefs_names(end, 4)) = 6*(points(end, 1) - points(end-1, 1));
                eq.addEq(d, 0); % % 2c_n + 6d_n(x_last - x_{last-1}) = 0
            else
                % conditioned frontier
                % S_0'(x_0) = f'(x_0)
                d = dictionary;
                d(splines_coefs_names(end, 2)) = 1;
                eq.addEq(d, options.frontier_values(1))

                % S_n'(x_n) = f'(x_n)
                d = dictionary;
                d(splines_coefs_names(end, 2)) = 1;
                d(splines_coefs_names(end, 3)) = 2*(points(end, 1) - points(end-1, 1));
                d(splines_coefs_names(end, 4)) = 3*(points(end, 1) - points(end-1, 1))^2;
                eq.addEq(d, options.frontier_values(2)); % % b_n + 2c_n(x_last - x_{last-1}) + 3d_n(x_last - x_{last-1})^2 = 0
            end

            coefs_solution = eq.solve();
            syms x;
            splines = [];
            for i=1:size(splines_coefs_names, 1)
                a_i = coefs_solution(4*(i-1)+1);
                b_i = coefs_solution(4*(i-1)+2);
                c_i = coefs_solution(4*(i-1)+3);
                d_i = coefs_solution(4*(i-1)+4);
                spline_i = a_i + b_i*(x - points(i, 1)) + c_i*(x - points(i, 1))^2 + d_i*(x - points(i, 1))^3;
                splines = [splines, spline_i];
            end
            obj.splines = splines;
        end

        function show(obj, options)
            arguments
                obj
                options.tolerance = 1
                options.hold = false
            end
            import metodos.utils.evalf
            p = obj.points;
            tolerance = (p(end, 1)-p(1,1))/size(p, 1);
            x = linspace(p(1,1)-tolerance*options.tolerance, p(end,1)+tolerance*options.tolerance, 100);
            y = zeros(1, length(x));
            j = 1;
            for i=1:length(obj.splines)
                spline = obj.splines(i);
                while x(j) < p(i+1, 1)
                    y(j) = evalf(spline,x(j));
                    j = j + 1;
                end
            end
            % calculates tail after the last point
            spline = obj.splines(end);
            while j <= length(x)
                y(j) = evalf(spline,x(j));
                j = j + 1;
            end
            
            plot(x, y, "-", 'Color', [0 0.4470 0.7410], 'LineWidth',2);
            hold on;
            plot(p(:, 1), p(:, 2), ".", 'Color', [0.8500 0.3250 0.0980], 'MarkerSize',20);
            if options.hold == false
                hold off;
            end
        end

        function spline = getSpline(obj, i)
            spline = obj.splines(1, i);
        end

        function fx = eval(obj, x)
            import metodos.utils.evalf
            i = 1;
            while x >= obj.points(i, 1) & i ~= size(obj.points, 1)
                i = i + 1;
            end
            spline = obj.getSpline(i-1);
            fx = evalf(spline, x);
        end

        function x = rootFind(obj, y)
            import metodos.utils.evalf
   
            if obj.points(1, 2) < obj.points(end, 2)
                order = 1;
            elseif obj.points(end, 2) < obj.points(1, 2)
                order = -1;
            end
            i = 1;
            while y >= order * evalf(obj.getSpline(i), obj.points(i+1, 1))
                i = i + 1;
            end

            f = obj.getSpline(i) - y;
            import metodos.rootFind.Bisection

            a = obj.points(i, 1);
            b = obj.points(i+1, 1);
            sol = Bisection(a, b, 1E-5, f);
            sol.solve();
            x = sol.root;
        end
    end
end