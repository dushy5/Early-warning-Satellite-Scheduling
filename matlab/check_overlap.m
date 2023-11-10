function y = check_overlap(chrom, ST_cumsum, Sat_Set, T_1, T_2, T_3)
p = length(chrom);
if p<=ST_cumsum(1)
    y = false;
    return
end


new_cum = [0, ST_cumsum(1:end-1)/2];
for i = 1:p-1
    if mod(i, 2) == 0
        flag_1 = i / 2;
    else 
        flag_1 = (i+1) / 2;
    end

    if mod(p, 2) == 0
        flag_2 = p /2;
    else
        flag_2 = (p+1) / 2;
    end

    if Sat_Set{flag_1}(chrom(i)) == Sat_Set{flag_2}(chrom(p))
        T1 = find(ST_cumsum >= i, 1);
        S1 = ceil(i / 2) - new_cum(T1);
        t1 = eval(['T_', num2str(T1), '{', num2str(S1), ', 1}',]);
        t2 = eval(['T_', num2str(T1), '{', num2str(S1), ', 2}',]);

        T2 = find(ST_cumsum >= p, 1);
        S2 = ceil(p / 2) - new_cum(T2);
        t3 = eval(['T_', num2str(T2), '{', num2str(S2), ', 1}',]);
        t4 = eval(['T_', num2str(T2), '{', num2str(S2), ', 2}',]);
        
        if isoverlap_one(t1, t2, t3, t4)
                y = true;
                return;
        end
    end
end
y = false;
end


function y = isoverlap_one(startTime1, endTime1, startTime2, endTime2) 
if (startTime1 >= endTime2 || startTime2 >= endTime1)
    y = false;
else
    y = true;
end
end
