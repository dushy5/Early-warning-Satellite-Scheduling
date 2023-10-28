function cpop = crossover(pop, cr, ST_NUM)
%   ����
%   pop     input  ��Ⱥ
%   cr      input  �������
%   cpop    output �������Ⱥ
ST = ST_NUM;
[popsize, ~] = size(pop);
cpop = pop;
if mod(popsize,2) ~= 0
    nn = popsize - 1;
else
    nn = popsize;
end

%�������� һ���ֶ���������н��� һ���ֶ����Ǽ����ֽ���
%��������齻������
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

%���濪ʼ
for iter = 1:2:nn
    if rand > cr
        continue; %�������
    end
    %��������齻�濪ʼ
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
    end %�����񽻲���� �Ӵ�C1,C2
    
    %�����Ǽ����ж�㽻��
    P3 = pop(iter, ST+1:end);
    P4 = pop(iter+1, ST+1:end);
    %����һ�������01����
    rand_01  = rand(1, ST); 
    for n=1:length(rand_01)
        if(rand_01(n)<=0.5)
            rand_01(n) = floor(rand_01(n));
        else
            rand_01(n) = ceil(rand_01(n));
        end
    end
    %��㽻�濪ʼ
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
    end%��㽻�����,�Ӵ�C3,C4
    %��ͬ�Ӵ��ϲ� ����
    cpop(iter, :) = [C1,C3];
    cpop(iter+1, :) = [C2,C4];
end
end
    
