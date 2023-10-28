function S = decode(chrom, ST_NUM, Sat_Set)
% 解码
%input 单行染色体
%output 第i个目标的第个子任务所使用的第1和2个卫星的编号
row = 1;
flag = 1;
for i = ST_NUM + 1 :2: length(chrom)
    S(row, 1) = Sat_Set{flag}(chrom(i));
    S(row, 2) = Sat_Set{flag}(chrom(i + 1));
    S(row, :) = sort(S(row,:));
    row = row+1;
    flag = flag + 1;
end