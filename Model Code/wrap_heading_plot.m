% Function that converts heading signal into a plottable version of wrapped heading
% (between 0 and 360 deg with no vertical lines when heading jumps from 0
% to 360 or vice versa). Function also downsamples heading signal to make
% plots editable in illistrator.
% @param heading_time: intial unwrapped heading signal
% @param time_steps: time steps associated with heading_time
% @output heading_time_ds: wrapped and downsampled heading
% @output time_steps_ds: time steps associated with heading_time_ds
function [heading_time_ds, time_steps_ds] = wrap_heading_plot(heading_time, time_steps)
    % This function keeps track of whether the heading is within or outside of 0 and 360
    % degrees. If outside, the first outside data point must be kept as it's value
    % to allow the heading line to go fully towards the edge of the plot, the second data 
    % point must be set to NaN to create a break in the plotting, the third
    % data point must be set at the opposite side of the wrapped plot (if over, put near 0. 
    % If under, put near 360), the fourth data point and beyond must be wrapped (subtract or 
    % add a multiple of 360). To do this, we must keep track of 1) are we in range of 0 and 
    % 360 deg? 2) if over 360, how many time points since that crossing have passed? 3) if 
    % under 0, how many time points since that crossing have passed? 4) If back within range, 
    % how many time points since that crossing?     
    
    % Initialize the variables to track these values^
    in_range = 1;
    out_most_recent_over = -999; % Use some large negative number as a placeholder
    out_most_recent_under = -999; % Use some large negative number as a placeholder
    in_most_recent_over = -999; % Use some large negative number as a placeholder
    in_most_recent_under = -999; % Use some large negative number as a placeholder
    
    % We also want to downsample the 20000 Hz data to make editing the plots in
    % illustrator possible.
    t_ds = 0; % Keep track of "time" in downsampled space
    
    heading_time_ds = zeros(1, floor(length(heading_time)/100));
    time_steps_ds = zeros(1, floor(length(heading_time)/100));
    
    % Loop through heading signal
    for t = 1:length(heading_time)
        if rem(t, 100) == 0 % Downsample - only consider every 100th data point
            t_ds = t_ds + 1; % Update downsampled time
            time_steps_ds(t_ds) = time_steps(t);
        
            if in_range % Between 0 and 360 degrees
                if (t_ds - in_most_recent_over == 1) || (t_ds - in_most_recent_under == 1) % If 1 data point after going over or going under back into range, replace with NaN
                    heading_time_ds(t_ds) = NaN;
                elseif heading_time(t) <= 360 && heading_time(t) > 180 && (t_ds - in_most_recent_under == 2) % If data just wrapped up to 360 (went back below 0) and 2 data points after cross over, replace with 361
                    heading_time_ds(t_ds) = 361;
                elseif heading_time(t) >= 0 && heading_time(t) < 180 && (t_ds - in_most_recent_over == 2) % If data just wrapped up to 0 (went back above 360) and 2 data points after cross over, replace with -1
                    heading_time_ds(t_ds) = -1;
                elseif heading_time(t) > 360 % If data goes over 360, change in_range to 0 and update times
                    out_most_recent_over = t_ds;
                    in_range = 0;
                    heading_time_ds(t_ds) = heading_time(t);
                elseif heading_time(t) < 0 % If data goes under 0, change in_range to 0 and update times
                    out_most_recent_under = t_ds;
                    in_range = 0;
                    heading_time_ds(t_ds) = heading_time(t);
                else
                    heading_time_ds(t_ds) = heading_time(t); % Don't change anything
                end

            else
                if (t_ds - out_most_recent_over == 1) || (t_ds - out_most_recent_under == 1)  % If 1 data point after going over or going under out of range, replace with NaN
                    heading_time_ds(t_ds) = NaN;
                elseif heading_time(t) > 360 && (t_ds - out_most_recent_over == 2) % If data just went over 360 and 2 data points after cross over, replace with -1       
                    heading_time_ds(t_ds) = -1;
                elseif heading_time(t) < 0 && (t_ds - out_most_recent_under == 2) % If data just went under 0 and 2 data points after cross over, replace with 361     
                    heading_time_ds(t_ds) = 361;
                elseif heading_time(t) > 360 && (t_ds - out_most_recent_over > 2) % If data is above 360, but >2 data points since crossing, wrap heading
                    heading_time_ds(t_ds) = heading_time(t) - 360;
                elseif heading_time(t) < 0 && (t_ds - out_most_recent_under > 2) % If data is under 0, but >2 data points since crossing, wrap heading
                    heading_time_ds(t_ds) = heading_time(t) + 360;
                elseif heading_time(t) >= 0 && heading_time(t) < 180 % If data comes back over 0, change in_range to 1 and update times
                    heading_time_ds(t_ds) = heading_time(t) + 360;
                    in_range = 1;
                    in_most_recent_over = t_ds;
                elseif heading_time(t) <= 360 && heading_time(t) > 180 % If data comes back under 360, change in_range to 1 and update times
                    heading_time_ds(t_ds) = heading_time(t) - 360;
                    in_range = 1;
                    in_most_recent_under = t_ds;                
                end
            end
        end
    end

end