close all, clear all;

% Load Sharpness Reference Data
load('SharpData.mat');
nameList = Trial1.nameList;
sharp1 = Trial1.sharp1;

% Bell Curve/Gaussian Distribution Model
f = @(x,mu,sigma) exp((-1/2)*((x-mu)/sigma).^2);

% Define mu and sigma
mu = nameList(sharp1 == max(sharp1));
sigma = 20;

% Define Observable Range
x = [-292:1:292];

% Additional Scaling Factors, Offset and Amplitude
A = max(sharp1) - min(sharp1);
B = mean(sharp1);

% Figure Plot
figure; hold on;
plot(x,A*f(x,mu,sigma)+B);
plot(nameList,sharp1);