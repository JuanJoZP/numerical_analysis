classdef EqSystem < handle
    properties(Access=private)
        varNames
        n
        matrix
        b
        nFilled
    end

    methods
        function obj = EqSystem(varNames)
            obj.varNames = varNames;
            n = length(varNames);
            obj.n = n;
            obj.matrix = zeros(n, n);
            obj.b = zeros(n, 1);
            obj.nFilled = 0;
        end

        function addEq(obj, A, b)
            % ADDEQ adds equation to the system, A should be a dictionary
            % with the name of each variable and its value, b should be the
            % value at the other side of the equation.
            if(obj.nFilled >= obj.n)
                error("You already filled "+obj.n+" equations"); return
            end

            k = keys(A);
            v = values(A);
            for i = 1:numEntries(A)
                index = find(obj.varNames == k(i));
                obj.matrix(obj.nFilled+1, index) = v(i);
            end
            obj.b(obj.nFilled+1) = b;
            obj.nFilled = obj.nFilled + 1;
        end

        function x = solve(obj)
            x = obj.matrix \ obj.b;
        end
    end
end