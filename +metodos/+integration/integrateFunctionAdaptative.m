function intx = integrateFunctionAdaptative(f, x0, xn, tolerance, precalculated)
    arguments
        f sym
        x0 double
        xn double {mustBeGreaterThan(xn, x0)}
        tolerance double {mustBePositive}
        precalculated double = []
    end

    import metodos.integration.integrateFunctionComposite
    import metodos.integration.integrateFunctionAdaptative

    if ~isempty(precalculated)
        intx = precalculated;
    else
        intx = integrateFunctionComposite(f, x0, xn, "simpson", 4);
    end
    int_left = integrateFunctionComposite(f, x0, (x0 + xn)/2, "simpson", 4);
    int_right = integrateFunctionComposite(f, (x0 + xn)/2, xn, "simpson", 4);
    error = (intx - int_left - int_right)/15;
    if error < tolerance
        intx = int_left + int_right;
        return
    else
        disp("error: "+ error + ". Splitting ["+x0 +", "+xn+"]")
        intx = integrateFunctionAdaptative(f, x0, (x0 + xn)/2, tolerance/2, int_left) + integrateFunctionAdaptative(f, (x0 + xn)/2, xn, tolerance/2, int_right);
    end
end