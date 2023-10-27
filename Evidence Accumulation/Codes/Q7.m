clc;clear all;close all;
% Define the input parameters
theta_p = 3;
theta_n = -1;
bias_p = 0.05;
bias_n = -0.05;
sigma_p = 1;
sigma_n = 1;
x0 = 0.25;
% Generate 1000 trials and record the RTs and responses
n_trials = 10000;
rt = zeros(n_trials, 1);
response = zeros(n_trials, 1);
for i = 1:n_trials
    [rt(i), response(i)] = race_trial(theta_p, theta_n, bias_p, bias_n, sigma_p, sigma_n, x0);
end

% Plot the histogram of correct and incorrect response RTs
figure;
histogram(rt(response == 1), 20, 'FaceColor', 'green', 'EdgeColor', 'none');
hold on;
histogram(rt(response == -1), 20, 'FaceColor', 'red', 'EdgeColor', 'none');
xlabel('Reaction Time (s)', 'interpreter', 'latex');
ylabel('Frequency', 'interpreter', 'latex');
legend('Correct Response', 'Incorrect Response', 'interpreter', 'latex');
C = "$\theta_n = $ "+ num2str(theta_n)+ " $\theta_p = $ "+ num2str(theta_p)+...
    " $B_p$ = "+  bias_p+ " $B_n=$ "+  bias_n+ " $\sigma_p=$ "+  sigma_p +" $\sigma_n=$ "  +sigma_n +" $ x_0 = $ " +x0;
title(C, 'interpreter', 'latex')
%%
function [rt, response] = race_trial(theta_p, theta_n, bias_p, bias_n, sigma_p, sigma_n, x0)
    % Set the time step and initialize the evidence, time, and threshold variables
    dt = 0.1;
    x_p = x0;
    x_n = x0;
    t = 0;
    % Initialize the response variable
    response = 0;
    % Loop until one of the accumulators exceeds its threshold
    while x_p < theta_p && x_n > theta_n
        % Update the evidence for each accumulator by adding a new sample from the random walk
        r = randn();
        x_p = x_p + bias_p * dt + sigma_p * sqrt(dt) * r;
        x_n = x_n + bias_n * dt + sigma_n * sqrt(dt) * r;
        % Update the time step
        t = t + dt;
    end
    % Record the response and calculate the reaction time and response direction
    if x_p >= theta_p
        response = 1;
    elseif x_n <= theta_n
        response = -1;
    end
    rt = t;
end