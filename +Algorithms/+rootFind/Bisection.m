classdef Bisection < Algorithms.rootFind.Base
    properties(Access=private)
        criterion (1,1) string {mustBeMember(criterion, ["biseccion", "regula"])} = "biseccion"
        a_mov (1,1) double
        b_mov (1,1) double
    end

    methods
        function obj = Bisection(a, b, tol, f, options)
            arguments
                a double
                b double
                tol double {mustBePositive, mustBeLessThan(tol, 1)}
                f sym
                options.check_critical_points logical = false
                options.criterion (1,1) string {mustBeMember(options.criterion, ["biseccion", "regula"])} = "biseccion"
            end
            obj@Algorithms.rootFind.Base(a, b, tol, f, check_critical_points=options.check_critical_points)
            obj.criterion = options.criterion;
            obj.a_mov = obj.a;
            obj.b_mov = obj.b;
        end
    end

    methods(Access=protected)
        function new_root = update(obj)
            import Algorithms.utils.evalf
            if obj.criterion == "biseccion"
                new_root = (obj.a_mov+obj.b_mov)/2;
            else
                fa = evalf(obj.f, obj.a_mov);
                fb = evalf(obj.f, obj.b_mov);
                new_root = b - (fb*(obj.b_mov-obj.a_mov))/(fb - fa);
            end

            fc = evalf(obj.f, new_root);
            if fc < 0
                obj.a_mov = new_root;
            elseif fc > 0
                obj.b_mov = new_root;
            end
        end
    end
end