function Y=population(population_size, min, max)
% создаем популяцию из битовых строк
% длина хромосомы 32 бит, два числа float по 16 бит для x1(1 - 16) и x2(17 - 32)
Y = zeros(population_size,32);

q = quantizer([16 11]); % свойства для преобразований в бинарный вид и обратно

for i = 1:population_size
    x1 = min + rand*(max-min);
    x2 = min + rand*(max-min);
    x1_bin = num2bin(q,x1);
    x2_bin = num2bin(q,x2);
    Y(i,1:16) = x1_bin - '0';
    Y(i,17:32) = x2_bin - '0';
end
end