%% Importing the raw and filtered BioRadio data
raw = readtable('Parsa-1_Raw.csv');
filtered = readtable('Parsa-1_Filtered.csv');

raw = raw.LeftBice;
filtered = filtered.LeftBice;

timeAxis = (0:length(raw)-1)*30/length(raw);

figure
tiledlayout(2,1);

nexttile;
plot(timeAxis, raw);
title('Raw EMG Data from BioCapture');
xlabel('Time (s)');
ylabel('Amplitude');

nexttile;
plot(timeAxis, filtered);
title('Processed EMG Data from BioCapture');
xlabel('Time (s)');
ylabel('Amplitude');
%% Question 2 
noise = raw - filtered;
Fs = 2000;

% SNR plot with annotations for DC, fundamental frequency, and harmonics
snr(raw, Fs);

% Noise power
[SNR, npow] = snr(raw, Fs);
sprintf('SNR of the raw signal is %2.2f.', SNR)
sprintf('Noise power of the raw signal is %2.2f dB.', npow)

%% Question 3

figure(1)
filteredFFT = fft(filtered);
freqAxisF = (0:length(filtered)-1)*2000/length(filtered);
plot(freqAxisF, real(filteredFFT));
title('Real Component of the FFT of the Pre-Processed EMG Data');
xlabel('Frequency (Hz)');
ylabel('Amplitude of the Real Component');


figure(2)
rawFFT = fft(raw);
freqAxisR = (0:length(raw)-1)*2000/length(raw);
plot(freqAxisR, real(rawFFT));
title('Real Component of the FFT of the Raw EMG Data');
xlabel('Frequency (Hz)');
ylabel('Amplitude of the Real Component');
%BUTTERWORTH4TH Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.8 and Signal Processing Toolbox 8.4.
% Generated on: 28-Jan-2022 20:28:20

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 2000;  % Sampling Frequency

N   = 4;    % Order
Fc1 = 50;  % First Cutoff Frequency
Fc2 = 200;    % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

% Alternative filter
h2  = fdesign.bandpass('N,F3dB1,F3dB2', N, 20, 120, Fs);
Hd2 = design(h2, 'butter');

% Alternative filter
h3  = fdesign.bandpass('N,F3dB1,F3dB2', N, 100, 250, Fs);
Hd3 = design(h3, 'butter');


butt = filter(Hd, raw);
butt2 = filter(Hd2, raw);
butt3 = filter(Hd3, raw);






figure(3)
tiledlayout(3,1);
timeAxis = (0:length(butt)-1)*30/length(butt);

nexttile;
plot(timeAxis, butt)
title('Raw Data Filtered with cut-offs 50 Hz and 200 Hz');
xlabel('Time (s)');
ylabel('Amplitude of Signal');

nexttile;
plot(timeAxis, butt2)
title('Raw Data Filtered with cut-offs 20 Hz and 120 Hz');
xlabel('Time (s)');
ylabel('Amplitude of Signal');

nexttile;
plot(timeAxis, butt3)
title('Raw Data Filtered with cut-offs 100 Hz and 250 Hz');
xlabel('Time (s)');
ylabel('Amplitude of Signal');



figure(4)
tiledlayout(2,1);

nexttile;
timeAxisOG = (0:length(filtered)-1)*30/length(filtered);
plot(timeAxisOG, filtered);
title('Pre-processed EMG Data');
xlabel('Time (s)');
ylabel('Amplitude of Signal');

nexttile;
plot(timeAxis, butt)
title('Raw Data Filtered with 4th Order Butterworth Bandpass Filter');
xlabel('Time (s)');
ylabel('Amplitude of Signal');

%% Question 4

% Removing DC Offset
% Code idea obtained from user "Jan" via
% https://www.mathworks.com/matlabcentral/answers/1828-remove-dc-component-from-eeg-signals

DCremoved = butt - mean(butt);

% Full wave rectification
rectify = abs(DCremoved);

[SNR, npow] = snr(rectify, Fs);
sprintf('SNR of the full-wave rectified signal is %2.2f .', SNR)
sprintf('Noise power of the full-wave rectified signal is %2.2f dB.', npow)


figure(5)
timeAxis = (0:length(rectify)-1)*30/length(rectify);
plot(timeAxis, rectify)
title('Rectified Data Filtered with 4th Order Butterworth Bandpass Filter');
xlabel('Time (s)');
ylabel('Amplitude of Signal');

%% Question 5
% Code derived from 
% ttps://www.mathworks.com/matlabcentral/answers/783821-rms-emg-calculate-and-plot
window = 10;                                            
rmsButt10 = sqrt(movmean(rectify.^2, window));  


figure(6)
tiledlayout(3,1);

nexttile;
plot(timeAxis, rectify)
title('RMS Envelope of Filtered and Rectified Signal: Win 10');
xlabel('Time (s)');
ylabel('Amplitude');
hold on

plot(timeAxis, rmsButt10, '-r', 'LineWidth',1.5)
hold off

grid
legend('EMG',sprintf('RMS (Window Length = %d)',window), 'Location','best')


nexttile;
window = 50;                                            
rmsButt50 = sqrt(movmean(rectify.^2, window));  
plot(timeAxis, rectify)
title('RMS Envelope of Filtered and Rectified Signal: Win 50');
xlabel('Time (s)');
ylabel('Amplitude');
hold on

plot(timeAxis, rmsButt50, '-r', 'LineWidth',1.5)
hold off

grid

legend('EMG',sprintf('RMS (Window Length = %d)',window), 'Location','best')

nexttile;
window = 200;                                            
rmsButt200 = sqrt(movmean(rectify.^2, window));  
plot(timeAxis, rectify)
title('RMS Envelope of Filtered and Rectified Signal: Win 200');
xlabel('Time (s)');
ylabel('Amplitude');
hold on

plot(timeAxis, rmsButt200, '-r', 'LineWidth',1.5)
hold off

grid

legend('EMG',sprintf('RMS (Window Length = %d)',window), 'Location','best')
%% Question 6

RectTime = [rmsButt10, transpose(timeAxis)];

% Desired period of calculation is between 13 - 14.5 seconds 
Area = trapz(RectTime(22843:25391,2), RectTime(22843:25391,1));

% Desired period of calculation is between 14 - 17 seconds
%Area = trapz(RectTime(24601:30750,2), RectTime(24601:30750,1));


%% Question 7

% The more accurate way of doing this would be to take the filtered data
% that we have either made, or collected, taking one of the initial spikes
% and dividing it by one of the latter spikes. The 3 last spikes refer to
% an MVC trial regardless, so the most accurate normalized EMG value would
% have to be calculated this way (Source: BMEG 330)

% First Flexion occurs between 7 and 9 seconds
% First MVC occurs between 14.5 and 19 seconds
% Choosing any consisten one second interval from both of those periods
% allows us to calculate our normalized EMG

FirstFlexion = RectTime(13179:14849, 1); %7.5 to 8.5s
MVC = RectTime(27236:28906,1); %15.5 to 16.5s

NormalizedEMG = FirstFlexion./MVC;
timeAxis = (0:length(NormalizedEMG)-1)*1/length(NormalizedEMG);
sprintf('The Normalized RMS EMG value is %2.2f.', mean(NormalizedEMG))

plot(timeAxis, NormalizedEMG)
title('Normalized EMG plot for 1s muscle activation/MVC');
xlabel('Time (s)');
ylabel('Amplitude of Signal');