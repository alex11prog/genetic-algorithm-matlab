function [y] = langermann(x1x2)
x1 = x1x2(1);
x2 = x1x2(2);

A = [3, 5; 5, 2; 2, 1; 1, 4; 7, 9];
c = [1, 2, 5, 2, 3];
m = 5;

outer = 0;

for i = 1:m
    inner = (x1-A(i,1))^2 + (x2-A(i,2))^2;
    new = c(i) * exp(-inner/pi) * cos(pi*inner);
    outer = outer + new;
end

y = -outer;

end