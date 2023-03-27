function [New_P, New_fitness] = selection(P, fitness, population_size)
% P - популяция, 
% fitness - значения приспособленности
% population_size - размер популяции

[x, y]=size(P);

P1 = zeros(population_size,y); % отобранные особи
fitness1 = zeros(1, population_size); % значения проспособленности отобранных особей

% получаем максимальное значение приспособленности
max_fitness = max(fitness);
% переносим значения приспособленности в отрицательную область
fitness = fitness - max_fitness - 1; 

% Отбираем 3 элиты
e=3;
for i = 1:e
    [fit_value, index_min] = min(fitness);
    P1(i,:)=P(index_min,:);
    P(index_min,:)=[];
    fitness1(i)=fit_value;
    fitness(:, index_min)=[];
end
D=fitness/sum(fitness); % Determine selection probability
E = cumsum(D); % Determine cumulative probability
N=rand(1); % Generate a vector constaining normalized random numbers
index_candidate=1; % индекс кандидата на отбор из исходной популяции 
index_add=e; % индекс при добавлении в результирующую популяцию
while index_add < population_size
    if N <= E(index_candidate)
        P1(index_add+1,:)=P(index_candidate,:);
        fitness1(index_add+1)=fitness(index_candidate);
        N=rand(1);
        index_add = index_add + 1;
        index_candidate = 1;
    else
        index_candidate = index_candidate +1;
    end
end
New_P = P1;
New_fitness = fitness1+max_fitness +1;% возвращаем на место, так как для вычислений переводили значения в отрицательную область
end