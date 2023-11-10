function [objvalue, obj1, obj2] = calobjvalue(Chrom, T_NUM, ST_NUM, Sat_NUM, Sat_Set, Time, STNum)
px = size(Chrom, 1);
py = size(Chrom, 2);
TarNum = T_NUM;
SatNum = Sat_NUM;
for i=1:length(Sat_Set)
    for j = 1:length(Sat_Set{i})
        SatOpt(i,j)=Sat_Set{i}(j);
    end
end

%卫星切换频率
for ind =1:px
    S = decode(Chrom(ind, :), ST_NUM, Sat_Set);%i改成了ind
    S = [S, Time];
    n=zeros(TarNum,1);
    for i=1:TarNum
        if i==1
            w=0;
        else
            w=STNum(i-1);
        end
        for j=1:STNum(i)-1
           if S(w+j,1)==S(w+j+1,1)&&S(w+j,2)==S(w+j+1,2)
           elseif S(w+j,1)==S(w+j+1,1)||S(w+j,2)==S(w+j+1,2)
               n(i)=n(i)+1;
           else
               n(i)=n(i)+2;
           end
        end
    end
    SwitchNum=sum(n);
    
    %卫星使用负载
    Exp_SatWT=zeros(SatNum,1);
    Actu_SatWT=zeros(SatNum,1);
    for i=1:sum(STNum)
        temp = SatOpt(i, :);
        temp(find(temp == 0)) = [];
        Exp_SatWT(temp)=Exp_SatWT(temp)+S(i,3)/length(temp);
        Actu_SatWT(S(i,1))=Actu_SatWT(S(i,1))+S(i,3);
        Actu_SatWT(S(i,2))=Actu_SatWT(S(i,2))+S(i,3);    
    end
    ConsteLoad=sqrt(sum((Actu_SatWT-Exp_SatWT).^2)/(SatNum-1));
    objvalue(ind) = SwitchNum + ConsteLoad;
    obj1(ind) = SwitchNum;
    obj2(ind) = ConsteLoad;
end