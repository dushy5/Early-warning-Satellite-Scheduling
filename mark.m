function [store, hash] = mark(Vis)
all = {};
flag = 1;
for i = 1 : size(Vis, 1)
    for j = 3 : 15
        if Vis{i, j} ~=0
            all{flag}= Vis{i, j};
            flag = flag + 1;
        end
    end
end
Sat= unique(all, 'stable');
hash = containers.Map;
for i = 1:length(Sat)
    hash(Sat{i}) = i;
end

for i = 1:size(Vis, 1)
    for j = 3:15
        if Vis{i, j}==0
            continue;
        end
        store(i, j-2) = hash(Vis{i, j});
    end
end
end