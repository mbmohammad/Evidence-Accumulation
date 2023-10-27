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