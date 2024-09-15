classdef Bisection < Algorithms.rootFind.Base
    properties(Access=private)
        criterion (1,1) string {mustBeMember(criterion, ["bisection", "false_position", "secant"])} = "bisection"
        a_mov (1,1) double
        b_mov (1,1) double
    end

    methods
        function obj = Bisection(a, b, tol, f, options)
            arguments
                a 
                b 
                tol 
                f sym
                options.check_critical_points  = false
                options.criterion (1,1) string {mustBeMember(options.criterion, ["bisection", "false_position", "secant"])} = "bisection"
                options.absolute_error = false
            end
            import methods.utils.evalf
            obj@Algorithms.rootFind.Base(a, b, tol, f, check_critical_points=options.check_critical_points, absolute_error=options.absolute_error)
            obj.criterion = options.criterion;
            fa = evalf(f, a);
            fb = evalf(f, b);
            if fa < fb
                obj.a_mov = obj.a;
                obj.b_mov = obj.b;
            else
                obj.a_mov = obj.b;
                obj.b_mov = obj.a;
            end
        end
    end

    methods(Access=protected)
        function new_root = update(obj)
            import methods.utils.evalf
            if obj.criterion == "secant"
                % convention: p_k-1 is saved in a_mov, p_k is saved in b_mov
                new_root = obj.b_mov - (evalf(obj.f, obj.b_mov)*(obj.b_mov - obj.a_mov))/(evalf(obj.f, obj.b_mov) - evalf(obj.f, obj.a_mov));
                obj.a_mov = obj.b_mov;
                obj.b_mov = new_root;

            else
                if obj.criterion == "false_position"
                    fa = evalf(obj.f, obj.a_mov);
                    fb = evalf(obj.f, obj.b_mov);
                    new_root = obj.b_mov - (fb*(obj.b_mov-obj.a_mov))/(fb - fa);

                elseif obj.criterion == "bisection"
                    new_root = (obj.a_mov+obj.b_mov)/2;
                end
                % interval update for bisection or false position
                fc = evalf(obj.f, new_root);
                if fc < 0; obj.a_mov = new_root;
                elseif fc > 0; obj.b_mov = new_root;
                end
                
            end
        end
    end
end