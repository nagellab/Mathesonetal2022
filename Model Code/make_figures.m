%% Upwind Tracking Trajactory
gain_wind = 1; % Variable that sets the strength of hDeltaC wind input into navigaiton circuit
gain_inh = 1; % Variable that sets the strength of mutual inhibition input onto PFL3 neurons
opto_pattern = zeros(20,1); % Optogenetic patterns (must be 8X1 vector)
wind_angle = 0; % Wind direction (must include even if gain_wind = 0)
heading_angle = 0; % Initial head direction
t_pre = 3000; % Time (ms) of pre-stimulus (odour or light) period
t_stim = 10000; % Time (ms) of stimulus period (odour or light)
t_post = 3000; % Time (ms) of post-stimulus (odour or light) period

% Parameters to adjust:
allocentric = 1; % Use allocentric representation of wind (0 for egocentric representation)

[heading_time, forward_signal_time, hDeltaC_output_time, u_time, local_output_time, pfl3r_heading_time, pfl3l_heading_time, pfl2_heading_time, pfl3r_time, pfl3l_time, pfl2_time] = mutual_inh_model_n8_paper(gain_wind, gain_inh, opto_pattern, wind_angle, heading_angle, t_pre, t_stim, t_post, allocentric);
draw_trajectory(heading_time, forward_signal_time, t_pre, t_stim, 0.05);

%% Broad Activation Trajactory
gain_wind = 0; % Variable that sets the strength of hDeltaC wind input into navigaiton circuit
gain_inh = 1; % Variable that sets the strength of mutual inhibition input onto PFL3 neurons
wind_angle = 0; % Wind direction (must include even if gain_wind = 0)
heading_angle = 0; % Initial head direction
t_pre = 3000; % Time (ms) of pre-stimulus (odour or light) period
t_stim = 10000; % Time (ms) of stimulus period (odour or light)
t_post = 3000; % Time (ms) of post-stimulus (odour or light) period
allocentric = 1; % Use allocentric representation of wind (0 for egocentric representation)

% Parameters to adjust:
opto_power = 2.3; % med = 0.75, high = 2.3
gain_inh = 1; % Variable that sets the strength of mutual inhibition input onto PFL3 neurons

opto_pattern = opto_power * ones(20,1);
[heading_time, forward_signal_time, hDeltaC_output_time, u_time, local_output_time, pfl3r_heading_time, pfl3l_heading_time, pfl2_heading_time, pfl3r_time, pfl3l_time, pfl2_time] = mutual_inh_model_n8_paper(gain_wind, gain_inh, opto_pattern, wind_angle, heading_angle, t_pre, t_stim, t_post, allocentric);
draw_trajectory(heading_time, forward_signal_time, t_pre, t_stim, 0.05);

%% Sparc2 Activation Trajactory
gain_wind = 0; % Variable that sets the strength of hDeltaC wind input into navigaiton circuit
gain_inh = 1; % Variable that sets the strength of mutual inhibition input onto PFL3 neurons
wind_angle = 0; % Wind direction (must include even if gain_wind = 0)
heading_angle = 0; % Initial head direction
t_pre = 3000; % Time (ms) of pre-stimulus (odour or light) period
t_stim = 10000; % Time (ms) of stimulus period (odour or light)
t_post = 3000; % Time (ms) of post-stimulus (odour or light) period
allocentric = 1; % Use allocentric representation of wind (0 for egocentric representation)

% Optogenetic stimulus
opto_power = 2.3;
N_hDeltaC = 20;
thresh_sparc = 0.15;
rand_vec = rand(N_hDeltaC, 1);
opto_pattern = opto_power * (rand_vec <= thresh_sparc);

% Parameters to adjust:
% None

[heading_time, forward_signal_time, hDeltaC_output_time, u_time, local_output_time, pfl3r_heading_time, pfl3l_heading_time, pfl2_heading_time, pfl3r_time, pfl3l_time, pfl2_time] = mutual_inh_model_n8_paper(gain_wind, gain_inh, opto_pattern, wind_angle, heading_angle, t_pre, t_stim, t_post, allocentric);
draw_trajectory(heading_time, forward_signal_time, t_pre, t_stim, 0.05);

%% Broad Activation Trajactory - Curvature
gain_wind = 0; % Variable that sets the strength of hDeltaC wind input into navigaiton circuit
wind_angle = 0; % Wind direction (must include even if gain_wind = 0)
heading_angle = 0; % Initial head direction
t_pre = 2000; % Time (ms) of pre-stimulus (odour or light) period
t_stim = 10000; % Time (ms) of stimulus period (odour or light)
t_post = 2000; % Time (ms) of post-stimulus (odour or light) period
dt = 0.05;
allocentric = 1; % Use allocentric representation of wind (0 for egocentric representation)

% Parameters to adjust
opto_power = 2.3; % High = 2.3, Low = 0.75
gain_inh = 1; % Variable that sets the strength of mutual inhibition input onto PFL3 neurons

opto_pattern = opto_power * ones(20,1);
trials = 60*24; % Define (number of flies) * (number of trials)
trial_len_ds = ceil(((t_pre + t_stim + t_post) / dt + 1) / 400) - 2; % length of curvature trial at downsampled sample rate (50 Hz)
curvature_trials = zeros(trials, trial_len_ds); 

f = waitbar(0, 'Starting');
for i = 1:trials
    % Run simulation
    [heading_time, forward_signal_time, hDeltaC_output_time, u_time, local_output_time, pfl3r_heading_time, pfl3l_heading_time, pfl2_heading_time, pfl3r_time, pfl3l_time, pfl2_time] = mutual_inh_model_n8_paper(gain_wind, gain_inh, opto_pattern, wind_angle, heading_angle, t_pre, t_stim, t_post, allocentric);

    % Find curvature
    heading_time_ds = downsample(heading_time, 400); % Converts sample rate (20000 Hz) to 50 Hz
    forward_signal_time_ds = downsample(forward_signal_time, 400); % Converts sample rate (20000 Hz) to 50 Hz
    trial_angv = abs(diff(heading_time_ds(2:end))/0.02); % 0.02 = time between data points at 50 Hz
    trial_curv = trial_angv./ forward_signal_time_ds(2:end-1);    
    
    curvature_trials(i, :) = trial_curv;
    
    waitbar(i/trials, f, sprintf('Progress: %d %%', floor(i/trials*100)));    
end
close(f)

% Get mean angular velocity
mean_curvature = mean(curvature_trials, 1);

% Plot
figure
plot(linspace(0, t_pre + t_stim + t_post, trial_len_ds-1), mean_curvature(1:end-1), 'color', [0.351, 0.351, 0.351], 'linewidth', 1.5)
ylabel('Curvature (deg/mm)')
xlabel('Time (s)')
%% Sparc2 Activation Trajactory - Vectors and Curvature
gain_wind = 0; % Variable that sets the strength of hDeltaC wind input into navigaiton circuit
gain_inh = 1; % Variable that sets the strength of mutual inhibition input onto PFL3 neurons
wind_angle = 0; % Wind direction (must include even if gain_wind = 0)
heading_angle = 0; % Initial head direction
t_pre = 0; % Time (ms) of pre-stimulus (odour or light) period
t_stim = 10000; % Time (ms) of stimulus period (odour or light)
t_post = 0; % Time (ms) of post-stimulus (odour or light) period
dt = 0.05;
allocentric = 1; % Use allocentric representation of wind (0 for egocentric representation)

% Parameters to adjust
opto_power = 2.3;

% Define histogram settings  - same as behavioural analysis
bin_centers = linspace(0,360, 30);

% Define number of flies and trials/fly
num_flies = 72;
num_trials = 30;

trial_len_ds = ceil(((t_pre + t_stim + t_post) / dt + 1) / 400) - 2; % length of curvature trial at downsampled sample rate (50 Hz)

% Set up vectors to hold results
mean_curvature = zeros(1, trial_len_ds); % length of curvature trial at downsampled sample rate (50 Hz)
vector_strengths = zeros(1, num_flies);
vector_angles = zeros(1, num_flies);

% We will keep track of the total number of trials to make saving the mean
% angular velocity less computationally expensive...
n_all_trials = 0;

f = waitbar(0, 'Starting');
for i = 1:num_flies
    % Define optogenetic stimulus
    N_hDeltaC = 20;
    thresh_sparc = 0.15;
    rand_vec = rand(N_hDeltaC, 1);
    opto_pattern = opto_power * (rand_vec <= thresh_sparc);
       
    % Create vector to hold histogram information for each fly
    heading_hist_total = zeros(1, length(bin_centers));
    
    % We will keep track of the total number of trials per fly to make saving the 
    % orientation histogram less computationally expensive
    n_fly_trials = 0;
    
    for j = 1:num_trials 
        % Run Simulation
        [heading_time, forward_signal_time, hDeltaC_output_time, u_time, local_output_time, pfl3r_heading_time, pfl3l_heading_time, pfl2_heading_time, pfl3r_time, pfl3l_time, pfl2_time] = mutual_inh_model_n8_paper(gain_wind, gain_inh, opto_pattern, wind_angle, heading_angle, t_pre, t_stim, t_post, allocentric);

        % Find curvature
        heading_time_ds = downsample(heading_time, 400); % Converts sample rate (20000 Hz) to 50 Hz
        forward_signal_time_ds = downsample(forward_signal_time, 400); % Converts sample rate (20000 Hz) to 50 Hz
        trial_angv = abs(diff(heading_time_ds(2:end))/0.02); % 0.02 = time between data points at 50 Hz
        trial_curv = trial_angv./ forward_signal_time_ds(2:end-1);
        
        mean_curvature = mean_curvature*n_all_trials/(n_all_trials+1) + trial_curv/(n_all_trials+1); % save to mean
              
        % Wrap heading for histogram
        heading_time(heading_time < 0) = heading_time(heading_time < 0) + 360*(ceil(abs(heading_time(heading_time < 0) / 360)));
        heading_time(heading_time > 360) = heading_time(heading_time > 360) - 360*(floor(abs(heading_time(heading_time > 360) / 360)));
        
        % Create histogram of heading
        [counts,centers] = hist(heading_time(t_pre/dt + 2000/dt:t_pre/dt + 6000/dt), bin_centers); % Make histogram
        counts_norm = counts / sum(counts);
        
        % Update mean histogram for this fly
        heading_hist_total = heading_hist_total*n_fly_trials/(n_fly_trials+1) + counts_norm/(n_fly_trials+1);
        n_all_trials = n_all_trials + 1;
        n_fly_trials = n_fly_trials + 1;
        
        waitbar(n_all_trials/(num_flies*num_trials), f, sprintf('Progress: %d %%', floor(n_all_trials/(num_flies*num_trials)*100)));
    end
    

    % Find orientation strength for this simulated fly
    % Convert histogram data into x,y coordinates of polar plot 
    data_x = heading_hist_total.* cos(bin_centers*pi/180);
    data_y = heading_hist_total.* sin(bin_centers*pi/180);
    % Find dimension with maximum spread of histogram polar plot data
    data = [data_x', data_y'];
    [U, S, V] = svd(data);
    % Obtain ratio of spread along dimension with highest variability to
    % spread along dimsion with lowest variability.
    projections1 = V(:, 1)' * data';
    projections2 = V(:, 2)' * data';
    std_ratio = std(projections1) / std(projections2);
        
    % Save ratio as vector strength
    vector_strengths(i) = std_ratio;
    
    % Find preferred angle for simulated fly
    % Find the direction along PC1 that has furthest data point
    if abs(min(projections1)) > abs(max(projections1))
        pc1x = -1*V(1, 1);
        pc1y = -1*V(2, 1);
    else
        pc1x = V(1, 1);
        pc1y = V(2, 1);
    end

    % Calculate angle
    vector_angle = atan(pc1y/pc1x);                 
    if pc1x < 0
        vector_angle = vector_angle + pi;
    end 
    % Save angle
    vector_angles(i) = vector_angle;
end
close(f)

% Plot
figure; hold on
for i = 1:length(vector_strengths)
    quiver(0,0,vector_strengths(i)*cos(vector_angles(i)), vector_strengths(i)*sin(vector_angles(i)), 0, 'k', 'LineWidth', 1)
end
xlim([-6, 6])
ylim([-6, 6])
title('Sparc2 Vt062617 15% 19deg Filt')
axis square

% Plot
figure
plot(linspace(0, t_pre + t_stim + t_post, trial_len_ds - 1), mean_curvature(1:end-1), 'color', [0.351, 0.351, 0.351], 'linewidth', 1.5)
ylabel('Turn Probability')
xlabel('Time (s)')

%% Initial Heading Analysis
close all
gain_wind = 1; % Variable that sets the strength of hDeltaC wind input into navigaiton circuit
gain_inh = 1; % Variable that sets the strength of mutual inhibition input onto PFL3 neurons
opto_pattern = zeros(20,1); % Optogenetic patterns (must be 8X1 vector)
t_pre = 0; % Time (ms) of pre-stimulus (odour or light) period
t_stim = 2000; % Time (ms) of stimulus period (odour or light)
t_post = 0; % Time (ms) of post-stimulus (odour or light) period
dt = 0.05;
time_steps = [0:dt:t_pre+t_stim+t_post];
heading_angles = [0:20:360];

% Parameters to adjust
allocentric = 0; % Use allocentric representation of wind (0 for egocentric representation)
wind_angle = 270;

figure; hold on
for i = 1:length(heading_angles) % Loop through intitial heading angles
    heading_angle = heading_angles(i);
    
    % Run model
    [heading_time, forward_signal_time, hDeltaC_output_time, u_time, local_output_time, pfl3r_heading_time, pfl3l_heading_time, pfl2_heading_time, pfl3r_time, pfl3l_time, pfl2_time] = mutual_inh_model_n8_paper(gain_wind, gain_inh, opto_pattern, wind_angle, heading_angle, t_pre, t_stim, t_post, allocentric);
    
    % Wrap heading
    [heading_time_ds, time_steps_ds] = wrap_heading_plot(heading_time, time_steps);
    
    % Plot
    plot(time_steps_ds, heading_time_ds, 'linewidth', 1.5, 'color', [0.351, 0.351, 0.351])
    
end

ylim([0,360])
ylabel('Heading (degrees)')
xlabel('time (ms)')