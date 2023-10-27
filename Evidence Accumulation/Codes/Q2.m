%% Set parameters
num_trials = 10000;
time_interval = 1;
bias = 1;
sigma = 1;
dt = 0.1;
% Simulate the trials
results = zeros(1, num_trials);
for i = 1:num_trials
    results(i) = simple_model(bias, sigma, dt, time_interval);
end
% Compute and display the distribution of results
go_trials = sum(results);
no_go_trials = num_trials - go_trials;
disp('Distribution of results:');
disp(['    Go trials: ' num2str(go_trials) ' out of ' num2str(num_trials)]);
disp(['    No-go trials: ' num2str(no_go_trials) ' out of ' num2str(num_trials)]);
%%
function [choice, output_signal] = simple_model(bias, sigma, dt, time_interval)

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

end