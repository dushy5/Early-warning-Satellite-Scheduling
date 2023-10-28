function mpop = mutation(pop, mr, Sat_Set, ST_NUM)

% 变异，交换两个随机位置的基因
% pop       input  种群
% mr         input  变异概率
%Sat_Set    input 卫星集
% mpop     output 变异后种群
ST = ST_NUM;
[popsize, ~] = size(pop);
mpop = pop;

for iter = 1:popsize
    if rand > mr
        continue;
    end
     %子任务变异开始
    P1 = pop(iter, 1:ST);
    idx1 = unidrnd(ST);
    idx2 = idx1;
    while(idx2==idx1)
        idx2 = unidrnd(ST);
    end
    temp = P1(idx1);
    P1(idx1:end-1) = P1(idx1+1:end);
    P1(idx2+1:end) = P1(idx2:end-1);
    P1(idx2) = temp; %子任务变异结束 
    
    %卫星序列变异开始
    P2 = pop(iter, ST+1:end);
    rand_int = randi([1, 2*ST]);
    while(mod(rand_int, 2) ~= 0)
        rand_int = randi([1, 2*ST]);
    end
    idx = rand_int / 2; %对应的卫星集索引
    temp = unidrnd(length(Sat_Set{idx}));
    while P2(rand_int-1) == temp || P2(rand_int) == temp
        temp = unidrnd(length(Sat_Set{idx}));
    end
    tmp = P2(rand_int-1);
    P2(rand_int-1) = temp;
    
    while P2(rand_int-1)  == temp || P2(rand_int) == temp || tmp == temp
        temp = unidrnd(length(Sat_Set{idx}));
    end
    P2(rand_int) = temp;%卫星序列变异结束
    
    
    mpop(iter, :)= [P1, P2];
    
end

end