%% Set parameters
close all;clear all;clc
num_trials = 1000;
time_interval = 0.5:0.1: 10;
sigma = 1;
dt = 0.1;
% Simulate the trials

for k = 1 : length(time_interval)
    bias = 0.1*time_interval(k);
results = zeros(1, num_trials);
for i = 1:num_trials
    [results(i), ~] = simple_model(bias, sigma, dt, time_interval(k));
end

% Compute and display the distribution of results
go_trials(k) = sum(results);
no_go_trials(k) = num_trials - go_trials(k);
end
figure
plot(0.5:0.1: 10,no_go_trials/1000, 'LineWidth',2, 'MarkerEdgeColor','r' )
xlabel('Length of Time Interval(s)', 'interpreter', 'latex');
ylabel('Error Rate', 'interpreter', 'latex');
title('Error Rate for different Length of Time Interval in 1000 trials', 'interpreter', 'latex')

hold on
plot(0.5:0.1: 10,movmean(no_go_trials, 10)/1000,'LineWidth',1.3 )%movmean(

legend('Error Rate', ['Averaged Error Rate', ', window size = 10']);
% disp('Distribution of results:');
% disp(['    Go trials: ' num2str(go_trials) ' out of ' num2str(num_trials)]);
% disp(['    No-go trials: ' num2str(no_go_trials) ' out of ' num2str(num_trials)]);
%%
function [choice, output_signal] = simple_model(bias, sigma, dt, time_interval)

% Set initial values
x0 = 0; % start point
x = x0; % initialize the decision variable x
N = floor(time_interval / dt); % number of time steps
output_signal = zeros(1, N);

for i = 1:N
    % Update the decision variable
    x = x + bias*dt + sigma*sqrt(dt)*randn();
    output_signal(i) = x;
end

% Determine the response based on the final value of the decision variable
if output_signal(end) > 0
    choice = 1; % Go signal
else
    choice = 0; % No Go Signal
end

end