
function plotcomparevels_multpretty(parameters,type,varargin)

% plotcomparevels_pretty (data,parameters)
%
%  give this function the resdata and will generate the timecourse for the
%  given parameters in an attractive way (less text)
%  use plotcomparevels_errorbars if you want the generic version
%
% This function produces a plot comparing the different velocities of the
% groups specified.

% Sets better color codes
if (strcmp(type,'activation'))
    colorines = [
        170/255 51/255 119/255;
        68/255 119/255 170/255;
        85/255 151/255 255/255;];%
elseif (strcmp(type,'silencing'))
    colorines = [
        187/255 187/255 187/255;
        0/255 153/255 136/255];
end

plotmin=20; %seconds to show start
plotmax=60; %seconds to show end

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
    
    if(strcmp(type,'activation'))
        f=figure('color','white', 'Units','Inches','position',[0 0 1.63 0.76],'ToolBar','none');
    elseif(strcmp(type,'silencing'))
        f=figure('color','white', 'Units','Inches','position',[0 0 1.40 0.73],'ToolBar','none');
        
    end
    
    
    set(0,'DefaultAxesTickDir', 'out')
    for p=1:length(varargin)
        data=varargin{p};
        paramdat=[];
        
        for fly = 1:length(data)
            paramdat(:,fly) = nanmean(data(fly).(param),2);
        end
        
        % Removes the last 2 seconds to avoid noisy averaging
        paramdat(end-100:end,:) = [];
        
        % Averages and allocates for the final representation
        meandata = nanmean(paramdat,2);
        
        dur = length(meandata);
        %make figure of the correct size
        
        %plot the data with errorbars
        shadedErrorBar((0.02:0.02:dur*0.02), meandata,(nanstd(paramdat')/sqrt(size(paramdat,2)))',{'color',colorines(p,:),'lineWidth',1},0)
        hold on
    end
    
    %get the information for axes
    [~,units,ax]=findbase(parameters{k});
    ylabel([units])%[ax ' ' units]
    %remove the x-axis
    xticklabels(' ');
    xticks([]);
    set(gca,'XColor','none');
    %show the region we care about
    
    
    yl=ylim;%get the ylimit
    
    %signify the period the stimulus is on
    patch([30 30 40 40],[-600 600 600 -600],[180/255 180/255 180/255],'EdgeColor',[120/255 120/255 120/255],'FaceAlpha',0.5,'EdgeAlpha',0.5)%make the y really big so that we can always account for it
    kids=get(gca,'children');
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
