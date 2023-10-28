function [newpop] = selection_min(pop,fitvalue)
% -----------------根据适应度选择函数-------------------
% 输入变量 ：pop:二进制种群
%           fitvalue: 适应度
% 输出变量：  newpop: 选择以后的二进制种群
% -------------------------------------------
% 两两竞争法：
    [px, py] = size(pop);
    newpop = zeros(px,py);
    flag = 1;
    while flag<px
            for i =1:2:px
                [~, ind] = min(fitvalue(i:i+1));
                newpop(flag,:) = pop(ind + i-1,:);
                flag = flag+1;
            end
    end
end


%轮盘赌法
% function selectedPopulation = selection(population, fitness, totalFitness)
%     populationSize = size(population, 1);
%     selectedPopulation = zeros(size(population));
%     
%     accumulatedFitness = cumsum(fitness) / totalFitness;
%     
%     for i = 1:populationSize
%         r = rand;
%         selectedIndividualIndex = find(accumulatedFitness >= r, 1, 'first');
%         selectedPopulation(i, :) = population(selectedIndividualIndex, :);
%     end
% end
    