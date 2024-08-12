function code = check_roots_existance(f, a, b, options)
% CHECK_SOLUTION checks if a root exists in the interval [a, b], if no 
% root is found returns -1, if a is root returns 1, if b is root returns
% 2, if root is in (a, b) returns 0. If check_critical_points=false it
% only checks using intermediate value theorem f (greater performance), for
% an exhaustive search set check_critical_points=true.
    arguments
        f sym
        a double
        b double
        options.check_critical_points logical = false
    end

    import Algorithms.utils.evalf
    import Algorithms.rootFind.Bisection
    
    fa = evalf(f, a);
    fb = evalf(f, b);

    if (fa > 0) && (fb < 0)
        code = 0; return
    end
    if (fa < 0) && (fb > 0)
        code = 0; return
    end
    if fa == 0
        code = 1; return
    end
    if fb == 0
        code = 2; return
    end

    if ~options.check_critical_points
        code = -1; return
    else
        fp = diff(f);
        fp_roots = Bisection(a, b, 1E-10, fp);
        fp_roots.solve();
        critical_point = fp_roots.root;
        f_crit = evalf(f, critical_point);

        if (fa > 0) && (fb > 0)
            if f_crit < 0
                code = 0; return
            end
            code = -1; return
        end
        if (fa < 0) && (fb < 0)
            if f_crit > 0
                code = 0; return
            end
            code = -1; return
        end
    end
end