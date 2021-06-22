function plottrackspretty(resdata,exp,trial)
%must be passed f, a figure,
%must use when there is a wind or light stimulus, use the general efren
%version (plotflytracksf) if you need to do a non-stimulus condition 
%plots without labels or axis ticks - clean for pub
fly=resdata(exp);
lims=[0 40 0 142];

currentmode= fly.mode{trial}; %get the stimulus type (odour of light)
if strcmp(currentmode,'blankalwayson10s')
    %light (finds first and last non zero entry- giving stimtimes
    stimstart=find(fly.lightstimulus(:,trial),1,'first');
    stimend=find(fly.lightstimulus(:,trial),1,'last');
elseif strcmp(currentmode,'10salwaysonblank')
    stimstart=find(fly.stimulus(:,trial),1,'first');
    stimend=find(fly.stimulus(:,trial),1,'last');
    %odour
elseif strcmp(currentmode,'blank30swind')
    stimstart=1500;%find(~fly.windstimulus(:,trial),1,'first');
    stimend=3000;%find(~fly.windstimulus(:,trial),1,'last');
elseif strcmp(currentmode,'blankalwaysonhigh')
    %light levels
    stimstart=find(fly.lightstimulus(:,trial),1,'first');
    stimend=find(fly.lightstimulus(:,trial),1,'last');
end
hold on;
%before stim
plot(fly.xfilt(1:stimstart,trial),fly.yfilt(1:stimstart,trial),'color',[88/255 88/255 88/255],'linewidth',2);
%during stim
plot(fly.xfilt(stimstart:stimend,trial),fly.yfilt(stimstart:stimend,trial),'color',[203/255 75/255 154/255],'linewidth',2);
%after stim
plot(fly.xfilt(stimend:end,trial),fly.yfilt(stimend:end,trial),'color',[20/255 177/255 75/255],'linewidth',2);

set(gca,'dataaspectratio',[1 1 1]);
axis(lims);
box on;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);




end

