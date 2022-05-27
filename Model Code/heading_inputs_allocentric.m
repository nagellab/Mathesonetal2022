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
function [hDeltaC_wind_input, pfl3_right_heading_input, pfl3_left_heading_input, pfl2_heading_input] = heading_inputs_allocentric(N, heading_angle, wind_angle, max_input)
    %% Prepare angles for sinusoid calculation
    % Define angles for sinusoids
    angles = linspace(0, 360, N+1)';
    angles = angles(1:end-1);
    
    angles_hdeltac = linspace(0, 360, 20+1)';
    angles_hdeltac = angles_hdeltac(1:end-1);
    
    % Define constant for converting between degrees and radians
    deg_to_rad = pi/180;
    
    %% Calculate heading inputs to PFN, PFL3, and PFL2
    % Define heading sinusoid peaks for each cell type (these shifts follow the anatomical shifts
    % of PFL3, and PFL2 neurons from the PB into the FB):
    peak_pfl3_right = 270 - heading_angle; % Right PFLs
    peak_pfl3_left = 90 - heading_angle; % Left PFLs
    peak_pfl2 = -1*heading_angle; % PFL2s
       
    % Find heading inputs to PFL3 (left + right) and PFL2 neurons
    pfl3_right_heading_input = cos(angles*deg_to_rad - peak_pfl3_right*deg_to_rad); % Right PFL3
    pfl3_left_heading_input = cos(angles*deg_to_rad - peak_pfl3_left*deg_to_rad); % Left PFL3
    pfl2_heading_input = cos(angles*deg_to_rad - peak_pfl2*deg_to_rad); % PFL2
    
    % Shift and normalize heading sinusoids to max = max_input and min = 0
    pfl3_right_heading_input = pfl3_right_heading_input - min(pfl3_right_heading_input);
    pfl3_right_heading_input = pfl3_right_heading_input / max(pfl3_right_heading_input) * max_input;
    
    pfl3_left_heading_input = pfl3_left_heading_input - min(pfl3_left_heading_input);
    pfl3_left_heading_input = pfl3_left_heading_input / max(pfl3_left_heading_input) * max_input;
    
    pfl2_heading_input = pfl2_heading_input - min(pfl2_heading_input);
    pfl2_heading_input = pfl2_heading_input / max(pfl2_heading_input) * max_input;
    
    
    %% Calculate wind sinusoid in hDeltaC neurons    
    % We propose that hDeltaC neurons may represent allocentric wind
    % position. This representation would likely involve the wind PFNs
    % discovered in Currier et al., 2020, which themselves have a -45
    % degree shift from the PB into the FB. 
    peak_wind = 180 - wind_angle;
    hDeltaC_wind_input = cos(angles_hdeltac*deg_to_rad - peak_wind*deg_to_rad);
    
    % Normalize heading sinusoids to max = max_input and min = 0
    hDeltaC_wind_input = hDeltaC_wind_input - min(hDeltaC_wind_input);
    hDeltaC_wind_input = hDeltaC_wind_input / max(hDeltaC_wind_input) * max_input;    
end
