function fpx = derivatePoints(points, x0, h, options)
    arguments
        points dictionary
        x0 (1, 1) double
        h (1, 1) double
        options.num_points string {mustBeMember(options.num_points, {'three', 'five'})} = 'five'
        options.extreme logical = false
        options.extrapolation_order (1,1) double {mustBePositive, mustBeInteger} = 1
    end

    import metodos.derivation.derivatePoints

    keys = points.keys;
    for i = 1:length(keys)
        mustBeA(keys(i), 'string');
    end

    format long
    if options.extrapolation_order == 1
        if options.extreme
            if options.num_points == "five"
                fpx = (-25*points(num2str(x0)) + 48*points(num2str(x0 + h)) - 36*points(num2str(x0 + 2*h)) + 16*points(num2str(x0 + 3*h)) - 3*points(num2str(x0 + 4*h)))/(12*h);
            elseif options.num_points == "three"
                fpx = (-3*points(num2str(x0)) + 4*points(num2str(x0 + h)) - points(num2str(x0 + 2*h)))/(2*h); 
            end
        else
            if options.num_points == "five"
                fpx = (points(num2str(x0 -2*h)) - 8*points(num2str(x0 - h)) + 8*points(num2str(x0 + h)) - points(num2str(x0 + 2*h)))/(12*h);
            elseif options.num_points == "three"
                fpx = (points(num2str(x0 + h)) - points(num2str(x0 - h)))/(2*h);
            end
        end
    else
        n = options.num_points;
        ext = options.extreme;
        order = options.extrapolation_order;
        less_order_h_2 = derivatePoints(points, x0, h/2, "num_points",n, "extreme", ext, "extrapolation_order",order-1);
        less_order_h = derivatePoints(points, x0, h, num_points=n, extreme=ext, extrapolation_order=order-1);
        
        fpx = less_order_h_2 + (less_order_h_2 - less_order_h)/(4^(order-1) - 1);
    end    
end