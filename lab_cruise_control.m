% Demonstration of Cruise Control 
% Using PI (Proportional and Integral) Controller 
% Author: Chao Wang
%
% Task: Complete and run the script. 
% The places you need to add code start with a capitized word. 
clear all; close all;

% This example is adapted from 
% http://ctms.engin.umich.edu/CTMS/index.php?example=CruiseControl&section=ControlPID
% A good tutorial on PID controller can be found at 
% http://ctms.engin.umich.edu/CTMS/index.php?example=Introduction&section=ControlPID
m = 1300; % mass of the car in kg
b = 60; % damping coefficient in Ns/m
v0 = 18; % reference car speed in m/s (40mph)

% Kp can be used to decrease rise time and decrease steady state error,
% however, too large of Kp can't be achieved realistically due to 
% actuator constraint, such as engine and drivetrain power limitations.
% let's assume Kp have to be less than 1000 here.
% It has to be used in conjunction with Ki, which decreases rise time  
% and eliminates steady state error. However if too large a Ki is used, 
% overshoot can occur.
%
% MODIFY Kp and Ki to satisfy design requirements 
% You can use the following range to try out the values for Kp and Ki
% but you don't have to because there are other values that could satisfy 
% the design requirements. They are given to make your search easier
% since there are only 15 combinations, note more than one pair of values 
% for Kp and Ki could satisfy the requirement, i.e., the answer is not 
% unique. 
% 800 < Kp < 1000 (use step 50), 40 < Ki < 70 (use step 5)
% Also try out the following parameters to see what can go wrong: 
% Kp = 100, Ki = 0 (doesn't converge to 18 m/s not satisfy requirement) 
% Kp = 100, Ki = 100 (big overshoot not satisfy requirement) 
Kp = 950; % proportional control constant
Ki = 60; % integral control constant


% set up the closed loop control system function
% from input x(t) (desired speed) and output v(t) (actual speed)
s = tf('s'); % set up to have the tranfer function written in s directly
Hp = 1/(m*s+b) % plant transfer function
Hc = Kp + Ki/s % controller transfer function

% calculate the system transfer function by hand and compare 
H = feedback(Hc*Hp, 1) % system transfer function

% if all poles have negative real parts, the system is stable
pole(H)

% plot the actual speed v(t) when the desired speed x(t) is a step
% function, i.e., 
% generate output v(t) of a feedback system H, when the system input is 
% a unit step function x(t)=v0u(t).
% Since the unit step function has magnitude v0, the output
% is also scaled. 
[v, t] = step(H); % generate step response
v = v0*v; % scaled output due to unit step has magnitude v0
plot(t, v)
xlabel('t (second)')
ylabel('v(t) (m/s)')
str = sprintf('Kp = %d, Ki = %d', Kp, Ki);
legend(str);

% get step response characteristics, which are used to determine
% if the controller is able to satisfy the required performance metrics
S = stepinfo(v,t,v0) % v and t are step response data
                     % v0 is the steady state value

% Definitions of the step response metrics
% RiseTime: the time to cross from 10% to 90% of final state/reference
% level
% SettlingTime: the time to reach and remain within 2% tolerance region
% of the final state level
% SettlingMin: minimum value after the response has risen to 90%.
% SettlingMax: maximum value after the response has risen to 90%
% Overshoot: the greatest absolute percentage deviation larger than the 
% final state level
% Undershoot: the greatest absolute percentage deviation below the final 
% state level
% Peak: peak absolute value
% PeakTime: time at which this peak is reached
