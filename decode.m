function S = decode(chrom, ST_NUM, Sat_Set)
% ����
%input ����Ⱦɫ��
%output ��i��Ŀ��ĵڸ���������ʹ�õĵ�1��2�����ǵı��
row = 1;
flag = 1;
for i = ST_NUM + 1 :2: length(chrom)
    S(row, 1) = Sat_Set{flag}(chrom(i));
    S(row, 2) = Sat_Set{flag}(chrom(i + 1));
    S(row, :) = sort(S(row,:));
    row = row+1;
    flag = flag + 1;
end