function [BEST, BESTindividual] = GA(NIND, MAXGEN, XOVR, MUTR, ...
    T_NUM, Sat_NUM, Sat_Set, Time, ST_NUM, STNum, T_1, T_2, T_3, n2s)
%% 初始化种群
% 代码2层，第一层子任务，第二层对应卫星
ST_cumsum = cumsum(STNum*2);
Chrom=zeros(NIND,ST_NUM+ 2*ST_NUM); %总子任务编码+一个子任务对应两个卫星
Order = [];
for i=1:T_NUM
    Order = [Order, i*ones(1, STNum(i))];
end
 
for i=1:NIND
    randIndex = randperm(size(Order, 2));                   %辅助排序
    Chrom(i, 1:ST_NUM) = Order(randIndex);
    flag = 1;                                                                     %子任务的指针
    for j = ST_NUM+1 : 2 : ST_NUM+ 2*ST_NUM
        Chrom(i, j) = unidrnd(length(Sat_Set{flag})); %在第flag个卫星集里面随机找一个卫星
        
        tik = 0;
        while check_overlap(Chrom(i, ST_NUM+1 : j), ST_cumsum, Sat_Set, T_1, T_2, T_3)
            if tik > Sat_NUM
                break
            end
            Chrom(i, j) = unidrnd(length(Sat_Set{flag}));
            tik = tik + 1;
        end
       
        if tik > Sat_NUM
            Chrom(i, :) = Chrom(unidrnd(i-1), :);
            break
        end
        Chrom(i, j+1) = unidrnd(length(Sat_Set{flag}));
        
        tik = 0;
        while Chrom(i, j+1) == Chrom(i, j) || check_overlap(Chrom(i, ST_NUM+1 : j+1), ST_cumsum, Sat_Set, T_1, T_2, T_3)    %如果重复 循环生成
            if tik > Sat_NUM
                break
            end
            Chrom(i,j+1) = unidrnd(length(Sat_Set{flag}));
            tik = tik + 1;
        end

        if tik > Sat_NUM
            Chrom(i, :) = Chrom(unidrnd(i-1), :);
            break
        end

        flag = flag+1;                                                          %子任务指针指向下一个
    end
end

%% 循环寻找
% BEST = zeros(6, MAXGEN);
gen = 0;
while gen<MAXGEN
    gen = gen+1;
    %计算适应度值
    [objvalue, SwitchNum, ConsteLoad] =  calobjvalue(Chrom, T_NUM, ST_NUM, Sat_NUM, Sat_Set, Time, STNum);
    
    %寻找最优解z
    [bestindividual, bestfit, bestindex]=best_min(Chrom, objvalue);
    BEST(1, gen) = bestfit; %第一行记载总的目标函数
    BEST(2, gen) = SwitchNum(bestindex);  %第二行是切换频率的最优值
    BEST(3, gen) = sum(SwitchNum) / length(SwitchNum); %第三行是切换频率的平均值
    BEST(4, gen) = ConsteLoad(bestindex); %第四行是卫星负载的最优值
    BEST(5, gen) = sum(ConsteLoad) / length(ConsteLoad); %第五行是卫星负载的平均值
    BEST(6, gen) = sum(objvalue) / length(objvalue); %第六行是总目标函数的平均值
    BESTindividual(gen, :) = bestindividual;

    %选择操作
    spop = selection_min(Chrom, objvalue);    

    %交叉操作
    cpop =crossover(spop, XOVR, ST_NUM);          

    %变异操作
    mpop = mutation(cpop, MUTR, Sat_Set, ST_NUM);

    %保留最好的一代
    mpop(bestindex, :) = bestindividual;
    
    %代数增加
    Chrom = mpop;
end