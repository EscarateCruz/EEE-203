% Convolution reverb in audio processing
% Author: Chao Wang
% The impulse response of a system/renue/environment is recorded
% while a pseudo audio impulse is played, such as a loud clap or any loud
% short bang. 
% The impulse responses of the Milan Opera Hall and St Nicolas Church 
% are downloaded from http://www.voxengo.com/files/impulses/
% The impulse responses of the Grand Canyon is downloaded from 
% http://eleceng.dit.ie/dorran/matlab/impulse_responses/
%
% Task: Complete and run the script. 
% The places you need to add code start with a capitized word. 

close all; clear all;
% make sure all .wav files are in the same directory of this script
% all audio files are sampled at 44100Hz

% import, plot and play singing recording
% the two parameters returned from audioread are the signal vector and 
% the sampling frequency
[song, fs] = audioread('singing.wav'); % import the song

t = [1:length(song)]/fs; % change from vector index number to time
subplot(3, 1, 1) % first plot of the three plots in the plot window
plot(t, song) % plot the song
xlabel('t (second)')
ylabel('Relative signal strength')
title('Song')
soundsc(song, fs) % play the song
pause % need to press spacebar to continue the progam to listen to next tone

% USE the code segment above as an example
% now import, plot and play the impulse response

[impulse, fs] = audioread('GrandCanyon.wav'); % import the song
t = [1:length(impulse)]/fs;

subplot(3, 1, 2)

plot(t, impulse) % plot the song
xlabel('t (second)')
ylabel('Relative signal strength')
title('Impulse')
soundsc(impulse, fs)
pause

% CONVOLUTE the audio with the system impulse responses 
% using the command conv(sig1, sig2) and assign the result
% to a variable. The convolution could take a couple of seconds
% to complete.

conv = conv(song, impulse);

% Generate the time t vector as shown in the example above. 
% Plot and play the output as shown in the example above, and
% it should sounds as if it was actually recorded in those spaces

t = [1:length(conv)]/fs;

subplot(3, 1, 3)
plot(t, conv) % plot the song
xlabel('t (second)')
ylabel('Relative signal strength')
title('Convoluted Song')
soundsc(conv, fs)