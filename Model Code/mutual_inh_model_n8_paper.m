function [heading_time, forward_signal_time, hDeltaC_output_time, u_time, local_output_time, pfl3r_heading_time, pfl3l_heading_time, pfl2_heading_time, pfl3r_time, pfl3l_time, pfl2_time] = mutual_inh_model_n8_paper(gain_wind, gain_inh, opto_pattern, wind_angle, heading_angle, t_pre, t_stim, t_post, allocentric)
%% Model Parameters
% Parameters for mutual inhibition circuit
N = 8; % Number of neurons in mutual inhibition circuit
wii = 1.1; % Strength of inhibition across columns
tau_a = 100; % Time constant for slow adaptation in mutual inhibition circuit
g = 0.5; % Weight of slow adaptation on neural activity in mutual inhibition circuit

% Parameters for neural noise (added in at the level of hDeltaC)
tau_n = 10; % Time constant of white guassian noise
noise_gain = 0.03; % Gain of noise in mutual inhibition circuit
wn_mu = 0; % mean of white guassian noise
wn_sd = 1; % SD of white guassian noise

% Parameters for behavioural noise
turnbase = 0.0003; % baseline turn rate
tsigma = 20; % gain of random turn
vbase = 6; % Forward walking signal for pre-stimulus and post-stimulus periods

% Parameters for PFL2/3 activity
max_input = 1; % Maximum value of PFL3 heading bumps and hDeltaC wind bump
tau_pfl = 1; % Time constant of PFL2/3 neurons

% Other parameters
sigmoid_k = 0.1; % 1/k is the slope of activation function (used in mutual inihibition neurons and PFL2/3 neurons)
hdeltac_thresh = 0.7; % threshold for activation function for hdeltac output
mutual_inh_thresh = -0.15; % threshold for activation function for mutual inhibition circuit
pfl_thresh = 1.7; % threshold for activation function for PFL2 and PFL3 neurons
m1 = 0.03; % Movement coupling weight (couples PFL3 activity to change in heading)
m2 = 0.25; % Scalar that converts PFL2 activity signal into a foward walking signal
%% Define timing information
dt = 0.05; % Time step
time_steps = [0:dt:t_pre+t_stim+t_post]; % time steps for simulation

%% Create synaptic weight matrix for mutual inhibition and hDeltaC -> Column transformation
% Within this circuit, each neuron inhibits the neuron half way across the
% FB (i.e. the neuron i inhibits the neuron i + N/2 (wrapped if over N))
for ind = 1:N
    % Find postsynaptic target
    ind_postsyn = ind + N/2; 
    % wrap if needed  
    if ind_postsyn > N 
        ind_postsyn = ind_postsyn - N;          
    end
    % Set matrix weight
    recurrent_matrix(ind, ind_postsyn) = wii; 
end

hdc_col_mat = make_hdc_col_mat();

%% Create vectors/matrices to hold results
% Movement results
heading_time = zeros(1, length(time_steps)); % vector to hold heading over time
forward_signal_time = zeros(1, length(time_steps)); % vector to hold forward signal over time

% Neural activity / inputs results
hDeltaC_output_time = zeros(N, length(time_steps)); % matrix to hold output of hDeltaC neurons over time
u_time = zeros(N, length(time_steps)+1); % vector to hold u activation over time (u = mutual inhibition circuit)
local_output_time = zeros(N, length(time_steps)); % vector to hold output from local neurons to PFL neurons (i.e. outputs of hDeltaC and u)

pfl3r_heading_time = zeros(N, length(time_steps)); % vector to hold heading input to right PFL3s over time
pfl3l_heading_time = zeros(N, length(time_steps)); % vector to hold heading input to left PFL3s over time
pfl2_heading_time = zeros(N, length(time_steps)); % % vector to hold heading input to PFL2s over time

pfl3r_time = zeros(N, length(time_steps)); % vector to hold right PFL3 activation over time
pfl3l_time = zeros(N, length(time_steps)); % vector to hold left PFL3 activation over time
pfl2_time = zeros(N, length(time_steps)); % vector to hold PFL2 activation over time

%% Define initial values of dynamic variables
% Define initial values of variables (heading already defined)
if allocentric
    [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_allocentric(N, heading_angle, wind_angle, max_input);
else
    [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_pfn(N, heading_angle, wind_angle, max_input);
end

hDeltaC_output = zeros(N, 1);
forward_signal = 0;
u_t = zeros(N, 1);
a_t = zeros(N, 1);
n_t = zeros(N, 1);
local_output = zeros(N, 1);
pfl3r = zeros(N, 1);
pfl3l = zeros(N, 1);
pfl2 = zeros(N, 1);

%% Run Simulation - Pre-stimulus (random walk)
for t = 1:t_pre/dt
    % Save variables into vectors
    heading_time(t) = heading_angle;
    forward_signal_time(t) = forward_signal;
    hDeltaC_output_time(:, t) = hDeltaC_output;
    u_time(:, t) = u_t;
    local_output_time(:, t) = local_output;
    pfl3r_heading_time(:, t) = pfl3r_heading_input;
    pfl3l_heading_time(:, t) = pfl3l_heading_input;
    pfl2_heading_time(:, t) = pfl2_heading_input;
    pfl3r_time(:, t) = pfl3r;
    pfl3l_time(:, t) = pfl3l;
    pfl2_time(:, t) = pfl2;
    
    % Calculate new values for variables according to random walk conditions
    
    % Find heading and wind inputs to hDeltaC, PFL3, and PFL2
    if allocentric
        [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_allocentric(N, heading_angle, wind_angle, max_input);
    else
        [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_pfn(N, heading_angle, wind_angle, max_input);
    end
            
    % We assume here that the mutual inhibition circuit is turned off
    % before and after the stimulus
    hDeltaC_output = zeros(N, 1);
    u_t = zeros(N, 1);
    a_t = zeros(N, 1);
    local_output = zeros(N, 1);
    
    % PFL3 and PFL2 neurons have activity that depend only on heading inputs
    pfl3r = pfl3r + dt * (-pfl3r + sigmoid_func(pfl3r_heading_input, sigmoid_k, pfl_thresh))/tau_pfl;
    pfl3l = pfl3l + dt * (-pfl3l + sigmoid_func(pfl3l_heading_input, sigmoid_k, pfl_thresh))/tau_pfl;
    pfl2 = pfl2 + dt * (-pfl2 + sigmoid_func(pfl2_heading_input, sigmoid_k, pfl_thresh))/tau_pfl;  
    
    % Heading = stochastic random turning (fly turns at a rate of turnbase,
    % with each turn having a magnitude drawn from a gaussian distribution)
    turn = rand<turnbase;
    turn_size = turn * tsigma * (round(rand) * 2 - 1) * randn^2; % Draws a random turn size from a gaussian distribution with a width of tsigma
    heading_angle = heading_angle + turn_size;
    
    % Forward velocity - constant forward velocity
    forward_signal = vbase;
end

%% Run Simulation - Stimulus period

for t = 1:t_stim/dt
    % Save variables into vectors
    heading_time(t_pre/dt + t) = heading_angle;
    forward_signal_time(t_pre/dt + t) = forward_signal;
    hDeltaC_output_time(:, t_pre/dt + t) = hDeltaC_output;
    u_time(:, t_pre/dt + t) = u_t;
    local_output_time(:, t_pre/dt + t) = local_output;
    pfl3r_heading_time(:, t_pre/dt + t) = pfl3r_heading_input;
    pfl3l_heading_time(:, t_pre/dt + t) = pfl3l_heading_input;
    pfl2_heading_time(:, t_pre/dt + t) = pfl2_heading_input;
    pfl3r_time(:, t_pre/dt + t) = pfl3r;
    pfl3l_time(:, t_pre/dt + t) = pfl3l;
    pfl2_time(:, t_pre/dt + t) = pfl2; 
    
    % Calculate new values for variables according to stimulus conditions
    
    % Find heading and wind inputs to hDeltaC, PFL3, and PFL2
    if allocentric
        [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_allocentric(N, heading_angle, wind_angle, max_input);
    else
        [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_pfn(N, heading_angle, wind_angle, max_input);
    end
    
    % Calculate noisey hDeltaC output: summate wind and opto input, transform to
    % column space, add noise, phase shift    (threshold?)
    hDeltaC_output = hdc_col_mat * sigmoid_func(phase_shift(gain_wind * hDeltaC_input + opto_pattern), sigmoid_k, hdeltac_thresh) + n_t;

    % Use Eluer's method to calculate the next time step of u,a,n
    u_t = u_t + dt * (-u_t + sigmoid_func(-recurrent_matrix*u_t - g*a_t + hDeltaC_output, sigmoid_k, mutual_inh_thresh));
    a_t = a_t + dt * (- a_t + u_t)/tau_a;
    n_t = n_t + dt * (-n_t/tau_n + noise_gain * sqrt(2/tau_n) * normrnd(wn_mu,wn_sd, N, 1));

    % Calculate input to PFL3 neurons from hDeltaC (wind + opto) and local mutual inhibition circuit                
    local_output = hDeltaC_output - gain_inh*phase_shift(u_t);

    % Use Eluer's method to calculate the next time step of pfl3r and
    % pfl3l
    pfl3r = pfl3r + dt * (-pfl3r + sigmoid_func(pfl3r_heading_input + local_output, sigmoid_k, pfl_thresh))/tau_pfl;
    pfl3l = pfl3l + dt * (-pfl3l + sigmoid_func(pfl3l_heading_input + local_output, sigmoid_k, pfl_thresh))/tau_pfl;
    pfl2 = pfl2 + dt * (-pfl2 + sigmoid_func(pfl2_heading_input + local_output, sigmoid_k, pfl_thresh))/tau_pfl;

    % Calculate new heading value
    randturn = rand<turnbase;
    randturn_size = randturn * tsigma * (round(rand) * 2 - 1) * randn^2; % Draws a random turn size from a gaussian distribution with a width of tsigma

    heading_angle = heading_angle + m1 * (sum(pfl3r) - sum(pfl3l)) + randturn_size;
    forward_signal = vbase + m2*sum(pfl2);
end

%% Run Simulation - Post-stimulus (decay of dynamic variables + random walk)

for t = 1:t_post/dt
    % Save variables into vectors
    heading_time(t_pre/dt + t_stim/dt + t) = heading_angle;
    forward_signal_time(t_pre/dt + t_stim/dt + t) = forward_signal;
    hDeltaC_output_time(:, t_pre/dt + t_stim/dt + t) = hDeltaC_output;
    u_time(:, t_pre/dt + t_stim/dt + t) = u_t;
    local_output_time(:, t_pre/dt + t_stim/dt + t) = local_output;
    pfl3r_heading_time(:, t_pre/dt + t_stim/dt + t) = pfl3r_heading_input;
    pfl3l_heading_time(:, t_pre/dt + t_stim/dt + t) = pfl3l_heading_input;
    pfl2_heading_time(:, t_pre/dt + t_stim/dt + t) = pfl2_heading_input;
    pfl3r_time(:, t_pre/dt + t_stim/dt + t) = pfl3r;
    pfl3l_time(:, t_pre/dt + t_stim/dt + t) = pfl3l;
    pfl2_time(:, t_pre/dt + t_stim/dt + t) = pfl2;
    
    % Calculate new values for variables according to random walk conditions
    
    % Find heading and wind inputs to hDeltaC, PFL3, and PFL2
    if allocentric
        [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_allocentric(N, heading_angle, wind_angle, max_input);
    else
        [hDeltaC_input, pfl3r_heading_input, pfl3l_heading_input, pfl2_heading_input] = heading_inputs_pfn(N, heading_angle, wind_angle, max_input);
    end
    
    % We assume here that the mutual inhibition circuit is turned off
    % before and after the stimulus
    hDeltaC_output = zeros(N, 1);
    
    % Use Eluer's method to calculate the next time step of u,a,n
    u_t = u_t + dt * (-u_t + sigmoid_func(-recurrent_matrix*u_t - g*a_t + hDeltaC_output, sigmoid_k, mutual_inh_thresh));
    a_t = a_t + dt * (- a_t + u_t)/tau_a;
    n_t = n_t + dt * (-n_t/tau_n + noise_gain * sqrt(2/tau_n) * normrnd(wn_mu,wn_sd, N, 1));

    % Calculate input to PFL3 neurons from hDeltaC (wind + opto) and local mutual inhibition circuit                
    local_output = hDeltaC_output - gain_inh*phase_shift(u_t);
    
    % PFL3 and PFL2 neurons have activity that depend only on heading inputs
    pfl3r = pfl3r + dt * (-pfl3r + sigmoid_func(pfl3r_heading_input + local_output, sigmoid_k, pfl_thresh))/tau_pfl;
    pfl3l = pfl3l + dt * (-pfl3l + sigmoid_func(pfl3l_heading_input + local_output, sigmoid_k, pfl_thresh))/tau_pfl;
    pfl2 = pfl2 + dt * (-pfl2 + sigmoid_func(pfl2_heading_input + local_output, sigmoid_k, pfl_thresh))/tau_pfl;
    
    % Calculate new heading value
    randturn = rand<turnbase;
    randturn_size = randturn * tsigma * (round(rand) * 2 - 1) * randn^2; % Draws a random turn size from a gaussian distribution with a width of tsigma

    heading_angle = heading_angle + m1 * (sum(pfl3r) - sum(pfl3l)) + randturn_size;
    forward_signal = vbase + m2*sum(pfl2);
end
end