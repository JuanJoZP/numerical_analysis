function tests = testBisection
    tests = functiontests(localfunctions);
end

function testPolynomialWithRoots(testCase)
    import Algorithms.rootFind.Bisection
    
    syms x;
    f1 = x^3 + 4*x^2 -10;
    
    problem1 = Bisection(-2, 2, 1E-5, f1);
    problem1.solve()
    
    %root1 = biseccion(f1, 2, -2, 0.000005, "regula")
    
    %f2 = exp(x) - 4 + x;
    %root2 = biseccion(f2, -2, 2, 0.000005, "biseccion")
    %root2 = biseccion(f2, -2, 2, 0.000005, "regula")
    
    %f1b = @() biseccion(f1, 2, -2, 0.000005, "biseccion")
    %f1r = @() biseccion(f1, 2, -2, 0.000005, "regula")
    
    %f2b = @() biseccion(f2, -2, 2, 0.000005, "biseccion")
    %f2r = @() biseccion(f2, -2, 2, 0.000005, "regula")
    %timeit(f1b)
end
