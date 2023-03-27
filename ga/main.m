clear all
close all
clc
%----------------------------------------------------------------
population_size = 100; % ������ ���������
p_crossover = 0.9; % ����������� �������������
p_mutation = 0.9; % ����������� �������
num_gen = 100; % ���������� ���������
x_min = 0; % ����������� �������� x
x_max = 10; % ������������ �������� x
num_repeat_to_stop = 20; % ���������� ���������� �������� �� ��������� ���������
%----------------------------------------------------------------

[ga_min_fit, ga_solution] = ga(population_size, p_crossover, p_mutation, num_gen, x_min, x_max, num_repeat_to_stop);
fprintf('ga x1 = %f\n',ga_solution(1));
fprintf('ga  x2 = %f\n',ga_solution(2));
fprintf('ga min fitness = %f\n',ga_min_fit);

% �������� ������ �������
step = 0.2; % ��� ����� ���������� ����������
% ��������� ������� ���������� x1 � x2
[x1,x2]=meshgrid(x_min:step:x_max,x_min:step:x_max); 
len = length(x1); % ������� ������ ������� (�� ���������� � ���� ������)
% ������� ������� �������� ������� ���������� z
z = zeros(len, len);
% ��������� ������� �������� �������
for i = 1:len
    for j = 1:len
            z(i, j) = langermann([x1(i, j), x2(i,j)]);
    end
end

% ������ ������
figure
surf(x1,x2,z);
% ���� �������
[f_min,index_i] = min(z);
[f_min,index_j] = min(f_min);
index_i = index_i(index_j);
sol_x1 = x1(index_i, index_j);
sol_x2 = x2(index_i, index_j);
[x1x2,f_min] = fminsearch(@(x) langermann([x(1),x(2)]), [sol_x1,sol_x2]);
fprintf('x1 = %f\n',x1x2(1));
fprintf('x2 = %f\n',x1x2(2));
fprintf('f_min = %f\n',f_min);