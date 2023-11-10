%% 输出结果
function n2s = print_result(BEST, BESTindividual, n2s, ST_NUM, STNum, Sat_Set, T_NUM)
%找最小适应度对应的个体
[~, index] = min(BEST(1, :));
best_ind = BESTindividual(index, :);
best_ind = best_ind(ST_NUM + 1:end);

%输出结果
flag = 1;
tmp = 0;
for i = 1:length(n2s)
    n2s{2, i} = [];
end
for i = 1:T_NUM
    for j = 1:STNum(i)
        fprintf('第%d个目标的第%d个子任务对应的卫星为：%s，%s \n',...
            i, ...
            j, ...
            n2s{1, Sat_Set{j + tmp}(best_ind(flag))}, ...
            n2s{1, Sat_Set{j + tmp}(best_ind(flag+1))} ...
            );
        n2s{2, Sat_Set{j + tmp}(best_ind(flag))} = [i * 100 + j, n2s{2, Sat_Set{j + tmp}(best_ind(flag))}];
        n2s{2, Sat_Set{j + tmp}(best_ind(flag+1))} = [i * 100 + j, n2s{2, Sat_Set{j + tmp}(best_ind(flag+1))}];
        flag = flag+2;
    end
    tmp = tmp + STNum(i);
end
fprintf("---------------已找到最优解-------------------\n")
end