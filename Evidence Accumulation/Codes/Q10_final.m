%%
% Set up parameters
clc;clear all;close all;
MT_p_values1 = [0.004 0.02];
MT_p_values2 = [0.02 0.004];
LIP_weights = [1 -1];
LIP2_weights = [-1 1];
LIP_threshold = 20;
Evidence_thr = 10;
% Run simulation
[LIP_event_times, MT_event_times_plus, MT_event_times_minus, LIP2_event_times] = LIP_activity(MT_p_values1, MT_p_values2, LIP_weights,LIP2_weights, LIP_threshold, Evidence_thr);
% Plot event times as a raster
figure;
hold on;
plot(MT_event_times_plus, ones(size(MT_event_times_plus)), 'b.', 'MarkerSize', 10);
plot(MT_event_times_minus, 2*ones(size(MT_event_times_minus)), 'r.', 'MarkerSize', 10);
plot(LIP_event_times, 3*ones(size(LIP_event_times)), 'k.', 'MarkerSize', 10);
plot(LIP2_event_times, 4*ones(size(LIP2_event_times)), 'c.', 'MarkerSize', 10);
ylim([0 5]);
yticks([1 2 3 4]);
yticklabels({'MT+', 'MT-', 'LIP1', 'LIP2'});
xlabel('Time (ms)');
title(['Coordinated MT and LIP simulated event times' sprintf("MT P-values = %.3f, %.3f", MT_p_values1(1), MT_p_values1(2))]);

%%
function [LIP_event_times, MT_event_times_plus, MT_event_times_minus, LIP2_event_times] = LIP_activity(MT_p_values1,MT_p_values2, LIP_weights, LIP2_weights, LIP_threshold, Evidence_thr)
dt=0.001;
rate=0;
N=[0 0]; % plus is first, minus is second
N2=[0 0]; % plus is second, minus is first
t=0;
LIP_event_times=[];
LIP2_event_times=[];
MT_event_times_plus = [];
MT_event_times_minus = [];
kk = 0;
while (kk<6000)
    kk = kk + 1;
    if(kk<1000)
        dN = rand(1,2) < MT_p_values1;
    elseif(kk<3000)
        dN = rand(1,2) < MT_p_values2;
    elseif(kk<5000)
        dN = rand(1,2) < MT_p_values1;
    elseif(kk<6000)
        dN = rand(1,2) < MT_p_values2;
    end
    N = N + dN;
    if dN(1) == 1
        MT_event_times_plus = [MT_event_times_plus t];
    end
    if dN(2) == 1
        MT_event_times_minus = [MT_event_times_minus t];
    end
    % Update LIP neuron 1
    p_lip = sum(N.*LIP_weights);
    LIP_event = Evidence_thr < p_lip;
    if LIP_event == 1
        LIP_event_times = [LIP_event_times t];
    end
    % Update LIP neuron 2
    p_lip2 = sum(N.*LIP2_weights);
    LIP2_event = Evidence_thr < p_lip2;
    if LIP2_event == 1
        LIP2_event_times = [LIP2_event_times t];
    end
    % check LIP mean rate for last M spikes
    t=t+dt;
end
end