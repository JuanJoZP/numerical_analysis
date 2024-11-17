function fppx = derivateFunctionOrder2(f, x0, h)
    arguments
        f sym
        x0 double
        h double
    end
    
    import metodos.derivation.derivatePointsOrder2
    import metodos.utils.evalf

    dom = x0-5*h:h:x0+5*h;
    ran = arrayfun(@(x) evalf(f, x), dom);
    points = dictionary(string(dom), ran);
    
    fppx = derivatePointsOrder2(points, x0, h);
end