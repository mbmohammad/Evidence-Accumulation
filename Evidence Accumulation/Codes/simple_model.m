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