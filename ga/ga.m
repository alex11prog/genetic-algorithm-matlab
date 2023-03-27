function [Min_fitness, Optimal_solution]= ga(population_size, p_crossover, p_mutation, num_gen, x_min, x_max, num_repeat_to_stop)
%population_size - ������ ���������
%p_crossover - ����������� �������������
%p_mutation - ����������� �������
%num_gen - ���������� ���������
%x_min - ����������� �������� x
%x_max - ������������ �������� x
%num_repeat_to_stop - ���������� ���������� �������� �� ��������� ���������
figure
title('����� - �������, ������� - �������');
xlabel('���������')
ylabel('�������� �����������������')
hold on
% ������� ���������
P = population(population_size, x_min, x_max);
Stat = zeros(num_gen,2); % ������� ��� ������� ���������� (�������, ����������� ����������������)
Num_repeat_min_fit = 0; % ���������� ���������� ��������
last_min_fit = 0; % ��������� �������� �������� �����������������
for i=1:num_gen
    % �������� ���������� ������������
    individuals = crossover(P,p_crossover);
    % ��� ���������� ������������ ��������� �������
    individuals = mutation(individuals,p_mutation);
    % ��������� ����� ������������ � ����� ���������
    size_ind = size(individuals);
    P(population_size+1:population_size+size_ind(1),:)= individuals;
    % ������� �����������������
    fitness=evaluation(P);
    % ��������� �����
    [P, fitness]=selection(P,fitness,population_size);
    % ������� ������� �����������������
    Stat(i,1)=sum(fitness)/population_size;
    Stat(i,2)=fitness(1); % ������ �����������������
    plot(Stat(:,1),'b.');drawnow
    hold on
    plot(Stat(:,2),'r.'); drawnow
    % ������� ���������� ���������� ������� ����������
    if Num_repeat_min_fit == 0
        Num_repeat_min_fit = 1; % ������ ���������
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
Min_fitness=fitness(1); % ��� ������, ��� ��� ������� �������� ����
P2 = P(1,:); % Best chromosome
% convert binary to teal numbers
q = quantizer([16 11]); % �������� ��� �������������� � �������� ��� � �������
size_P2 = size(P2);
x1 = bin2num(q,(char(P2(1,1:size_P2(2)/2) + '0')));
x2 = bin2num(q,(char(P2(1,size_P2(2)/2+1:size_P2(2)) + '0')));
Optimal_solution = [x1, x2];
end
