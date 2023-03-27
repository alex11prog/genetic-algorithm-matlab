function Y=evaluation(P)
[num_ind, bit_size]=size(P);
H=zeros(1,num_ind);

q = quantizer([16 11]); % свойства для преобразований в бинарный вид и обратно

for i = 1:num_ind
    x1 = bin2num(q,(char(P(i,1:bit_size/2) + '0')));
    x2 = bin2num(q,(char(P(i,bit_size/2+1:bit_size) + '0')));
    y = langermann([x1,x2]);
    H(1,i)= y;
end
Y=H;