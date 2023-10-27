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