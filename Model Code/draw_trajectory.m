% Function to draw simulated fly trajectories from heading and forwad
% signal
% @param heading_time: heading over time (from simulation)
% @param forward_signal: forward signal over time (from simulation)
% @param t_pre: duration of pre-stimulus period
% @param t_stim: duration of stimulus period
% @param dt: time step between data points
function draw_trajectory(heading_time, forward_signal, t_pre, t_stim, dt)   
    % Create vectors to hold position data
    traj_x = zeros(length(heading_time)+1, 1);
    traj_y = zeros(length(heading_time)+1, 1);

    % Initiate a start point at (0,0)
    traj_x(1) = 0;
    traj_y(1) = 0;
    traj_xn = 0;
    traj_yn = 0;

    for i = 1:length(heading_time)
        % Find new position using forward speed and heading signal
        traj_x(i+1) = traj_x(i) + dt * forward_signal(i) * sin(heading_time(i)*pi/180) / 1000;
        traj_y(i+1) = traj_y(i) + dt * forward_signal(i) * cos(heading_time(i)*pi/180) / 1000;
    end
    
    % Plot
    figure; hold on
    plot(traj_x(1:t_pre/dt), traj_y(1:t_pre/dt), 'color', [0.351, 0.351, 0.351], 'linewidth', 1.5)
    plot(traj_x(t_pre/dt+1:t_pre/dt + t_stim/dt), traj_y(t_pre/dt+1:t_pre/dt + t_stim/dt), 'color', [0.75, 0, 0], 'linewidth', 1.5)
    plot(traj_x(t_pre/dt + t_stim/dt + 1 : end), traj_y(t_pre/dt + t_stim/dt + 1 : end), 'color', [0.32, 0.68, 0.34], 'linewidth', 1.5)
    xlim([-10, 10])
    ylim([-10, 100])
    set(gca,'dataaspectratio',[1 1 1]);

end