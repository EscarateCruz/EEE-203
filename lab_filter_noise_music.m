% Application of a low pass filter 
% to filter out noise in an audio file
% Author: Chao Wang
%
% Task: Complete and run the script. 
% The places you need to add code start with a capitized word. 
close all; clear all;
 
% "music_with_noise.wav" is a stereo audio file with two channels
% left and right, the audio file was from 
% https://web.stanford.edu/class/me161/labs/filter_lab/
% download the file from Blackboard,
% make sure the file is in the same directory of this matlab script

%% WRITE code to import the audio and plot its FFT as the 1st of three
% subplots, see fft_star_wars.m for an example
[x, fs] = audioread('music_with_noise.wav'); 



%soundsc(x, fs) % sound is autoscaled as loud as possible without clipping
pause % need any key to listen to next tone

N = length(x);
Z = fft(x)/N;  % generate FFT and divide by num of points to normalize FFT;
f = fs*linspace(0,1, N) - fs/2;   % generate frequency vector
Z1 = fftshift(abs(Z));

figure
subplot(3, 1, 1)
plot(f, Z1);
ylabel('|X(f)|'); xlabel('Frequency (Hz)')
title('Frequency Content of Unfiltered Input Signal')



%% build filter
% The code below shows an example on how to build and use a digital filter.
% CHANGE the cutoff frequency below to properly filter the noise
cutoff = 650 ; % cutoff frequency (Hz) for the filter
            
% build a 5th-order butterworth low pass digital filter 
% to keep the music but filter out the noise
% b: numerator coeff of system transfer function, a: denominator coeff
% system transfer function is discussed in section 9.7 of the textbook.
%
% In the command below, 5 is the order of the filter, the second parameter
% specify the cutoff frequency (with value between 0 and 1), which is
% normalized to half the sample rate, 'low' denotes the type of the filter,
% i.e., low pass filter

[b, a] = butter(5, cutoff/(fs/2), 'low'); 

sys = tf(b, a, 1/fs); % filter system transfer function

H = freqz(b, a, f, fs); % get frequency response of filter

subplot(3, 1, 2)
plot(f, abs(H)) % plot frequency response (magnitude) of filter
ylabel('|H(f)|'); xlabel('Frequency (Hz)')
title('Filter Characteristics')


%% Signal processing: pass the input through the lowpass filter
% The following three methods should give the same output. 
% You can try each one by commmenting out the other two
% Method 1 (most commonly used)
y = filter(b, a, x); % using difference equation

% % Method 2: y[n]=x[n]*h[n]
% h = impz(b,a); % get impulse response
% y(:,1) = conv(x(:,1),h); % time domain convolution
% y(:,2) = conv(x(:,2),h);

% % Method 3: Y(e^jw)=X(e^jw)H(e^jw)
% f = 0 : fs/(N-1) : fs;
% H = freqz(b, a, f, fs); % freq response
% Y(:,1) = X(:,1).*H'; % freq domain multiplication
% Y(:,2) = X(:,2).*H';
% y = real(ifft(Y)); % inverse Fourier transform

soundsc(y , fs) % sound is autoscaled as loud as possible without clipping

%% plot frequency content of filter output
N = length(y);
Y = fft(y)/N;  % generate FFT and divide by num of points to normalize FFT;
f = fs*linspace(0,1, N) - fs/2;   % generate frequency vector
Y1 = fftshift(abs(Y)); % magnitude of the double-sided spectrum

subplot(3, 1, 3)
plot(f,Y1);
% uncomment the following line to zoom in to a particular freq range 
%xlim([0 1000]) 
ylabel('|Y(f)|'); xlabel('Frequency (Hz)')
title('Frequency Content of Filtered Output Signal')

