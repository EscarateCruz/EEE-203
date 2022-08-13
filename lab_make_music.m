clear all; close all; 

% MATLAB script to generate the theme song of "Star Wars"
% and perform audio editing
% Author: Chao Wang
% Task: Complete and run the script. 
% The places you need to add code start with a capitized word, such as
% "DEFINE", "GENERATE" and etc.

%% make music
% define music note frequencies used in the song in Hz
fg3 = 196; 
fc4 = 261.63;
fg4 = 392;

% DEFINE the frequencies ff4, fe4, fd4 and fc5 for notes f4, e4, d4 and c5
ff4 = 349.23;
fe4 = 329.63;
fd4 = 293.66;
fc5 = 523.25;

% based on the note frequency table in the lab manual 






one_beat = 0.75; % time duration of a one-beat note in sec
fs = 44100; % sampling frequency in Hz
t_one = 0:1/fs:one_beat; % time vector for a one-beat note
t_third = 0:1/fs:one_beat/3; % time vector for a one-third-beat note
t_two = 0:1/fs:2*one_beat; % time vector for a two-beat note

% DEFINE time vector for a half-beat note t_half

t_half = 0:1/fs:one_beat/2;




% generate sound wave sinusoids in "melody1" below
g3_third = sin(2*pi*fg3*t_third);
c4_two = sin(2*pi*fc4*t_two);
g4_two = sin(2*pi*fg4*t_two);

% GENERATE sound wave sinusoids for the rest of the song


% define f4_third, e4_third, d4_third, c5_two, g4_one, d4_two and g3_half

f4_third = sin(2*pi*ff4*t_third);
e4_third = sin(2*pi*fe4*t_third);
d4_third = sin(2*pi*fd4*t_third);
c5_two = sin(2*pi*fc5*t_two);
g4_one = sin(2*pi*fg4*t_one);
d4_two = sin(2*pi*fd4*t_two);
g3_half = sin(2*pi*fg3*t_half);




% create melody vectors
melody1 = [g3_third, g3_third, g3_third, c4_two, g4_two];
melody2 = [f4_third, e4_third, d4_third, c5_two, g4_one];
melody3 = [f4_third, e4_third, f4_third, d4_two];



% the beginning of the song is given below, 
% MODIFY it to assemble the whole song
% the complete music score is in the lab manual
song = [melody1, melody2, melody2, melody3, melody1, melody2, melody2, melody3];

% write the song to a file and can be played later using a music player
audiowrite('star_wars.wav', song, fs); 

soundsc(song, fs) % play the song
pause % need to press any key to continue


%% speed up the song (1.5 times of original speed)
soundsc(song, 1.5*fs) 
pause

%% WRITE code to slow down the song (3/4 of original speed) 
soundsc(song, 0.75*fs) 
pause



%% fade in and fade out
% The "loudness" of a signal is manipulated by multiplying a scale factor 
% to each sample. Fade in is from quiet to loud and fade out is from loud
% to quiet. Here a linear scale from 0 to 1 is used. Suppose there are five 
% samples,each of them has magnitude A. If played regularly, it should 
% sound like A, A, A, A, A. For fading in, the magnitudes would be 0, A/4, 
% 2A/4, 3A/4, A. For fading out, the magnitudes would be A, 3A/4, 2A/4, 
% A/4, 0.

% MODIFY the fade_in_time and fade_out_time to 
% fade in the beginning (the first line, i.e., three measures including 
% the pick up note) and
% fade out in the end (last two measurs on the last line) 
% Note: given the value of the variable "one_beat" and the number
% of beats in the fade-in, fade-out section from the music score, 
% you take the product of the two to give you the fade-in and fade-out time. 
fade_in_time = 7.5; % fade in time in sec
fade_in_num_sample = fade_in_time*fs; % number of samples in fade-in
fade_in_factor =  0:1/(fade_in_num_sample-1):1; % linear fade
fade_in_seg = song(1:fade_in_num_sample).*fade_in_factor; % scale

fade_out_time = 6.75; % fade out time in sec
fade_out_num_sample = fade_out_time*fs; % number of samples in fade-out
fade_out_factor = 1:-1/(fade_out_num_sample-1):0; % linear fade
% end: last index of an array
fade_out_seg = song(end-fade_out_num_sample+1 : end).*fade_out_factor; % scale
% the middle unchanged segment
middle_seg = song(fade_in_num_sample+1 : end-fade_out_num_sample); 

song_faded = [fade_in_seg, middle_seg, fade_out_seg];
soundsc(song_faded, fs)
pause


%% play in reverse
% WRITE the code to play the song in reverse, hint: fliplr function

soundsc(fliplr(song), fs) 
pause

