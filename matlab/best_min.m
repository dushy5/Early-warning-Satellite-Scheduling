function [bestindividual,bestfit, bestindex] = best_min(pop,fitvalue)
% --------------选出最优个体函数-----------------------
% 输入变量： pop :种群
%                   fitvalue : 种群适应度
% 输出变量： bestindividual : 最佳个体（二进制）
% bestfit : 最佳适应度值
% bestindex: 所在的索引
% ---------------------------------------------------------
    [px,~] = size(pop);
    bestindividual = pop(1,:);
    bestfit = fitvalue(1);
    bestindex = 1;
    for i = 2:px
        if fitvalue(i)<bestfit
            bestindividual = pop(i,:);
            bestfit = fitvalue(i);
            bestindex = i;
        end
    end
end
