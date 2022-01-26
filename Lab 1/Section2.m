%% Section 2
%% PART B

%Creating our audio recorder
recorder = audiorecorder(44100, 8, 1);

%Record for 3 seconds
recordblocking(recorder,3);
audioSample = getaudiodata(recorder);

%Audio recording: Commented out to not jump-scare the grader
%play(recorder)

%Defining time
timeAxis = (0:length(audioSample)-1)*3/length(audioSample);

%Plot audio sample
figure;
plot(timeAxis, audioSample);
xlabel('Time (s)');
ylabel('Mono-channel Audio Signal (-1<=y<=1)')
title("Parsa's Audio Recording");
hold on;
%%
% Recording at lower sampling rate
recorderLow = audiorecorder(1000,8,1);
recordblocking(recorderLow,3);
audioSampleLow = getaudiodata(recorderLow);
%Audio recording: Commented out to not jump-scare the grader
%play(recorder)

%Defining time
timeAxis = (0:length(audioSampleLow)-1)*3/length(audioSampleLow);

%Plot audio sample
plot(timeAxis, audioSampleLow);
xlabel('Time (s)');
ylabel('Mono-channel Audio Signal (-1<=y<=1)')
title("Parsa's Audio Recording (Low Frequency)");
hold off

%% PART C
%FFT of our audio sample
AudioFFT = fft(audioSample);
figure(3);
plot(AudioFFT)
title('Imaginary and Real Component of the FFT of the Audio Signal');
xlabel('Amplitude of the Real Component');
ylabel('Amplitude of the Imaginary Component');
%Designing a frequency axis
freqAxis = (0:length(audioSample)-1)*44100/length(audioSample);
%Real Component
realComp = real(AudioFFT);
%Plotting Results
figure(4);
plot(freqAxis,realComp)
title('Real Component of the FFT of the Audio Signal');
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of the Real Component');

%% PART D
%Adding our noise
addNoise = awgn(audioSample, 30);
noiseFFT = fft(addNoise);

%Plotting noise
figure(5)
plot(freqAxis,real(noiseFFT))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('Noisy Signal in Frequency Domain');

timeAxis = (0:length(addNoise)-1)*3/length(addNoise);
figure(6)
plot(timeAxis,addNoise)
xlabel('Time (s)');
ylabel('Amplitude of Signal');
title('Noisy Signal in Time Domain');

%sound(addNoise, 44100)

%Designing a low-pass filter
lpFilt = designfilt('lowpassfir', 'PassbandFrequency', 200, 'StopbandFrequency', 1000, 'PassbandRipple', 1, 'StopbandAttenuation', 95, 'SampleRate', 44100);

%Visualize the filter
fvtool(lpFilt)

%Filtering the noisy signal
audioFilt = filter(lpFilt, addNoise);

%Plotting the original signal, the noisy signal, and the filtered signal
figure(7)
fftFilt = fft(audioFilt);

plot(freqAxis,real(AudioFFT));
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('Original Signal in Frequency Domain');

figure(8)
plot(freqAxis,real(noiseFFT));
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('Noisy Signal in Frequency Domain');

figure(9)
plot(freqAxis, real(fftFilt))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('Filtered Signal in Frequency Domain');

%% Part E
%Open the Impulse response folder to run the code
[h1, Fs1] = audioread('Batcave.wav');
[h2, Fs2] = audioread('BatteryBenson.wav');
[h3, Fs3] = audioread('CathedralRoom.wav');

% Removes the second audio channel - effectively making it Mono
h1 = h1(1:end,1);
h2 = h2(1:end,1);
h3 = h3(1:end,1);

% Adds 0's to the array so that the size (and time domain) match the
% original audio sample
h1(numel(audioSample)) = 0;
h2(numel(audioSample)) = 0;
h3(numel(audioSample)) = 0;

% Convoluted audio signals
y1 = conv2(h1,audioSample);
y2 = conv2(h2,audioSample);
y3 = conv2(h3,audioSample);

% Playing Convoluted audio (Commented out to not hurt your ears)
%sound(x1, 44100)
%sound(x2, 44100)
%sound(x3, 44100)

%Defining time
timeAxis1 = (0:length(y1)-1)*3/length(y1);
timeAxis2 = (0:length(y2)-1)*3/length(y2);
timeAxis3 = (0:length(y3)-1)*3/length(y3);

%Plot audio sample
figure(10);
plot(timeAxis1, y1);
xlabel('Time (s)');
ylabel('Convoluted Audio Signal Strength')
title("Batcave Simulation");

figure(11);
plot(timeAxis2, y2);
xlabel('Time (s)');
ylabel('Convoluted Audio Signal Strength')
title("Artillery Simulation");

figure(12);
plot(timeAxis3, y3);
xlabel('Time (s)');
ylabel('Convoluted Audio Signal Strength')
title("Cathedral Simulation");
%%
X = fft(audioSample);
H1 = fft(h1);
H2 = fft(h2);
H3 = fft(h3);

Y1 = X.*H1;
Y2 = X.*H2;
Y3 = X.*H3;

freqAxisY1 = (0:length(Y1)-1)*44100/length(Y1);
freqAxisY2 = (0:length(Y2)-1)*44100/length(Y2);
freqAxisY3 = (0:length(Y3)-1)*44100/length(Y3);

freqAxisy1 = (0:length(y1)-1)*44100/length(y1);
freqAxisy2 = (0:length(y2)-1)*44100/length(y2);
freqAxisy3 = (0:length(y3)-1)*44100/length(y3);

y1FFT = fft(y1);
y2FFT = fft(y2);
y3FFT = fft(y3);

figure(13)
plot(freqAxisY1,real(Y1))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('Element wise Multiplication: Y1 in the Frequency Domain');

figure(14)
plot(freqAxisY2,real(Y2))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('Element wise Multiplication: Y2 in the Frequency Domain');

figure(15)
plot(freqAxisY3,real(Y3))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('Element wise Multiplication: Y3 in the Frequency Domain');

figure(16)
plot(freqAxisy1,real(y1FFT))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('FFT of y1 in the Frequency Domain');


figure(17)
plot(freqAxisy2,real(y2FFT))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('FFT of y2 in the Frequency Domain');

figure(18)
plot(freqAxisy3,real(y3FFT))
xlabel('Frequency (10^4 Hz)');
ylabel('Amplitude of Signal');
title('FFT of y3 in the Frequency Domain');

%%
Y1 = ifft(Y1);
Y2 = ifft(Y2);
Y3 = ifft(Y3);

%%
%Plot audio sample
figure(19);
tiledlayout(3,1);

nexttile;
plot(timeAxis1, y1);
xlabel('Time (s)');
ylabel('Signal Strength')
title("Batcave Simulation");

nexttile;
plot(timeAxis2, y2);
xlabel('Time (s)');
ylabel('Signal Strength')
title("Artillery Simulation");

nexttile;
plot(timeAxis3, y3);
xlabel('Time (s)');
ylabel('Signal Strength')
title("Cathedral Simulation");

%%
Horror = conv2(audioSample, audioSample);
