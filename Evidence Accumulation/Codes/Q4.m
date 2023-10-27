%% Set parameters
clc; close all;clear all
num_trials = 5000;
time_interval = 10;
bias = 0.1;
sigma = 1;
dt = 0.1;
t = 0.1:0.1:10;
% Simulate the trials
results = zeros(1, num_trials);
out = zeros(num_trials, time_interval / dt);
for i = 1:num_trials
    [mean_dv, var_dv, results(i), output_signal] = simple_model(bias, sigma, dt, time_interval);
    out(i, :) = output_signal;
end
plotVar = sqrt(var(out));
plotMean = mean(out);
figure
plot(t, out(2,:), 'b');hold on
    plot(t,plotMean, 'r','LineWidth',3 );hold on
 plot(t,plotMean-plotVar,'c', 'LineWidth',3);hold on
plot(t,plotMean+plotVar,'g', 'LineWidth',3);
%     
% Compute and display the distribution of results
go_trials = sum(results);
no_go_trials = num_trials - go_trials;
disp('Distribution of results:');
disp(['    Go trials: ' num2str(go_trials) ' out of ' num2str(num_trials)]);
disp(['    No-go trials: ' num2str(no_go_trials) ' out of ' num2str(num_trials)]);
%%
hold on
plot(t, 0.1*t+sqrt(t), 'k', 'LineWidth',1.3)
hold on
plot(t, 0.1*t-sqrt(t),'k', 'LineWidth',1.3  )
plot(t, out(20,:), 'b');hold on
plot(t, out(200,:), 'b');hold on
plot(t, out(2000,:), 'b');hold on
plot(t, out(3000,:), 'b');hold on
legend('Decision Variable Sample', '$\mu$', '$\mu - \sigma$', '$\mu + \sigma$', '$0.1t+\sqrt t$', '$0.1t-\sqrt t$','interpreter', 'latex', 'location', 'northWest')
xlabel('Time (s)', 'interpreter', 'latex');

%%
function [mean_dv, var_dv, choice, output_signal] = simple_model(bias, sigma, dt, time_interval)

% Set initial values
x0 = 0; % start point
t = 0; % current time
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
mean_dv = mean(output_signal);
var_dv = var(output_signal);
end