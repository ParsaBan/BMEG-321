%% LAB 7: Determining Systolic and Dialstolic Pressure
%% Import BP Data
BP1 = readtable("BP_1.csv");
BP2 = readtable("BP_2.csv");
BP3 = readtable("BP_3.csv");
BP4 = readtable("BP_4.csv");
%% Plot to find when heart beats occur
figure();
plot(BP1.BloodPressureBP);
ylabel("Pressure (mmHg)");
title("Blood Pressure Measurement 1");

%At index 1784 (Pressure ~ 80.8 mmHG), a heartbeat is observed
DP1 = BP1.BloodPressureBP(1784); %Diastolic Pressure

%At index 3668 (Pressure ~ 191.4 mmHG), the heartbeat begins to dissapear
SP1 = BP1.BloodPressureBP(3668); %Systolic Pressure

%% Repeat for 2nd Measurement
figure();
plot(BP2.BloodPressureBP);
ylabel("Pressure (mmHg)");
title("Blood Pressure Measurement 2");

%At index 1073 (Pressure ~ 63.2 mmHG), a heartbeat is observed
DP2 = BP2.BloodPressureBP(1073); %Diastolic Pressure

%At index 4028 (Pressure ~ 176 mmHG), the heartbeat begins to dissapear
SP2 = BP2.BloodPressureBP(4028); %Systolic Pressure

%% Repeat for 3rd Measurement
figure();
plot(BP3.BloodPressureBP);
ylabel("Pressure (mmHg)");
title("Blood Pressure Measurement 3");

%At index 1275 (Pressure ~ 93.8 mmHG), a heartbeat is observed
DP3 = BP3.BloodPressureBP(1275); %Diastolic Pressure

%At index 2500 (Pressure ~ 160 mmHG), the heartbeat begins to dissapear
SP3 = BP3.BloodPressureBP(2500); %Systolic Pressure

%% Repeat for 4th Measurement
figure();
plot(BP4.BloodPressureBP);
ylabel("Pressure (mmHg)");
title("Blood Pressure Measurement 4");

%At index 1440 (Pressure ~ 74 mmHG), a heartbeat is observed
DP4 = BP4.BloodPressureBP(1440); %Diastolic Pressure

%At index 3438 (Pressure ~ 168.9 mmHG), the heartbeat begins to dissapear
SP4 = BP4.BloodPressureBP(3438); %Systolic Pressure

%% Put into table and calculate average
Diastolic_Pressure = [DP1; DP2; DP3; DP4];
Systolic_Pressure = [SP1; SP2; SP3; SP4];

FinalVal = table(Diastolic_Pressure, Systolic_Pressure);
MeanDP = mean(FinalVal.Diastolic_Pressure);
MeanSP = mean(FinalVal.Systolic_Pressure);

sprintf('The average diastolic pressure = %2.2f mmHG.', MeanDP)
sprintf('The average systolic pressure = %2.2f mmHG.', MeanSP)