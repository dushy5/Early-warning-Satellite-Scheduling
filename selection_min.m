function [newpop] = selection_min(pop,fitvalue)
% -----------------������Ӧ��ѡ����-------------------
% ������� ��pop:��������Ⱥ
%           fitvalue: ��Ӧ��
% ���������  newpop: ѡ���Ժ�Ķ�������Ⱥ
% -------------------------------------------
% ������������
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


%���̶ķ�
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
    