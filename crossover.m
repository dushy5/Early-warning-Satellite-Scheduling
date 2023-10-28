function cpop = crossover(pop, cr, ST_NUM)
%   交叉
%   pop     input  种群
%   cr      input  交叉概率
%   cpop    output 交叉后种群
ST = ST_NUM;
[popsize, ~] = size(pop);
cpop = pop;
if mod(popsize,2) ~= 0
    nn = popsize - 1;
else
    nn = popsize;
end

%分两部分 一部分对子任务进行交叉 一部分对卫星集部分交叉
%子任务分组交叉设置
rand_order = randperm(ST);
if mod(ST,2)~=0
    Tset1 = sort(rand_order(1: floor(ST/2)));
    Tset2 = sort(rand_order(ceil(ST/2):end));
else
    Tset1 = sort(rand_order(1: ST/2));
    Tset2 = sort(rand_order(ST/2+1:end));
end
idx1=[];
idx2=[];
val1=[];
val2=[];

%交叉开始
for iter = 1:2:nn
    if rand > cr
        continue; %交叉概率
    end
    %子任务分组交叉开始
    P1 = pop(iter, 1:ST);
    P2 = pop(iter+1, 1:ST);
    C1 = zeros(1, ST);
    C2 = zeros(1, ST);
    idx1=[];
    idx2=[];
    val1=[];
    val2=[];
    for i=1:length(P1)
        if(find(Tset1, P1(i)))
            idx1=[idx1, i];
            val1=[val1, P1(i)];
        end
        if(find(Tset2, P2(i)))
            idx2=[idx2, i];
            val2=[val2, P2(i)];
        end
    end
    C1 = P1(idx1);
    C2 = P2(idx2);
    flag1 = 1;
    flag2 = 1;
    for i=1:ST
        if(C1(i)==0)
            C1(i)=val2(flag2);
            flag2 = flag2 + 1;
        end
        if(C2(i)==0)
            C2(i)=val1(flag1);
            flag1 = flag1 + 1;
        end
    end %子任务交叉结束 子代C1,C2
    
    %对卫星集进行多点交叉
    P3 = pop(iter, ST+1:end);
    P4 = pop(iter+1, ST+1:end);
    %产生一个随机的01序列
    rand_01  = rand(1, ST); 
    for n=1:length(rand_01)
        if(rand_01(n)<=0.5)
            rand_01(n) = floor(rand_01(n));
        else
            rand_01(n) = ceil(rand_01(n));
        end
    end
    %多点交叉开始
    flag = 1;
    C3 = zeros(1, ST*2);
    C4 = zeros(1, ST*2);
    for n=1:ST
        if(rand_01(n)==0)
            C3(flag:flag+1)=P3(flag:flag+1);
            C4(flag:flag+1)=P4(flag:flag+1);
            flag = flag+ 2;
        end
        if(rand_01(n)==1)
            C3(flag:flag+1)=P4(flag:flag+1);
            C4(flag:flag+1)=P3(flag:flag+1);
            flag = flag + 2;
        end
    end%多点交叉结束,子代C3,C4
    %相同子代合并 返回
    cpop(iter, :) = [C1,C3];
    cpop(iter+1, :) = [C2,C4];
end
end
    
