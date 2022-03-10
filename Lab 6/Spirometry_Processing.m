%% Lab 6: Spirometry 

%% Initialize Data
deep = readtable('deep.csv');
norm = readtable('norm.csv');
nothing = readtable('nothing.csv');

%% Create plots for each data set
figure;
plot(deep.ElapsedTime,deep.FlowRateSPIRO);
title('Deep Reading');
xlabel('Time (s)');
ylabel('Volume (L)');

figure;
plot(norm.ElapsedTime,norm.FlowRateSPIRO);
title('Norm Reading');
xlabel('Time (s)');
ylabel('Volume (L)');


figure;
plot(nothing.ElapsedTime,nothing.FlowRateSPIRO);
title('Nothing Reading');
xlabel('Time (s)');
ylabel('Volume (L)');

figure;
plot(deep.ElapsedTime,deep.FlowRateSPIRO);
hold on;
plot(norm.ElapsedTime,norm.FlowRateSPIRO);
hold on;
plot(nothing.ElapsedTime,nothing.FlowRateSPIRO);
hold off;
title('Lung Capacity Measurement');
xlabel('Time (s)');
ylabel('Volume (L)');
