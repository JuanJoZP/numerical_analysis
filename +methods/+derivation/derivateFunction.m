function fpx = derivateFunction(f, x0, h, options)
    arguments
        f sym
        x0 double
        h double
        options.extreme logical = false
        options.num_points string {mustBeMember(options.num_points, {'three', 'five'})} = 'five'
        options.extrapolation_order (1,1) double {mustBePositive, mustBeInteger} = 1
    end
    
    import methods.derivation.derivatePoints
    import methods.utils.evalf

    order = options.extrapolation_order;
    size = h/(2^(order-1));
    dom = x0-5*h:size:x0+5*h;
    ran = arrayfun(@(x) evalf(f, x), dom);
    points = dictionary(string(dom), ran);
    
    if options.num_points == "five"
        if options.extreme
            fpx = derivatePoints(points, x0, h, "extrapolation_order",order, "extreme", false, "num_points","five");
        else
            fpx = derivatePoints(points, x0, h, "extrapolation_order",order, "extreme", true, "num_points","five");
        end
    else
        if options.extreme
            fpx = derivatePoints(points, x0, h, "extrapolation_order",order, "extreme", true, "num_points","three");
        else
            fpx = derivatePoints(points, x0, h, "extrapolation_order",order, "extreme", false, "num_points","three");
        end
    end
end