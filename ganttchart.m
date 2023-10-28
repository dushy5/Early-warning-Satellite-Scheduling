function ganttchart(Sat_NUM, n2s, T_1, T_2, T_3)
figure;
axis([600, 1600 ,0, Sat_NUM+1]);%x轴 y轴的范围
set(gca,'xtick',600:100:1500) ;%x轴的增长幅度
set(gca,'ytick',0:1:Sat_NUM+1) ;%y轴的增长幅度
xlabel('时刻'),ylabel('卫星编号');%x轴 y轴的名称
title('最佳调度甘特图');%图形的标题

hold on;

rec = [0, 0, 0, 0];
color = ['r', 'g', 'w'];
for i = 1:length(n2s)
    if ~isempty(n2s)
        for st = n2s{2, i}
            target = floor(st / 100);
            submission = mod(st, 10);
            switch target
                case 1
                    c = color(1);
                case 2
                    c = color(2);
                case 3 
                    c = color(3);
            end
            rec(1) = eval(['T_', num2str(target), '{', num2str(submission), ', 1}',]);
            rec(2) = i;
            rec(3) = eval(['T_', num2str(target), '{', num2str(submission), ', 2}',]) - ...
                eval(['T_', num2str(target), '{', num2str(submission), ', 1}',]);
            rec(4) = 0.5;
            rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-', 'FaceColor',c);%draw every rectangle
            text(rec(1) + rec(3)/2, rec(2) + rec(4)/2, num2str(st),'FontWeight','Bold','FontSize',8)
        end
    end
end