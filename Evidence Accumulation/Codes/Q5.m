%% Set parameters
num_trials = 20;
time_interval = 1;
bias = 1;
sigma = 1;
dt = 0.1;
% Simulate the trials
results = zeros(1, num_trials);
for i = 1:num_trials
    results(i) = simple_model2(bias, time_interval, 2);
end
% Compute and display the distribution of results
go_trials = sum(results);
no_go_trials = num_trials - go_trials;
disp('Distribution of results:');
disp(['    Go trials: ' num2str(go_trials) ' out of ' num2str(num_trials)]);
disp(['    No-go trials: ' num2str(no_go_trials) ' out of ' num2str(num_trials)]);


%%
function choice = simple_model2(bias, time_limit, start_point)
    % Calculate the standard deviation of the Brownian motion term
    sigma = sqrt(time_limit);
    
    % Calculate the mean and standard deviation of the normal distribution
    mean = bias * time_limit;
    std_dev = sigma;
    
    % Calculate the probability of the decision variable total being above the start point
    prob_above_start_point = normcdf(start_point, mean, std_dev);
    
    % Draw from a uniform random distribution to choose an option
    if rand() < prob_above_start_point
        choice = 1;
    else
        choice = -1;
    end
end