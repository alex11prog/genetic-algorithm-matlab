function Y=mutation(P,prob)
% P - ���������
% prob - �����������(probability)
% ������ ������� �������� � �������� ������������
[x1, y1]=size(P);
Y = P;
for i = 1:x1
    if rand(1)> prob
        continue
    end
    % ��������
    individ=P(i,:); 
    swap_bit=randi(y1);
    if individ(1,swap_bit)== 1
        individ(1,swap_bit) = 0;
    else
        individ(1,swap_bit) = 1;
    end
    Y(i,:)=individ;
end