function [New_P, New_fitness] = selection(P, fitness, population_size)
% P - ���������, 
% fitness - �������� �����������������
% population_size - ������ ���������

[x, y]=size(P);

P1 = zeros(population_size,y); % ���������� �����
fitness1 = zeros(1, population_size); % �������� ����������������� ���������� ������

% �������� ������������ �������� �����������������
max_fitness = max(fitness);
% ��������� �������� ����������������� � ������������� �������
fitness = fitness - max_fitness - 1; 

% �������� 3 �����
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
index_candidate=1; % ������ ��������� �� ����� �� �������� ��������� 
index_add=e; % ������ ��� ���������� � �������������� ���������
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
New_fitness = fitness1+max_fitness +1;% ���������� �� �����, ��� ��� ��� ���������� ���������� �������� � ������������� �������
end