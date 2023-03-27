function Y=mutation(P,prob)
% P - популяция
% prob - вероятность(probability)
% каждый индивид мутирует с заданной вероятностью
[x1, y1]=size(P);
Y = P;
for i = 1:x1
    if rand(1)> prob
        continue
    end
    % мутируем
    individ=P(i,:); 
    swap_bit=randi(y1);
    if individ(1,swap_bit)== 1
        individ(1,swap_bit) = 0;
    else
        individ(1,swap_bit) = 1;
    end
    Y(i,:)=individ;
end