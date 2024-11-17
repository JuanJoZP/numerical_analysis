x_original = [1 2 3 4 5];
y_original = [0.5 1.7 3.4 5.7 8.4];
x = log10(x_original);
y = log10(y_original);

n = length(x);
xiyi = 0;
nxi2 = 0;
xi = 0;
yi = 0;
for i=1:n
    xiyi = xiyi + x(i)*y(i);
    nxi2 = nxi2 + x(i)*x(i);
    xi = xi + x(i);
    yi = yi + y(i);
end

nxiyi = xiyi*n;
xi2 = xi*xi;
nxi2 = n * nxi2;

a1 = (nxiyi - xi*yi) / (nxi2 - (xi*xi));
a0 = (yi/n) - a1*(xi/n);

b2 = a1;
alpha2 = 10^a0;

hold on
scatter(x_original, y_original);
ybar = (x_original.^b2).*alpha2;
plot(x_original, ybar);
hold off

st = 0;
for i=1:n
    st = st + (y(i) - (yi/n))^2;
end

sr = 0;
for i=1:n
    sr = sr + (y(i) - (x(i)*a1 + a0))^2;
end

ybar_st = sqrt(sr/(n-2));
r2 = (st - sr)/st;

disp(sqrt(st/(n-1)));
disp(sr);
disp(ybar_st)
disp(r2)