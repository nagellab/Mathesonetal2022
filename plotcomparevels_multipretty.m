
function [indslight,indsodour]=plotcomparevels_multipretty(data1,data2,parameters)

% plotcomparevels_pretty (data,parameters)
%
%  give this function the resdata and will generate the timecourse for the
%  given parameters in an attractive way (less text)
%  use plotcomparevels_errorbars if you want the generic version
%
% This function produces a plot comparing the different velocities of the
% groups specified.

% Sets better color codes

colorines = [51/255 187/255 238/255; 238/255 51/255 119/255];%by defauly start with grey need to add another colour
plotmin=20; %seconds to show start
plotmax=60; %seconds to show end
[indslight,indsodour]=findsameflies2conds(data1,data2);
data1=data1(indslight);
data2=data2(indsodour);%make them have the same number of flies - any fly that was filtered out of one set is now removed from the other. 
%instead of doing this just have it access the right parameters do it
%in a loop
for k=1:numel(parameters)
    if strcmp(parameters{k},'pmove')
        param='pmove';
    elseif strcmp(parameters{k},'groundspeed')
        param='vmove';
    elseif strcmp(parameters{k},'upwindvelocity')
        param='vymove';
    elseif strcmp(parameters{k},'angularvelocity')
        param='angvturn';
        parameters{k}='angv';%make match for findbase
    elseif strcmp(parameters{k},'curvature')
        param='curvature';
    elseif strcmp(parameters{k},'placepref')
        param='yfilt';
    else
        disp('please enter a valid parameter: pmove, groundspeed, upwindvelocity, angularvelocity, curvature');
    end
    paramdatlight=[];
    paramdatodour=[];
    
    for fly = 1:length(data1)%length is the same because of finding same flies
        paramdatlight(:,fly) = nanmean(data1(fly).(param),2);
        paramdatodour(:,fly)=nanmean(data2(fly).(param),2);
    end
    
    % Removes the last 2 seconds to avoid noisy averaging
    paramdatlight(end-100:end,:) = [];
    paramdatodour(end-100:end,:) = [];
    
    % Averages and allocates for the final representation
    meandatalight = nanmean(paramdatlight,2);
    meandataodour = nanmean(paramdatodour,2);
    
    durlight = length(meandatalight);
    durodour = length(meandataodour);
    %make figure of the correct size
    f=figure('color','white', 'Units','Inches','position',[0 0 1.63 0.76],'ToolBar','none');
    hold on;
    set(0,'DefaultAxesTickDir', 'out')
    
    %plot the data with errorbars
    shadedErrorBar((0.02:0.02:durlight*0.02), meandatalight,(nanstd(paramdatlight')/sqrt(size(paramdatlight,2)))',{'color',colorines(1,:),'lineWidth',1},0)
    shadedErrorBar((0.02:0.02:durodour*0.02), meandataodour,(nanstd(paramdatodour')/sqrt(size(paramdatodour,2)))',{'color',colorines(2,:),'lineWidth',1},0)

    
    %get the information for axes
    [~,units,ax]=findbase(parameters{k});
    ylabel([units]) %[ax ' ' units]
    %remove the x-axis
    xticklabels(' ');
    xticks([]);
    set(gca,'XColor','none');
    %show the region we care about
    
    
    yl=ylim;%get the ylimit
    
    %signify the period the stimulus is on
    patch([30 30 40 40],[-600 600 600 -600],[180/255 180/255 180/255],'EdgeColor',[120/255 120/255 120/255],'FaceAlpha',0.5,'EdgeAlpha',0.5)%make the y really big so that we can always account for it
    kids=get(gca,'children');%this probably isn't right anymore
    kids=uistack(kids(1),'down',8);
    set(gca,'children',kids);
    
    %set(gca,'children',flipud(get(gca,'children')))
    %set(gcf,'renderer','Painters')
    
    box off
    axis tight
    ylim(yl);%return to the regular ylim hiding all the extra patch
    xlim([plotmin, plotmax]);
    
    set(findall(gca, '-property', 'FontSize'), 'FontSize', 6)
    title(ax,'FontWeight','normal','FontSize',6);
    set(gca, 'FontName', 'Helvetica');
    
end

end
