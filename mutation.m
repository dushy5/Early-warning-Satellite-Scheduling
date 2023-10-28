function mpop = mutation(pop, mr, Sat_Set, ST_NUM)

% ���죬�����������λ�õĻ���
% pop       input  ��Ⱥ
% mr         input  �������
%Sat_Set    input ���Ǽ�
% mpop     output �������Ⱥ
ST = ST_NUM;
[popsize, ~] = size(pop);
mpop = pop;

for iter = 1:popsize
    if rand > mr
        continue;
    end
     %��������쿪ʼ
    P1 = pop(iter, 1:ST);
    idx1 = unidrnd(ST);
    idx2 = idx1;
    while(idx2==idx1)
        idx2 = unidrnd(ST);
    end
    temp = P1(idx1);
    P1(idx1:end-1) = P1(idx1+1:end);
    P1(idx2+1:end) = P1(idx2:end-1);
    P1(idx2) = temp; %������������ 
    
    %�������б��쿪ʼ
    P2 = pop(iter, ST+1:end);
    rand_int = randi([1, 2*ST]);
    while(mod(rand_int, 2) ~= 0)
        rand_int = randi([1, 2*ST]);
    end
    idx = rand_int / 2; %��Ӧ�����Ǽ�����
    temp = unidrnd(length(Sat_Set{idx}));
    while P2(rand_int-1) == temp || P2(rand_int) == temp
        temp = unidrnd(length(Sat_Set{idx}));
    end
    tmp = P2(rand_int-1);
    P2(rand_int-1) = temp;
    
    while P2(rand_int-1)  == temp || P2(rand_int) == temp || tmp == temp
        temp = unidrnd(length(Sat_Set{idx}));
    end
    P2(rand_int) = temp;%�������б������
    
    
    mpop(iter, :)= [P1, P2];
    
end

end