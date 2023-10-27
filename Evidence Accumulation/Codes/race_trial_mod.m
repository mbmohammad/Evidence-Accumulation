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