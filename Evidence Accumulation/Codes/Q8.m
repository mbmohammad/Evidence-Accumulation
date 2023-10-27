clc;clear all;close all;
% Define the input parameters
theta_p = 1;
theta_n = -1;
bias_p = 0.4;
bias_n = -0.05;
sigma_p = 1;
sigma_n = 1;
time = 3;
x0 = 0;
% Generate 1000 trials and record the RTs and responses
n_trials = 10000;
rt = zeros(n_trials, 1);
response = zeros(n_trials, 1);
for i = 1:n_trials
    [rt(i), response(i)] = race_trial_mod(theta_p, theta_n, bias_p, bias_n, sigma_p, sigma_n, x0, time);
end

% Plot the histogram of correct and incorrect response RTs
figure;
histogram(rt(response == 1), 30, 'FaceColor', 'green', 'EdgeColor', 'none');
hold on;
histogram(rt(response == -1), 30, 'FaceColor', 'red', 'EdgeColor', 'none');
xlabel('Reaction Time (s)', 'interpreter', 'latex');
ylabel('Frequency', 'interpreter', 'latex');
legend('Correct Response', 'Incorrect Response', 'interpreter', 'latex');
C = "$\theta_n = $ "+ num2str(theta_n)+ " $\theta_p = $ "+ num2str(theta_p)+...
    " $B_p$ = "+  bias_p+ " $B_n=$ "+  bias_n+ " $\sigma_p=$ "+  sigma_p +" $\sigma_n=$ "  +sigma_n +" $ x_0 = $ " +x0;
title(C, 'interpreter', 'latex')





%%
function [rt, response] = race_trial_mod(theta_p, theta_n, bias_p, bias_n, sigma_p, sigma_n, x0, time)
    % Set the time step and initialize the evidence, time, and threshold variables
    dt = 0.1;
    x_p = x0;
    x_n = x0;
    t = 0;
    % Initialize the response variable
    response = 0;
    % Loop until one of the accumulators exceeds its threshold
    while t < time
        % Update the evidence for each accumulator by adding a new sample from the random walk
        r = randn();
        x_p = x_p + bias_p * dt + sigma_p * sqrt(dt) * r;
        x_n = x_n + bias_n * dt + sigma_n * sqrt(dt) * r;
        % Update the time step
        t = t + dt;
        % Exit the loop if the thr time has been reached
        if x_p >= theta_p
        response = 1;
        break;
        elseif x_n <= theta_n
        response = -1;
        break;
        end
    end
    if(response==0)
        if(abs(x_p - theta_p)>abs(x_n - theta_n))
            response = -1;
        elseif(abs(x_p - theta_p)<=abs(x_n - theta_n))
        response = 1;
        end
    end
    % Record the response and calculate the reaction time and response direction
    
    rt = t;
end