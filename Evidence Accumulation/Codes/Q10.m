%%
clc;clear all;close all;
% Generate random stimulus vectors
num_presentations = 10;
T = 1000;
stimuli = randi([0 1], num_presentations, T);

% Generate random firing probability matrices
MT_p_values = rand(2,T,num_presentations);

% Set LIP weights and thresholds
LIP_weights = [1 -1];
LIP_threshold = 50;
Evidence_thr = 100;

% Iterate over presentations
for i = 1:num_presentations
    stimulus = stimuli(i,:);
    p_values = MT_p_values(:,:,i);
    [MT_event_times, LIP_event_times] = MT_LIP_activity(stimulus, p_values, LIP_weights, LIP_threshold, Evidence_thr);
    
    % Plot MT and LIP activity patterns
    figure;
    subplot(2,1,1);
    plot_raster(MT_event_times, T, 'MT Neurons');
    subplot(2,1,2);
    plot_raster(LIP_event_times, T, 'LIP Neurons');
end
%%
function [MT_event_times, LIP_event_times] = MT_LIP_activity(stimulus, MT_p_values, LIP_weights, LIP_threshold, Evidence_thr)
% Parameters:
% stimulus - a vector of length T representing the directionally oriented stimulus at each time step
% MT_p_values - a matrix of size 2xT representing the firing probabilities for the excitatory and inhibitory MT neurons at each time step
% LIP_weights - a length 2 vector of weighting factors for the evidence
% from the excitatory (positive) and inhibitory (negative) neurons
% LIP_threshold - the LIP firing rate that represents the choice threshold criterion
% Evidence_thr - the evidence threshold that determines if a decision has been made

% Initialize variables
dt = 0.001;
T = length(stimulus);
MT_event_times = cell(2,1);
LIP_event_times = cell(2,1);
MT_N = zeros(2,T);
MT_rate = zeros(2,T);
LIP_N = zeros(2,T);
LIP_rate = zeros(2,T);

% Iterate over time steps
for t = 1:T
    % Update MT neurons
    MT_dN = rand(1,2) < MT_p_values(:,t)';
    MT_N(:,t) = MT_N(:,t) + MT_dN';
    MT_rate(:,t) = MT_N(:,t) ./ (t*dt);
    
    % Update LIP neurons
    for n = 1:2
        size(MT_rate)
        size(LIP_weights)
        size(LIP_N(n,t))
        size(MT_N(:,t))
        p_lip = sum(MT_N * LIP_weights) - LIP_N(n,t);
        LIP_event = Evidence_thr < p_lip;
        
        if LIP_event == 1
            LIP_event_times{n} = [LIP_event_times{n} t*dt];
        end
        
        LIP_N(n,t+1) = LIP_N(n,t) + LIP_event;
        LIP_rate(n,t+1) = LIP_N(n,t+1) / ((t+1)*dt);
    end
    
    % Update MT event times
    for n = 1:2
        if MT_rate(n,t) > 0
            MT_event = stimulus(t) == n;
            if MT_event == 1
                MT_event_times{n} = [MT_event_times{n} t*dt];
            end
        end
    end
end
end