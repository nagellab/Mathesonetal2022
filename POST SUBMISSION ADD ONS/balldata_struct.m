function data = balldata_struct(inputdata, filenames)


for t = 1:length(inputdata{1})
    trial.filename = filenames{1}{t};
    %why does this fail-> string but should be number?
    trial.fps = round(1/mean(diff(str2double(inputdata{1}{t}(:,1)))));
    trial.wind_speed = floor(mode(str2double(inputdata{1}{t}(:,16)))*1000/60/(2.5^2*pi)*100); %cm/s
    winddir = mode(str2double(inputdata{1}{t}(:,17)));
    %convert winddir to how my code works 
    switch winddir
        case -90
            trial.winddir=5;
        case -45
            trial.winddir=4;
        case 0
            trial.winddir=3;
        case 45
            trial.winddir=2;
        case 90
            trial.winddir=1;
    end
    
    %have these been rearranged? 
    trial.light_on = max(str2double(inputdata{1}{t}(:,14)));
    trial.wind_on = max(str2double(inputdata{1}{t}(:,15)));
    if isempty(strfind(filenames{1}{t}, 'CL'))
        trial.closed_loop = 0;
    else
        trial.closed_loop = 1;
    end
    trial.gain = mode(inputdata{1}{t}(:,13));
    trial.light = inputdata{1}{t}(:,14);
    trial.wind  = inputdata{1}{t}(:,15);
    
    trial.frame = inputdata{1}{t}(:,2);
    ts = inputdata{1}{t}(:,1);
    if isempty(ts)
        trial.calc_ts=NaN;
    else
        trial.calc_ts = ts + diff([str2double(ts(1)), str2double(trial.frame(1))/trial.fps]);
    end
    
    head = unwrap(-str2double(inputdata{1}{t}(:,3)))*180/pi; %fictrac heading
    if isempty(head)
        trial.calc_heading=NaN;
    else
        trial.calc_heading = wrapTo180(head-head(1)); %starts at zero
    end
    
    wp = str2double(inputdata{1}{t}(:,12))/2310*2*360;
    if isempty(wp)
        trial.calc_windpos=NaN;
    else
        %threshold filters derivatives for long durations of bad mposes (up to 50 samples)
        for ii = 1:60
            dwp = find(diff(wp) > 4); %deriv thresh
            if ~isempty(dwp)
                for i = 1:length(dwp)
                    if wp(dwp(i) + 1) > 32 %error pos thresh
                        wp(dwp(i)) = wp(dwp(i) + 1);
                    else
                        wp(dwp(i) + 1) = wp(dwp(i));
                    end
                end
            end
        end
        trial.calc_windpos = wrapTo180(wp);
    end
    if isempty(inputdata{1}{t}(:,4))
        trial.calc_speed=NaN;
    else
        trial.calc_speed = str2double(inputdata{1}{t}(:,4))*9.52/2*trial.fps;
    end
    if isempty(-str2double(inputdata{1}{t}(:,9)))
        trial.calc_deltaz=NaN;
    else
        trial.calc_deltaz = -str2double(inputdata{1}{t}(:,9))*trial.fps;
    end
    trial.analog = str2double(inputdata{1}{t}(:,19));
    
    %     out{t}.frame_num = data{1}{t}(:,2);
    %     out{t}.FTheading = data{1}{t}(:,3);
    %     out{t}.FTspeed = data{1}{t}(:,4);
    %     out{t}.heading = data{1}{t}(:,5);
    %     out{t}.delta_roll = data{1}{t}(:,6);
    %     out{t}.delta_pitch = data{1}{t}(:,7);
    %     out{t}.unfilt_delta_heading = data{1}{t}(:,8);
    %     out{t}.delta_heading = data{1}{t}(:,9);
    %     out{t}.motorvoltage = data{1}{t}(:,10);
    %     out{t}.motorsign = data{1}{t}(:,11);
    %     out{t}.motorposition = data{1}{t}(:,12);
    data(t)=trial;
    
    %generate the filename you want
    
    
end
filename=filenames{1}{1}(1:2)
save(filename,'data');
end
