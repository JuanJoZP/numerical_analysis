function y = fourierSeries(x, t, a0, an, bn)
    arguments
        x (1,1) double
        t (1,1) double {mustBePositive}
        a0 (1,1) double
        an (1, :) double
        bn (1, :) double
    end
    assert(length(an)==length(bn))
    % computes y = fourier-series(x) for given coefs
    
    w = (2*pi)/t;
    y = a0/2;
    for i=1:length(an)
        y = y + an(i)*cos(i*w*x) + bn(i)*sin(i*w*x);
    end
end