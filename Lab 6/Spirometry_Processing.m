%% Lab 6: Spirometry 

%% Initialize Data
deep = readtable('deep.csv');
norm = readtable('norm.csv');
nothing = readtable('nothing.csv');
%% Correcting Deep Data
deep.FlowRateSPIRO = deep.FlowRateSPIRO + 1.35; %correct offset
%% Determine Inhalatation and Exhilation period
figure;
plot(deep.ElapsedTime,deep.FlowRateSPIRO);
title('Deep Reading');
xlabel('Time (s)');
ylabel('Flowrate (V/s)');
%370-770 are the indices for Inhalation from deep data 
%840-1610 are the indices for Exhalation from deep data
%% Determine Deep Volumes
DeepVolIn = abs(trapz(deep.FlowRateSPIRO(370:770))); 
DeepVolEx = abs(trapz(deep.FlowRateSPIRO(840:1610)));

TotalVolDeep = DeepVolIn + DeepVolEx;
TotalVolDeep = TotalVolDeep * 0.004; %multiply area under the curve by the timestep

DeepVolIn = DeepVolIn * 0.004; %multiply area under the curve by the timestep
DeepVolEx = DeepVolEx * 0.004; %multiply area under the curve by the timestep
%% Account for normal offset
norm.FlowRateSPIRO = norm.FlowRateSPIRO + 1.9; 

%% Norm Periods
figure;
plot(norm.ElapsedTime,norm.FlowRateSPIRO);
title('Norm Reading');
xlabel('Time (s)');
ylabel('Flowrate (V/s)');
% Period is from indeices 1400 - 1985
%% Volume for Norm
NormFlow = norm.FlowRateSPIRO(1400:1985);
NorVol = abs(trapz(NormFlow)) * 0.004; %multiply area under the curve by the timestep

%% Nothing Data
nothing.FlowRateSPIRO = nothing.FlowRateSPIRO + 1.42;

figure;
plot(nothing.ElapsedTime,nothing.FlowRateSPIRO);
title('Nothing Reading');
xlabel('Time (s)');
ylabel('Flowrate (V/s)');
%% Printing comments

sprintf('The inhalation volume from the deep datafile = %2.2f litres.', DeepVolIn)
sprintf('The exhalation volume from the deep datafile = %2.2f litres.', DeepVolEx)

sprintf('The total volume from the deep datafile = %2.2f litres.', TotalVolDeep)

sprintf('The total volume from the normalized datafile = %2.2f litres.', NorVol)