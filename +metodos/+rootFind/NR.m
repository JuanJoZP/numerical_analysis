classdef NR < Algorithms.rootFind.Base
    properties(Access=private)
        root_priv double
        fprime sym
    end

    methods
        function obj = NR(tol, f, initial_guess, options)
            arguments
                tol 
                f 
                initial_guess double
                options.absolute_error = false
            end
            obj@Algorithms.rootFind.Base(0, 1, tol, f, check_existance=false,absolute_error=options.absolute_error)
            obj.root_priv = initial_guess;
            obj.fprime = diff(f);
        end
    end

    methods(Access=protected)
        function new_root = update(obj)
            import methods.utils.evalf
            new_root = obj.root_priv - evalf(obj.f, obj.root_priv)/evalf(obj.fprime, obj.root_priv);
            obj.root_priv = new_root;
        end
    end
end