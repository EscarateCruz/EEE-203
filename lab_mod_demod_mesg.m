% MATLAB script to implement double sideband, full carrier amplitude 
% modulation and demodulation
% Author: Chao Wang
%
% Task: Complete and run the script. 
% The places you need to add code start with a capitized word. 
clear all; close all;

Fc = 1.885e6; % carrier frequency, amateur radio 160-meter band
B = 4000; % bandwidth for voice is 4KHz (refer to Figure 2 in the 
          % amplitude modulation tutorial)

% In Figure 3 of the tutorial, Fc + B will be signal frequency upper bound
% (actual max signal frequency could be smaller than this)
% Due to the Nyquist theorem, sampling frequency for modulated data 
% must satisfy Fs>=2*(Fc+B)
Fs = 2*(Fc+B);

mu = 1; % adjust modulation index 
A = 1/mu; % carrier ampitude (based on the definition of modulation index)

%% This is the code used to modulate the message.
% % You only uncomment this part if you are ready to do Task 8. 
% % It will take a while to run. 
% [m, Fsm] = audioread('lunch.wav'); % read in the message, 
% % sampling rate Fsm = 8000Hz satisfies the Nyquist theorem given
% % the max voice freqency is 4KHz. Note this is different from Fs above. 
% % Fsm is the sampling rate for the original signal, whereas 
% % Fs is the sampling rate for the modulated signal.
% plot(m) % plot the message
% 
% %% AM modulation
% % upsample input signal from Fs to Fsm to satisfy Nyquist
% data_for_mod_resampled = resample(m, Fs, Fsm); 
%
% % modulate with carrier signal
% % Syntax Y = ammod(X,Fc,Fs,INI_PHASE,CARRAMP), i.e. use 
% % c(t) = CARRAMP*cos(2*pi*Fc*t+INI_PHASE) (equation 1 in the tutorial)
% % to modulate signal X with sampling frequency Fs. 
% % Here CARRAMP = A, INI_PHASE = 0. 
% am_modulated_data = ammod(data_for_mod_resampled, Fc, Fs, 0, A);
% 
% figure
% plot(am_modulated_data) % plot the modulated message
% 
% dlmwrite('lunch_modulated.txt', am_modulated_data) % write data to file


%% WRITE code to perform AM demodulation
% make sure the file is in the same directory as this matlab script
% and the file is UNZIPPED.
am_modulated_data = dlmread('lunch_modulated.txt'); % read modulated data

% demodulate the message using "amdemod" function
% Syntax Z = amdemod(Y,Fc,Fs,INI_PHASE,CARRAMP), see line 36 for the 
% definition of the parameters in the ammod function



% down sampling so that the signal can be played by a speaker
% use the "resample" function (note line 33 shows how to upsample) 
% to downsample from Fs to Fsm
% (you need to first define Fsm, Fs is already defined)




% plot recovered message



% play message using the original sampling frequency Fsm
