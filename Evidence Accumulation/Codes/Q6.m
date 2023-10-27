% Define the input parameters
clc; clear all;close all
theta_p = 1;
theta_n = -1;
sigma = 1;
x0 = 0;
bias = 0.5;


% Generate 1000 trials and record the RTs and responses
n_trials = 10000;
rt = zeros(n_trials, 1);
response = zeros(n_trials, 1);
for i = 1:n_trials
    [rt(i), response(i)] = two_choice_trial(theta_p, theta_n, sigma, x0, bias);
end

% Plot the histogram of correct and incorrect response RTs
figure;
histogram(rt(response == 1), 50, 'FaceColor', 'green', 'EdgeColor', 'none', 'Normalization', 'pdf');
hold on;
histogram(rt(response == -1), 50, 'FaceColor', 'red', 'EdgeColor', 'none', 'Normalization', 'pdf');
xlabel('Reaction Time (s)', 'interpreter', 'latex');
ylabel('Frequency', 'interpreter', 'latex');
legend('Correct Response', 'Incorrect Response', 'interpreter', 'latex');
title(sprintf('Normalized Reaction Times Frequency for Bias = %.2f ', bias), 'interpreter', 'latex')


%%
function [rt, response] = two_choice_trial(theta_p, theta_n, sigma, x0, bias)
    % Set the time step and initialize the evidence and time variables
    dt = 0.1;
    x = x0;
    t = 0;
    % Initialize the response variable
    response = 0;
    % Loop until the evidence reaches one of the thresholds
    while x > theta_n && x < theta_p
        % Update the evidence by adding a new sample from the random walk
        x = x + bias * dt + sigma * sqrt(dt) * randn();
        % Update the time step
        t = t + dt;
    end
    % Record the response and calculate the reaction time
    if x >= theta_p
        response = 1;
    elseif x <= theta_n
        response = -1;
    end
    rt = t;
end