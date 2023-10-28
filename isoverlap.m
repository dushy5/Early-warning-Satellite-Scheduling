function y = isoverlap(n2s, T_1, T_2, T_3)
for i = 1:length(n2s)
    for j = 1: length(n2s{2, i})
        if j == length(n2s{2, i})
            break
        end
        for k = j+1:length(n2s{2, i})
            st1 = n2s{2, i}(j);
            st2 = n2s{2, i}(k);
            target1 = floor(st1 / 100);
            submission1 = mod(st1, 10);
            target2 = floor(st2 / 100);
            submission2 = mod(st2, 10);
            t1 = eval(['T_', num2str(target1), '{', num2str(submission1), ', 1}',]);
            t2 = eval(['T_', num2str(target1), '{', num2str(submission1), ', 2}',]);
            t3 = eval(['T_', num2str(target2), '{', num2str(submission2), ', 1}',]);
            t4 = eval(['T_', num2str(target2), '{', num2str(submission2), ', 2}',]);
            if isoverlap_one(t1, t2, t3, t4)
                y = true;
                return;
            end
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