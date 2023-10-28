%% ��������
clc;
clear;
close all;
load T_1; 
load T_2; 
load T_3;
load all;
NIND=200;             %������Ŀ
MAXGEN=100;     %����Ŵ�����
XOVR=0.7;            %������
MUTR=0.1;           %������

%����˵��
%Ŀ�꣺T1,T2,T3
%������S11,S12,S13;S21,S22,S23,S24;S31,S32,S33,S34,S35;
% s��������      e.g��s{1}=[1,2,3] ��һ��Ŀ����3��������
% Sat_Set�����Ǽ�    e.g��Sat_Set{1}=[3,7,12,20] Ŀ��һ�ĵ�һ����������4����ѡ����
%                                       Sat_Set{2}=[2,8,11,23,24]Ŀ��һ�ĵڶ�����������5����ѡ����
%% ��������
%������
s = {};
for i = 1:3
    s{i} = 1 : size(eval(['T_', num2str(i)]), 1);
end

%�����Ǳ��
[store, s2n] = mark(all);
keysArray = keys(s2n);
valuesArray = values(s2n);
flag = 1;
for i = valuesArray
    n2s{i{1}} = keysArray{flag} ;
    flag = flag + 1;
end
Sat_NUM = length(keysArray);

%Ŀ���ܸ���
T_NUM = 3;                                              

%�������ܸ��� 
ST_NUM = 0;
for i = 1:T_NUM
    ST_NUM = ST_NUM + length(s{i});      %����������
    STNum(i)=length(s{i});                           %ÿ��Ŀ���Ӧ������������         
end

%���Ǽ�
Sat_Set = {};
for i = 1:ST_NUM
    temp = store(i, :);
    temp = temp(temp ~= 0);
    Sat_Set{i} = sort(temp);
end

%ʱ�伯
Time = zeros(size(all, 1), 1);
for i = 1:size(all, 1)
    Time(i) = all{i, 2} - all{i, 1};
end

%���ڼ����������Ƿ��ص���ʱ�伯
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

%% �Ŵ��㷨ʵ��
[BEST, BESTindividual] = GA(NIND, MAXGEN, XOVR, MUTR, ...
    T_NUM, Sat_NUM, Sat_Set, Time, ST_NUM, STNum, T_1, T_2, T_3, n2s);

%% ������
n2s = print_result(BEST, BESTindividual, n2s, ST_NUM, STNum, Sat_Set, T_NUM);

%% ������ص����������� ֱ�����ص�������
% while isoverlap(n2s, T_1, T_2, T_3)
%     fprintf('�����ص��������������ɽ�...\n')
%     [BEST, BESTindividual] = GA(NIND, MAXGEN, XOVR, MUTR, ...
%     T_NUM, Sat_NUM, Sat_Set, Time, ST_NUM, STNum);
%     n2s = print_result(BEST, BESTindividual, n2s, ST_NUM, STNum, Sat_Set, T_NUM);
% end

%% ��ͼ ��ʾ���
plot_result(MAXGEN, BEST)
ganttchart(Sat_NUM, n2s, T_1, T_2, T_3)
