%% Pre

% The first chunk of code is dedicated to generating an interactive version
% of the model code, allowing the user to enter allocentric wind angle and  
% fly heading angle, and then visualize the resulting PFN, hDeltaC, PFL3, 
% and PFL2 sinusoids. You can turn on or off any sinusoid during the
% visualization process (see below).
clc
close all
clear all
%% Enter heading angle and wind angle
wind_angle = -90;
heading_angle = 0;

%% Choose sinusoids you'd like to visualize (true = visualize,  false = don't visualize)
pfn_right = true; % Right PFNs
pfn_left = true; % Left PFNs

pfn_combined = true; % Right PFNs + Left PFNs (total output)
hDeltaC_output = true; % Right PFNs + Left PFNs + 180 degree shift

pfl3_right = false; % Right PFL3
pfl3_left = false; % Left PFL3

pfl3_right_pfn = false; % Right PFL3 + total PFN input
pfl3_left_pfn = false; % Left PFL3 + total PFN input
pfl3_right_hDeltaC = false; % Right PFL3 + hDeltaC Output
pfl3_left_hDeltaC = false; % Left PFL3 + hDeltaC Output

pfl2_right = false; % Right PFL2
pfl2_left = false; % Left PFL2

pfl2_right_pfn = false; % Right PFL2 + total PFN input
pfl2_left_pfn = false; % Left PFL2 + total PFN input
pfl2_right_hDeltaC = false; % Right PFL2 + hDeltaC Output
pfl2_left_hDeltaC = false; % Left PFL2 + hDeltaC Output

%% Run model
angles = linspace(0, 360, 50); % Set up angles to define sinusoids
fb_columns = linspace(1, 8, 50); % Set up FB position
deg_to_rad = pi/180;

% Define sinusoid peaks for each cell type:
peak_pfn_right = 135 - heading_angle; % Right PFNs
peak_pfn_left = 225 - heading_angle; % Left PFNs
peak_pfl3_right = 270 - heading_angle; % Right PFLs
peak_pfl3_left = 90 - heading_angle; % Left PFLs
peak_pfl2_right = -heading_angle; % Right PFL2s
peak_pfl2_left = -heading_angle; % Left PFL2

% Find relative wind angle
relative_wind_angle = wind_angle - heading_angle;

% Use relative wind angle to calculate amplitude of left/right PFN
% sinusoids
scale_pfn_right = (sin(relative_wind_angle*pi/180 + pi/4)+1)/2;
scale_pfn_left = (-sin(relative_wind_angle*pi/180 + 7*pi/4)+1)/2;

% Create sinusoids
sinusoid_pfn_right = cos(angles*deg_to_rad - peak_pfn_right*deg_to_rad)*scale_pfn_right; % Right PFNs
sinusoid_pfn_left = cos(angles*deg_to_rad - peak_pfn_left*deg_to_rad)*scale_pfn_left; % Left PFNs

sinusoid_pfn_combined = sinusoid_pfn_right + sinusoid_pfn_left; % Right PFNs + Left PFNs (total output)
sinusoid_hDeltaC_output = -1*sinusoid_pfn_combined; % Right PFNs + Left PFNs + 180 degree shift

sinusoid_pfl3_right = cos(angles*deg_to_rad - peak_pfl3_right*deg_to_rad); % Right PFL3
sinusoid_pfl3_left = cos(angles*deg_to_rad - peak_pfl3_left*deg_to_rad); % Left PFL3

sinusoid_pfl3_right_pfn = sinusoid_pfl3_right + sinusoid_pfn_combined; % Right PFL3 + total PFN input
sinusoid_pfl3_left_pfn = sinusoid_pfl3_left + sinusoid_pfn_combined; % Left PFL3 + total PFN input
sinusoid_pfl3_right_hDeltaC = sinusoid_pfl3_right + sinusoid_hDeltaC_output; % Right PFL3 + hDeltaC Output
sinusoid_pfl3_left_hDeltaC = sinusoid_pfl3_left + sinusoid_hDeltaC_output; % Left PFL3 + hDeltaC Output

sinusoid_pfl2_right = cos(angles*deg_to_rad - peak_pfl2_right*deg_to_rad); % Right PFL2
sinusoid_pfl2_left = cos(angles*deg_to_rad - peak_pfl2_left*deg_to_rad); % Left PFL2

sinusoid_pfl2_right_pfn = sinusoid_pfl2_right + sinusoid_pfn_combined; % Right PFL2 + total PFN input
sinusoid_pfl2_left_pfn = sinusoid_pfl2_left + sinusoid_pfn_combined; % Left PFL2 + total PFN input
sinusoid_pfl2_right_hDeltaC = sinusoid_pfl2_right + sinusoid_hDeltaC_output; % Right PFL2 + hDeltaC Output
sinusoid_pfl2_left_hDeltaC = sinusoid_pfl2_left + sinusoid_hDeltaC_output; % Left PFL2 + hDeltaC Output

% Plot Sinusoids
figure;
hold on

% Right PFN
if pfn_right
    plot(fb_columns, sinusoid_pfn_right, 'Color', [0 0.6510 0.3176], 'Linewidth', 3, 'DisplayName', 'Right PFNs')
end
    
% Left PFN
if pfn_left
    plot(fb_columns, sinusoid_pfn_left, 'Color', [0.9647 0.5255 0.1255], 'Linewidth', 3, 'DisplayName', 'Left PFNs')
end

% Left and Right PFN output
if pfn_combined & hDeltaC_output
    plot(fb_columns, sinusoid_pfn_combined, '--', 'Color', [0.9569 0.5333 0.5569], 'Linewidth', 3, 'DisplayName', 'Left + Right PFNs')
elseif pfn_combined & ~hDeltaC_output
    plot(fb_columns, sinusoid_pfn_combined, 'Color', [0.9294 0.1098 0.1412], 'Linewidth', 3, 'DisplayName', 'Left + Right PFNs')
end

% hDeltaC Output
if hDeltaC_output
    plot(fb_columns, sinusoid_hDeltaC_output, 'Color', [0.9294 0.1098 0.1412], 'Linewidth', 3, 'DisplayName', 'hDeltaC')
    
end

% Right PFL3
if pfl3_right & (pfl3_right_hDeltaC + pfl3_right_pfn) > 0
    plot(fb_columns, sinusoid_pfl3_right, '--', 'Color', [0 0.6824 0.9373], 'Linewidth', 3, 'DisplayName', 'Right PFL3s')
elseif pfl3_right & (pfl3_right_hDeltaC + pfl3_right_pfn) == 0
    plot(fb_columns, sinusoid_pfl3_right, 'Color', [0 0.6824 0.9373], 'Linewidth', 3, 'DisplayName', 'Right PFL3s')
end

% Left PFL3
if pfl3_left & (pfl3_left_hDeltaC + pfl3_left_pfn) > 0
    plot(fb_columns, sinusoid_pfl3_left, '--', 'Color', [0.8314 0.4784 0.6941], 'Linewidth', 3, 'DisplayName', 'Left PFL3s')
elseif pfl3_left & (pfl3_left_hDeltaC + pfl3_left_pfn) == 0
    plot(fb_columns, sinusoid_pfl3_left, 'Color', [0.8314 0.4784 0.6941], 'Linewidth', 3, 'DisplayName', 'Left PFL3s')
end

% Right PFL2
if pfl2_right & (pfl2_right_hDeltaC + pfl2_right_pfn) > 0
    plot(fb_columns, sinusoid_pfl2_right, '--', 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Right PFL2s')
elseif pfl2_right & (pfl2_right_hDeltaC + pfl2_right_pfn) == 0
    plot(fb_columns, sinusoid_pfl2_right, 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Right PFL2s')
end

% Left PFL2
if pfl2_left & (pfl2_left_hDeltaC + pfl2_left_pfn) > 0
    plot(fb_columns, sinusoid_pfl2_left, '--', 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Left PFL2s')
elseif pfl2_left & (pfl2_left_hDeltaC + pfl2_left_pfn) == 0
    plot(fb_columns, sinusoid_pfl2_left, 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Left PFL2s')
end
    
% Right PFL3 + PFN 
if pfl3_right_pfn
    plot(fb_columns, sinusoid_pfl3_right_pfn, 'Color', [0 0.6824 0.9373], 'Linewidth', 3, 'DisplayName', 'Right PFL3s + PFN')
end

% Right PFL3 + hDeltaC 
if pfl3_right_hDeltaC
    plot(fb_columns, sinusoid_pfl3_right_hDeltaC, 'Color', [0 0.6824 0.9373], 'Linewidth', 3, 'DisplayName', 'Right PFL3s + hDeltaC')
end

% Left PFL3 + PFN 
if pfl3_left_pfn
    plot(fb_columns, sinusoid_pfl3_left_pfn, 'Color', [0.8314 0.4784 0.6941], 'Linewidth', 3, 'DisplayName', 'Left PFL3s + PFN')
end

% Left PFL3 + hDeltaC 
if pfl3_left_hDeltaC
    plot(fb_columns, sinusoid_pfl3_left_hDeltaC, 'Color', [0.8314 0.4784 0.6941], 'Linewidth', 3, 'DisplayName', 'Left PFL3s + hDeltaC')
end


% Right PFL2 + PFN 
if pfl2_right_pfn
    plot(fb_columns, sinusoid_pfl2_right_pfn, 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Right PFL2s + PFN')
end

% Right PFL2 + hDeltaC 
if pfl2_right_hDeltaC
    plot(fb_columns, sinusoid_pfl2_right_hDeltaC, 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Right PFL2s + hDeltaC')
end

% Left PFL2 + PFN 
if pfl2_left_pfn
    plot(fb_columns, sinusoid_pfl2_left_pfn, 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Left PFL2s + PFN')
end

% Left PFL2 + hDeltaC 
if pfl2_left_hDeltaC
    plot(fb_columns, sinusoid_pfl2_left_hDeltaC, 'Color', [0.4471 0.3294 0.6392], 'Linewidth', 3, 'DisplayName', 'Left PFL2s + hDeltaC')
end

legend
xlabel('FB Column');
ylabel('Amplitude');

%% Predict Behavior
% No odor - PFL3
right_pfl3_max = max(sinusoid_pfl3_right_pfn);
left_pfl3_max = max(sinusoid_pfl3_left_pfn);
percent_right_pfl3_recruitment = right_pfl3_max / (right_pfl3_max + left_pfl3_max)*100;
string = ['No odor - Percent Right PFL3 Recruitment: ', num2str(percent_right_pfl3_recruitment), '%'];
disp(string);

% Odor - PFL3
right_pfl3_max_odor = max(sinusoid_pfl3_right_hDeltaC);
left_pfl3_max_odor = max(sinusoid_pfl3_left_hDeltaC);
percent_right_pfl3_recruitment_odor = right_pfl3_max_odor / (right_pfl3_max_odor + left_pfl3_max_odor)*100;
string = ['Odor - Percent Right PFL3 Recruitment: ', num2str(percent_right_pfl3_recruitment_odor), '%'];
disp(string);

% No odor - PFL2
right_pfl2_max = max(sinusoid_pfl2_right_pfn);
left_pfl2_max = max(sinusoid_pfl2_left_pfn);
percent_right_pfl2_recruitment = right_pfl2_max + left_pfl2_max;
string = ['No odor - PFL2 Recruitment: ', num2str(percent_right_pfl2_recruitment)];
disp(string);

% Odor - PFL2
right_pfl2_max_odor = max(sinusoid_pfl2_right_hDeltaC);
left_pfl2_max_odor = max(sinusoid_pfl2_left_hDeltaC);
percent_right_pfl2_recruitment_odor = right_pfl2_max_odor + left_pfl2_max_odor;
string = ['Odor - PFL2 Recruitment: ', num2str(percent_right_pfl2_recruitment_odor)];
disp(string);

%% Desirability functions
% This second section of code is dedicated to plotting the desirability
% functions created in the paper. Instead of choosing a particular wind
% direction, the model loops through various wind directions and plots the
% PFL3 and PFL2 activity across all wind directions. This code uses a
% helper function called 'sensorimotor_model' that replicates the code used
% to run the vector model in the interactive version of this script. 

heading_angle = 90; % user can change this value
wind_angles = linspace(-180, 180, 50); % Allocentric wind angles from -180 -> 180 degrees

direct_pathway_turning = zeros(1, length(wind_angles));
indirect_pathway_turning = zeros(1, length(wind_angles));
direct_pathway_walking = zeros(1, length(wind_angles));
indirect_pathway_walking = zeros(1, length(wind_angles));

for i = 1:length(wind_angles)
    % Define wind angle for current iteration
    wind_angle = wind_angles(i);
    
    % Run vector model
    [percent_right_pfl3_recruitment, percent_right_pfl3_recruitment_odor, percent_right_pfl2_recruitment, percent_right_pfl2_recruitment_odor] = sensorimotor_model(heading_angle, wind_angle);
    
    % Save results
    direct_pathway_turning(i) = percent_right_pfl3_recruitment;
    indirect_pathway_turning(i) = percent_right_pfl3_recruitment_odor;
    direct_pathway_walking(i) = percent_right_pfl2_recruitment;
    indirect_pathway_walking(i) = percent_right_pfl2_recruitment_odor;
end

% Plot D functions
figure
hold on
plot(wind_angles, direct_pathway_turning, '-b', 'Linewidth', 3)
plot([heading_angle, heading_angle], [20, 80], '--r')
xlim([-180,180])
ylim([20, 80])
title('Direct Pathway')
ylabel('Right PFL3 Recruitment (%)')
xlabel('Relative Wind Direction (°)')

figure
hold on
plot(wind_angles, indirect_pathway_turning, '-r', 'Linewidth', 3)
plot([heading_angle, heading_angle], [20, 80], '--r')
xlim([-180,180])
ylim([20, 80])
title('Indirect Pathway')
ylabel('Right PFL3 Recruitment (%)')
xlabel('Relative Wind Direction (°)')

figure
hold on
plot(wind_angles, direct_pathway_walking, '-b', 'Linewidth', 3)
plot([heading_angle, heading_angle], [0, 5], '--r')
xlim([-180,180])
ylim([0, 5])
title('Direct Pathway')
ylabel('PFL2 Recruitment')
xlabel('Relative Wind Direction (°)')

figure
hold on
plot(wind_angles, indirect_pathway_walking, '-r', 'Linewidth', 3)
plot([heading_angle, heading_angle], [0, 5], '--r')
xlim([-180,180])
ylim([0, 5])
title('Indirect Pathway')
ylabel('PFL2 Recruitment')
xlabel('Relative Wind Direction (°)')

%% Helper Functions
function [percent_right_pfl3_recruitment, percent_right_pfl3_recruitment_odor, percent_right_pfl2_recruitment, percent_right_pfl2_recruitment_odor] = sensorimotor_model(heading_angle, wind_angle)
    angles = linspace(0, 360, 50); % Set up angles to define sinusoids
    fb_columns = linspace(1, 8, 50); % Set up FB position
    deg_to_rad = pi/180;

    % Define sinusoid peaks for each cell type:
    peak_pfn_right = 135 - heading_angle; % Right PFNs
    peak_pfn_left = 225 - heading_angle; % Left PFNs
    peak_pfl3_right = 270 - heading_angle; % Right PFLs
    peak_pfl3_left = 90 - heading_angle; % Left PFLs
    peak_pfl2_right = -heading_angle; % Right PFL2s
    peak_pfl2_left = -heading_angle; % Left PFL2

    % Find relative wind angle
    relative_wind_angle = wind_angle - heading_angle;

    % Use relative wind angle to calculate amplitude of left/right PFN
    % sinusoids
    scale_pfn_right = (sin(relative_wind_angle*pi/180 + pi/4)+1)/2;
    scale_pfn_left = (-sin(relative_wind_angle*pi/180 + 7*pi/4)+1)/2;

    % Create sinusoids
    sinusoid_pfn_right = cos(angles*deg_to_rad - peak_pfn_right*deg_to_rad)*scale_pfn_right; % Right PFNs
    sinusoid_pfn_left = cos(angles*deg_to_rad - peak_pfn_left*deg_to_rad)*scale_pfn_left; % Left PFNs

    sinusoid_pfn_combined = sinusoid_pfn_right + sinusoid_pfn_left; % Right PFNs + Left PFNs (total output)
    sinusoid_hDeltaC_output = -1*sinusoid_pfn_combined; % Right PFNs + Left PFNs + 180 degree shift

    sinusoid_pfl3_right = cos(angles*deg_to_rad - peak_pfl3_right*deg_to_rad); % Right PFL3
    sinusoid_pfl3_left = cos(angles*deg_to_rad - peak_pfl3_left*deg_to_rad); % Left PFL3

    sinusoid_pfl3_right_pfn = sinusoid_pfl3_right + sinusoid_pfn_combined; % Right PFL3 + total PFN input
    sinusoid_pfl3_left_pfn = sinusoid_pfl3_left + sinusoid_pfn_combined; % Left PFL3 + total PFN input
    sinusoid_pfl3_right_hDeltaC = sinusoid_pfl3_right + sinusoid_hDeltaC_output; % Right PFL3 + hDeltaC Output
    sinusoid_pfl3_left_hDeltaC = sinusoid_pfl3_left + sinusoid_hDeltaC_output; % Left PFL3 + hDeltaC Output

    sinusoid_pfl2_right = cos(angles*deg_to_rad - peak_pfl2_right*deg_to_rad); % Right PFL2
    sinusoid_pfl2_left = cos(angles*deg_to_rad - peak_pfl2_left*deg_to_rad); % Left PFL2

    sinusoid_pfl2_right_pfn = sinusoid_pfl2_right + sinusoid_pfn_combined; % Right PFL2 + total PFN input
    sinusoid_pfl2_left_pfn = sinusoid_pfl2_left + sinusoid_pfn_combined; % Left PFL2 + total PFN input
    sinusoid_pfl2_right_hDeltaC = sinusoid_pfl2_right + sinusoid_hDeltaC_output; % Right PFL2 + hDeltaC Output
    sinusoid_pfl2_left_hDeltaC = sinusoid_pfl2_left + sinusoid_hDeltaC_output; % Left PFL2 + hDeltaC Output


    % No odor - PFL3
    right_pfl3_max = max(sinusoid_pfl3_right_pfn);
    left_pfl3_max = max(sinusoid_pfl3_left_pfn);
    percent_right_pfl3_recruitment = right_pfl3_max / (right_pfl3_max + left_pfl3_max)*100;
    
    
    % Odor - PFL3
    right_pfl3_max_odor = max(sinusoid_pfl3_right_hDeltaC);
    left_pfl3_max_odor = max(sinusoid_pfl3_left_hDeltaC);
    percent_right_pfl3_recruitment_odor = right_pfl3_max_odor / (right_pfl3_max_odor + left_pfl3_max_odor)*100;
    
    % No odor - PFL2
    right_pfl2_max = max(sinusoid_pfl2_right_pfn);
    left_pfl2_max = max(sinusoid_pfl2_left_pfn);
    percent_right_pfl2_recruitment = right_pfl2_max + left_pfl2_max;
    
    % Odor - PFL2
    right_pfl2_max_odor = max(sinusoid_pfl2_right_hDeltaC);
    left_pfl2_max_odor = max(sinusoid_pfl2_left_hDeltaC);
    percent_right_pfl2_recruitment_odor = right_pfl2_max_odor + left_pfl2_max_odor;
end

