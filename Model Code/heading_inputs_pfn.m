% Function to create PFL3/2 heading inputs and hDeltaC wind output. For
% simplicity, these inputs are instantaneous - they are locked 
% to the fly's heading
% @param N: number of columns (N=8)
% @param heading_angle: allocentric heading angle
% @param wind_angle: allocentric wind angle
% @param max_input: max activity of PFL2/3 neurons and hDeltaC ouput
% @output hDeltaC_output: output of hDeltaC neurons in N-column space
% @output pfl3_right_heading_input: heading input to right PFL3 neurons
% @output pfl3_left_heading_input: heading input to left PFL3 neurons
% @output pfl2_heading_input: heading input to PFL2 neurons
function [hDeltaC_wind_input, pfl3_right_heading_input, pfl3_left_heading_input, pfl2_heading_input] = heading_inputs_pfn(N, heading_angle, wind_angle, max_input)
    %% Prepare angles for sinusoid calculation
    % Define angles for sinusoids
    angles = linspace(0, 360, N+1)';
    angles = angles(1:end-1);
    
    angles_pfn = linspace(0, 360, 20+1)';
    angles_pfn = angles_pfn(1:end-1);
    
    % Define constant for converting between degrees and radians
    deg_to_rad = pi/180;
    
    %% Calculate heading inputs to PFN, PFL3, and PFL2
    % Define heading sinusoid peaks for each cell type (these shifts follow the anatomical shifts
    % of PFN, PFL3, and PFL2 neurons from the PB into the FB):
    peak_pfn_right = 135 - heading_angle; % Right PFNs
    peak_pfn_left = 225 - heading_angle; % Left PFNs
    peak_pfl3_right = 270 - heading_angle; % Right PFLs
    peak_pfl3_left = 90 - heading_angle; % Left PFLs
    peak_pfl2 = -1*heading_angle; % PFL2s
       
    % Find heading inputs to PFN, PFL3 (left + right), and PFL2 neurons
    pfn_right_heading_input = cos(angles_pfn*deg_to_rad - peak_pfn_right*deg_to_rad); % Right PFN
    pfn_left_heading_input = cos(angles_pfn*deg_to_rad - peak_pfn_left*deg_to_rad); % Left PFN
    pfl3_right_heading_input = cos(angles*deg_to_rad - peak_pfl3_right*deg_to_rad); % Right PFL3
    pfl3_left_heading_input = cos(angles*deg_to_rad - peak_pfl3_left*deg_to_rad); % Left PFL3
    pfl2_heading_input = cos(angles*deg_to_rad - peak_pfl2*deg_to_rad); % PFL2

    % Shift and normalize heading sinusoids to max = max_input and min = 0
    pfn_right_heading_input = pfn_right_heading_input - min(pfn_right_heading_input);
    pfn_right_heading_input = pfn_right_heading_input / max(pfn_right_heading_input) * max_input;
    
    pfn_left_heading_input = pfn_left_heading_input - min(pfn_left_heading_input);
    pfn_left_heading_input = pfn_left_heading_input / max(pfn_left_heading_input) * max_input;
    
    pfl3_right_heading_input = pfl3_right_heading_input - min(pfl3_right_heading_input);
    pfl3_right_heading_input = pfl3_right_heading_input / max(pfl3_right_heading_input) * max_input;
    
    pfl3_left_heading_input = pfl3_left_heading_input - min(pfl3_left_heading_input);
    pfl3_left_heading_input = pfl3_left_heading_input / max(pfl3_left_heading_input) * max_input;
    
    pfl2_heading_input = pfl2_heading_input - min(pfl2_heading_input);
    pfl2_heading_input = pfl2_heading_input / max(pfl2_heading_input) * max_input;
    
    %% Calculate wind sinusoid in hDeltaC neurons
    % Find relative wind angle
    relative_wind_angle = wind_angle - heading_angle;
    
    % Use relative wind angle to calculate amplitude of left/right PFN
    % sinusoids (this scaling follows ephys recordings from left/right windPFNs 
    % from Currier et al. 2020)
    scale_pfn_right = (sin(relative_wind_angle*pi/180 + pi/4)+1)/2;
    scale_pfn_left = (-sin(relative_wind_angle*pi/180 + 7*pi/4)+1)/2; 
    
    % For simplicity, we want the hDeltaC sinusoids to have a max/min value 
    % equivalent to the heading inputs of PFN, PFL3, and PFL2. To do this,
    % we have to find the maximum possible value of the hDeltaC sinusoid
    % and then scale it according to this maximum. The hDeltaC population
    % integrates inputs from left PFNs and right PFNs, therefore, the
    % maximum activity possible for the hDeltaC population is when the wind
    % is directly in front of the fly. To find the value of this maximum,
    % we can calculate the maximum value of hDeltaC population when the
    % relative wind direction is 0.
    
    scale_pfn_right_max = (sin(0*pi/180 + pi/4)+1)/2; % Right PFN sinusoid when relative wind direction = 0
    scale_pfn_left_max = (-sin(0*pi/180 + 7*pi/4)+1)/2; % Left PFN sinusoid when relative wind direction = 0
    hDelta_scale = max(pfn_right_heading_input*scale_pfn_right_max + pfn_left_heading_input*scale_pfn_left_max); % Max hDeltaC activity when relative wind direction = 0
    
    % Find the hDeltaC sinusoid for actual wind direction and scale by
    % hDeltaC_scale and max_input (i.e. if wind is front of the fly, then
    % the max activity will equal the max of PFN, PFL3, and PFL2 activities).
    hDeltaC_wind_input = pfn_right_heading_input * scale_pfn_right + pfn_left_heading_input * scale_pfn_left;
    hDeltaC_wind_input = hDeltaC_wind_input / hDelta_scale * max_input;
    
end
