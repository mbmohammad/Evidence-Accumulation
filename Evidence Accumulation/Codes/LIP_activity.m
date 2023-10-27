function [LIP_event_times, MT_event_times_plus, MT_event_times_minus] = LIP_activity(MT_p_values, LIP_weights, LIP_threshold, Evidence_thr)
% Parameters:
% MT_p_values - a vector with 2 elements, firing probabilities for the
% excitatory and inhibitory neurons, resp.
% LIP_weights - a length 2 vector of weighting factors for the evidence
% from the excitatory (positive) and
% inhibitory (negative) neurons
% LIP_threshold - the LIP firing rate that represents the choice threshold criterion
% Evidence_thr - threshold for evidence accumulation
% use fixed time scale of 1 ms

dt=0.001;
rate=0;
N=[0 0]; % plus is first, minus is second
t=0;
LIP_event_times=[];
MT_event_times_plus = [];
MT_event_times_minus = [];

while rate<LIP_threshold
    dN = rand(1,2) < MT_p_values;
    N = N + dN;
    
    % Record event times for the two MT neurons
    if dN(1) == 1
        MT_event_times_plus = [MT_event_times_plus t];
    end
    if dN(2) == 1
        MT_event_times_minus = [MT_event_times_minus t];
    end
    
    p_lip = sum(N.*LIP_weights);
    LIP_event = Evidence_thr < p_lip;
    
    if LIP_event == 1
        LIP_event_times = [LIP_event_times t];
    end
    
    % check LIP mean rate for last M spikes
    M = 100;
    if length(LIP_event_times)>=M
        rate = M/(t-LIP_event_times(end-M+1));
    end
    t=t+dt;
end
end