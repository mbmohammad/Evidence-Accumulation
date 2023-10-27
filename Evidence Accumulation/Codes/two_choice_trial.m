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