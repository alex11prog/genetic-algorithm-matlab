function Y=crossover(P,prob)
% P - популяция
% prob - вероятность(probability)
% возвращает новых скрещенных индивидуумов
[x1, y1]=size(P);
Z = []; % матрица новых индивидуумов
index_new_individ = 1;
for i = 1:x1
    r1=randi(x1,1,2);
    while r1(1)==r1(2)
        r1=randi(x1,1,2);
    end
    A1=P(r1(1),:); % parent 1
    A2=P(r1(2),:); % parent 2
    
    % отобрали два родителя, теперь решим, будут ли они скрещиваться
    if rand(1)> prob
        continue
    end
    
    r2=1+randi(y1-1); % random cutting point
    B1=A1(1,r2:y1);
    A1(1,r2:y1)=A2(1,r2:y1);
    A2(1,r2:y1)=B1;
    Z(index_new_individ,:)=A1; % offspring 1
    Z(index_new_individ +1,:)=A2; % offspring 2
    index_new_individ = index_new_individ + 2;
end
Y=Z;