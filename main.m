%% 基本参数
clc;
clear;
close all;
load T_1; 
load T_2; 
load T_3;
load all;
NIND=200;             %个体数目
MAXGEN=100;     %最大遗传代数
XOVR=0.7;            %交叉率
MUTR=0.1;           %变异率

%输入说明
%目标：T1,T2,T3
%子任务：S11,S12,S13;S21,S22,S23,S24;S31,S32,S33,S34,S35;
% s：子任务集      e.g：s{1}=[1,2,3] 第一个目标有3个子任务
% Sat_Set：卫星集    e.g：Sat_Set{1}=[3,7,12,20] 目标一的第一个子任务有4个可选卫星
%                                       Sat_Set{2}=[2,8,11,23,24]目标一的第二个子任务有5个可选卫星
%% 构建集合
%子任务集
s = {};
for i = 1:3
    s{i} = 1 : size(eval(['T_', num2str(i)]), 1);
end

%给卫星编号
[store, s2n] = mark(all);
keysArray = keys(s2n);
valuesArray = values(s2n);
flag = 1;
for i = valuesArray
    n2s{i{1}} = keysArray{flag} ;
    flag = flag + 1;
end
Sat_NUM = length(keysArray);

%目标总个数
T_NUM = 3;                                              

%子任务总个数 
ST_NUM = 0;
for i = 1:T_NUM
    ST_NUM = ST_NUM + length(s{i});      %子任务总数
    STNum(i)=length(s{i});                           %每个目标对应的子任务数量         
end

%卫星集
Sat_Set = {};
for i = 1:ST_NUM
    temp = store(i, :);
    temp = temp(temp ~= 0);
    Sat_Set{i} = sort(temp);
end

%时间集
Time = zeros(size(all, 1), 1);
for i = 1:size(all, 1)
    Time(i) = all{i, 2} - all{i, 1};
end

%用于计算子任务是否重叠的时间集
% time = zeros(max([size(T_1,1),size(T_2,1),size(T_3,1)]), 2*T_NUM);
% for i = 1:T_NUM
%     for j=1:length(time(:,1))
%         if eval(['j>size(T_',num2str(i),',1)'])
%             break
%         else
%         eval(['time(j,2*i-1) = T_',num2str(i),'{j, 1}']);
%         eval(['time(j,2*i) = ', 'T_',num2str(i),'{j, 2}']);
%         end
%     end
% end

%% 遗传算法实现
[BEST, BESTindividual] = GA(NIND, MAXGEN, XOVR, MUTR, ...
    T_NUM, Sat_NUM, Sat_Set, Time, ST_NUM, STNum, T_1, T_2, T_3, n2s);

%% 输出结果
n2s = print_result(BEST, BESTindividual, n2s, ST_NUM, STNum, Sat_Set, T_NUM);

%% 如果有重叠则重新生成 直到无重叠子任务
% while isoverlap(n2s, T_1, T_2, T_3)
%     fprintf('存在重叠子任务，重新生成解...\n')
%     [BEST, BESTindividual] = GA(NIND, MAXGEN, XOVR, MUTR, ...
%     T_NUM, Sat_NUM, Sat_Set, Time, ST_NUM, STNum);
%     n2s = print_result(BEST, BESTindividual, n2s, ST_NUM, STNum, Sat_Set, T_NUM);
% end

%% 画图 显示结果
plot_result(MAXGEN, BEST)
ganttchart(Sat_NUM, n2s, T_1, T_2, T_3)
