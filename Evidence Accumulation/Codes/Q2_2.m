%% Set parameters
clc; clear all; close all;
time_interval = 10;
sigma = 1;
dt = 0.1;

% Simulate the trials
biases = [1, 10, 0, 0.1, -1];
for j = 1:length(biases)
    bias = biases(j);
    [choice, x] = simple_model_modified(bias, sigma, dt, time_interval);
    choice
    % Plot the time course of the decision variable
    plot(0:dt:time_interval-dt,x);
    hold on;
end
xlabel('Time (s)', 'interpreter', 'latex');
ylabel('Decision variable', 'interpreter', 'latex');
title('Time course of the evidence', 'interpreter', 'latex')
legend('B=1','B=10','B=0','B=0.1','B=-1','location', 'northWest');
%% 
function [choice, x] = simple_model_modified(bias, sigma, dt, time_interval)

% Set initial values
N = time_interval / dt; % number of time steps
x = zeros(1, time_interval/dt);% initialize the decision variable x
    x(1) = 0;

for i = 2:N
    % Update the decision variable
    x(i) = x(i-1) + bias*dt + sigma*sqrt(dt)*randn();
end

% Determine the response based on the final value of the decision variable
if x(N) > 0
    choice = 1; % Go signal
else
    choice = 0; % No Go Signal
end

end