%% 画图 显示结果
function plot_result(MAXGEN, BEST)
figure;  
plot(1:MAXGEN, BEST(1, :), 'LineWidth', 1, 'Color', 'r') 
hold on
plot(1:MAXGEN, BEST(6, :),  'LineWidth', 1, 'Color', 'black', 'LineStyle','--') 
xlabel 迭代次数 
ylabel 目标函数
legend('最优目标函数', '平均目标函数');  
title '遗传算法迭代曲线'  
grid on  

figure;  
plot(1:MAXGEN, BEST(2, :),  'LineWidth', 1, 'Color', 'red') 
hold on
plot(1:MAXGEN, BEST(3, :),  'LineWidth', 1, 'Color', 'black', 'LineStyle','--') 
xlabel 迭代次数 
ylabel 卫星切换次数
legend('最优值', '平均值');  
title '卫星切换次数变化'  
grid on  

figure;  
plot(1:MAXGEN, BEST(4, :),  'LineWidth', 1, 'Color', 'red') 
hold on
plot(1:MAXGEN, BEST(5, :),  'LineWidth', 1, 'Color', 'black', 'LineStyle','--') 
xlabel 迭代次数 
ylabel 卫星负载
legend('最优值', '平均值');  
title '卫星负载变化'  
grid on  

end