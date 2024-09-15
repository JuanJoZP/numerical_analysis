% compare, recibe unos argumentos, una lista de metodos y una lista de
% nombres, devuelve tabla con reporte del algoritmo con mejor desempeño en
% tiempos iteraciones y error
% toma en cuenta el numero de veces a repetir el experimento, la desviacion
% estandar, puede devolver graficos

function compare(methods, names)
    arguments
        methods 
        names (1,:) string
    end

    assert(numel(methods) == numel(names), ...
        'El número de elementos en "methods" y "names" debe ser el mismo.');

    len = length(names);
    it = zeros(len, 1);
    err = zeros(len, 1);
    time = zeros(len, 1);
    i = 1;
    for m=methods
        tic
        S = m{1}();
        time(i) = toc;
        it(i) = S.iterations;
        err(i) = S.error;
        i = i + 1;
    end

    t = table(names', it, err, time);
    t.FormattedError = arrayfun(@(x) sprintf('%.3e', x), t.err, 'UniformOutput', false);
    t.TimeInMilliseconds = t.time * 1000;

    disp(sortrows(table(t.Var1, t.it, t.FormattedError, t.TimeInMilliseconds, ...
        'VariableNames', {'Metodos', 'Número de iteraciones', 'Error', 'Tiempo (ms)'}), 'Tiempo (ms)'))
end