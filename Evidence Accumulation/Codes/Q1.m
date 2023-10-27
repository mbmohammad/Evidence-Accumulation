%%
clear all; close all;clc;
n = 20;
choices = zeros(1, n);
bias = -0.2;
sigma = 1.5;
figure
for i = 1 : n
[choice, output_signal] = simple_model(bias, sigma, 0.1, 10);
subplot(4,5,i);plot(output_signal)
choices(i) = choice;
end
figure
histogram(choices)
title("$\sigma$ = " + sigma + ", $B $ = " + bias, 'interpreter', 'latex')
xlabel("Choice", 'interpreter', 'latex')
ylabel("Frequency", 'interpreter', 'latex')
%%
function [choice, output_signal] = simple_model(bias, sigma, dt, time_interval)
% Set initial values
x0 = 0; % start point
x = x0; % initialize the decision variable x
N = time_interval / dt; % number of time steps
output_signal = zeros(1, N);
for i = 1:N
    % Update the decision variable
    x = x + bias*dt + sigma*sqrt(dt)*randn();
    output_signal(i) = x;
end
% Determine the response based on the final value of the decision variable
if x > 0
    choice = 1; % Go signal
else
    choice = 0; % No Go Signal
end
end