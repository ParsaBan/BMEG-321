%% Lab 8: ECG Post Processsing
%% Initiating the Data
Relaxed = readtable("Relaxed.csv");
Activated = readtable("Activated.csv");

%% Initial Trace

figure()
plot(Relaxed.ECG2);

%% Data prior to index 2*10^4 is noisy, easier to remove it
Relaxed(1:2e4,:)=[];

%% Heartbeat
thresh = Relaxed.ECG2 > 0.5; 
numPeaks = sum(thresh);
HR = numPeaks / 50; %50 seconds between first and last beat

%% Drawing the Trace for the Relaxed Data
t1 = Relaxed.ElapsedTime(500);
t2 = Relaxed.ElapsedTime(2500);
figure()
plot(Relaxed.ElapsedTime(500:2500), Relaxed.ECG2(500:2500));

title("ECG Trace from a Sitting Position");
ylabel("Amplitude of Signal");
xlabel("Time(s)");

%Plot between 10.25 seconds and 11.25 seconds (1 second interval)

%% Activated Trial

thresh = Activated.ECG2 > 0.5; 
numPeaks = sum(thresh);
HR2 = numPeaks / 64; %50 seconds between first and last beat

t12 = Activated.ElapsedTime(29500);
t22 = Activated.ElapsedTime(31000);

figure()
plot(Activated.ElapsedTime(29500:31000), Activated.ECG2(29500:31000));
title("ECG Trace after a 2 Minute Run");
ylabel("Amplitude of Signal");
xlabel("Time(s)");

%Plot between 14.75 seconds and 15.50 seconds

%% 6 Lead ECG
L1 = Relaxed.ECG1;
L2 = Relaxed.ECG2;
L3 = Relaxed.ECG3;

aVL = (L1 - L3)./2;
aVR = -((L1 + L2)./2);
aVF = (L2 + L3)./2;

figure()
plot(Relaxed.ElapsedTime(500:2500), L1(500:2500));
hold on;
plot(Relaxed.ElapsedTime(500:2500), L2(500:2500));
hold on;
plot(Relaxed.ElapsedTime(500:2500), L3(500:2500));
hold on;
plot(Relaxed.ElapsedTime(500:2500), aVL(500:2500));
hold on;
plot(Relaxed.ElapsedTime(500:2500), aVR(500:2500));
hold on;
plot(Relaxed.ElapsedTime(500:2500), aVF(500:2500));
hold off;
legend("Lead I", "Lead II", "Lead III", "aVL", "aVR", "aVF");

title("6 Lead ECG Signals Plotted Together");
xlabel("Time (s) [10.25s - 11.25s]");
ylabel("Signal Amplitude");

%% Cardiac Axis Interpretation
figure()
plot(Relaxed.ElapsedTime(500:1750), L1(500:1750));
title("Lead I");
xlabel("Time (s) [10.25s - 10.87s]");
ylabel("Signal Amplitude");

figure()
plot(Relaxed.ElapsedTime(500:1750), aVF(500:1750));
title("Lead aVF");
xlabel("Time (s) [10.25s - 10.87s]");
ylabel("Signal Amplitude");
