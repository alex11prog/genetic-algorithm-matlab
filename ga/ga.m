function [Min_fitness, Optimal_solution]= ga(population_size, p_crossover, p_mutation, num_gen, x_min, x_max, num_repeat_to_stop)
%population_size - размер популяции
%p_crossover - вероятность кроссинговера
%p_mutation - вероятность мутации
%num_gen - количество поколений
%x_min - минимальное значение x
%x_max - максимальное значение x
%num_repeat_to_stop - количество повторений минимума до остановки алгоритма
figure
title('Синий - среднее, красный - минимум');
xlabel('Поколение')
ylabel('Значение приспособленности')
hold on
% создаем популяцию
P = population(population_size, x_min, x_max);
Stat = zeros(num_gen,2); % матрица для ведения статистики (средняя, минимальная приспособленнось)
Num_repeat_min_fit = 0; % количество повторений минимума
last_min_fit = 0; % последнее значение минимума приспособленности
for i=1:num_gen
    % получаем скрещенных индивидуумов
    individuals = crossover(P,p_crossover);
    % для скрещенных индивидуумов запускаем мутацию
    individuals = mutation(individuals,p_mutation);
    % добавляем новых индивидуумов в конец популяции
    size_ind = size(individuals);
    P(population_size+1:population_size+size_ind(1),:)= individuals;
    % считаем приспособленность
    fitness=evaluation(P);
    % запускаем отбор
    [P, fitness]=selection(P,fitness,population_size);
    % считаем среднюю приспособленность
    Stat(i,1)=sum(fitness)/population_size;
    Stat(i,2)=fitness(1); % лучшая приспособленность
    plot(Stat(:,1),'b.');drawnow
    hold on
    plot(Stat(:,2),'r.'); drawnow
    % считаем количество повторений лучшего результата
    if Num_repeat_min_fit == 0
        Num_repeat_min_fit = 1; % первое поколение
        last_min_fit = fitness(1);
    else
        if round(last_min_fit, 3) == round(fitness(1), 3)
            Num_repeat_min_fit = Num_repeat_min_fit +1;
        else
            last_min_fit = fitness(1);
            Num_repeat_min_fit = 1;
        end
        if Num_repeat_min_fit == num_repeat_to_stop
            break
        end
    end
end
Min_fitness=fitness(1); % оно первое, так как сначала отбирали элит
P2 = P(1,:); % Best chromosome
% convert binary to teal numbers
q = quantizer([16 11]); % свойства для преобразований в бинарный вид и обратно
size_P2 = size(P2);
x1 = bin2num(q,(char(P2(1,1:size_P2(2)/2) + '0')));
x2 = bin2num(q,(char(P2(1,size_P2(2)/2+1:size_P2(2)) + '0')));
Optimal_solution = [x1, x2];
end
