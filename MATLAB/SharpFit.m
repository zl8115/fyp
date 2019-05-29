close all, clear all;

% This MATLAB script is supposed to attempt to fit the obtained sharpness
% curve with the a rough approximation

% Select trialSet to fit model approximation
trialSet = "Trial1";

% Load Sharpness Reference Data
load('SharpData.mat');
eval(sprintf('nameList = %s.nameList',trialSet));
eval(sprintf('sharp1 = %s.sharp1',trialSet));

% Bell Curve/Gaussian Distribution Model
f = @(x,mu,sigma) exp((-1/2)*((x-mu)/sigma).^2);

% Define mu and sigma
mu = nameList(sharp1 == max(sharp1));
sigma = 20; % Rough estimate

% Define Observable Range
x = [-292:1:292];

% Additional Scaling Factors, Offset and Amplitude
A = max(sharp1) - min(sharp1);
B = mean(sharp1);

% Figure Plot
figure; hold on;
plot(x,A*f(x,mu,sigma)+B);
plot(nameList,sharp1);