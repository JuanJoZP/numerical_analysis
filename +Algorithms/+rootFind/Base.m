classdef Base < handle
    % Base base class for root-finding methods
    %  implements easier interface for root-finding methods, constructor
    %  receives the problem information and validates it, solve method
    %  iterates until the error is acceptable. sub-classes should implement
    %  the update method.
    properties(SetAccess=private)
        a double
        b double
        f sym
        tol double {mustBePositive} = 1E-10
        solved logical = false
        err double {mustBeNonnegative}
        root double
    end

    methods
        function obj = Base(a, b, tol, f, options)
            % Instantiate the root-finding problem.
            % parameters: 
            %   a: double. Left limit of the interval in which to search
            %   the root
            %   b: double. Right limit of the interval
            %   tol: double. Tolerance for the relative aproximation error
            %   f: sym. The function (must be a symbolic function)
            %   check_critical_points: boolean, default=false. Whether to
            %   use critical points to check if root exists in the
            %   interval
            arguments
                a double
                b double
                tol double {mustBePositive, mustBeLessThan(tol, 1)}
                f sym
                options.check_critical_points logical = false
            end

            if a < b % checks if interval is well defined
                obj.a = a;
                obj.b = b;
            else
                error("Interval a=%0.2e b=%0.2e is not well defined. a should be less than b", a, b)
            end

            % checks for roots existance
            import Algorithms.utils.check_roots_existance
            exists_code = check_roots_existance(f, a, b, check_critical_points=options.check_critical_points); % see help check_solution 
            if exists_code == -1
                error("There may not exist a root in the interval [%0.2e, %0.2e], set check_critical_points=true to search for roots using critical points (may reduce performance)")
            elseif exists_code == 1
                error("There is a root in a") % this should be done diferently, should not be error.
            elseif exists_code == 2
                error("There is a root in b") % this should be done diferently, should not be error.
            end

            obj.tol = tol;
            obj.f = f; 
        end

        function value = get.err(obj)
            if obj.solved
                value = obj.err;
            else
                error("To get the relative error, first find the root. Run .solve()");
            end
        end

        function value = get.root(obj)
            if obj.solved
                value = obj.root;
            else
                error("First find the root. Run .solve()");
            end
        end
    end

    methods(Sealed)
        function S = solve(obj)
            % SOLVE updates the root until the relative error is less than
            % tolerance
            % The root found and the error can be accessed with obj.root
            % and obj.error
            S.iterations = 0;
            root_priv = NaN;
            err_priv = 1E10;
            while err_priv > obj.tol || isnan(err_priv)
                prev = root_priv;
                root_priv = obj.update();
                err_priv = obj.aproximation_error(prev, root_priv);
                S.iterations = S.iterations + 1;
            end

            obj.solved = true;
            obj.root = root_priv;
            obj.err = err_priv;
            S.root = root_priv;
            S.error = err_priv;
        end
    end

    methods(Access=private, Sealed)
        function error = aproximation_error(~, prev, actual)
            % APROXIMATION_ERROR calculates relative aproximation error.
            if prev ~= 0
                error = abs((prev - actual)/prev);
            else 
                error = abs((prev - actual));
            end
        end
    end


    methods(Abstract, Access=protected)
         % UPDATE implements the actual root-finding method. It should
         % return the new root.
        new_root = update(obj)
    end

end