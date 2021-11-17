function alltrialstimecourse_multi(headpath,fileexpnum)
%use this one when the data has been analyzed before and saved.
%compare adjacent ROIs for activity differences 
cd('extracted2')
savefilename=strcat(fileexpnum,'_analysis2');
load(savefilename);
cd(headpath);
%make a picker in here to select the ROI you want to look at?

currROI=1;

loop=true;
index1=0;
index2=0;

[numROIs,triallength]=size(fluordata_diff.one{1});

while loop
    plotfluordirections_picker(avgdiff,redtemps,ROIs,Xpix,Ypix,FrameRate,currROI);
    x=input('press s to save this as the chosen ROI, n to go next, p to go to previous q for quit','s');
    
    if strcmp(x,'1')%SAVE
        index1=currROI;
        loop=true;
        currROI=currROI+1;
        if currROI>numROIs
            currROI=1;%go back to the beginning for going over the top
        end
        close all;
    elseif strcmp(x,'2')
        index2=currROI;
        loop=false;
    elseif strcmp(x,'n')%NEXT
        currROI=currROI+1;
        close all;
        if currROI>numROIs
            currROI=1;%go back to the beginning for going over the top
        end
    elseif strcmp(x,'p')%Previous
        currROI=currROI-1;
        close all;
        if currROI==0%gone backwards from 0
            currROI=numROIs;
        end
    elseif strcmp(x,'q')%skip this particular experiment
        close all;
        loop=false;
    else
        disp('invalid input please select again');
    end
end
%close all

allaxes={};
fn=fieldnames(fluordata_diff);% this is the directions
facecolours=colormap(hsv(numel(fn)));
colours={[186/225,141/255,180/255];[25/255,101/255,176/255];[78/255,178/255,101/255];[247/255,203/255,69/255];[220/255,5/255,12/255]};

fig21=figure('Position',[1, 1, 500, 900]);
fig22=figure('Position',[500, 1, 500, 900]);
fig31=figure('Position',[1000,1,900,280]);
fig32=figure('Position',[1000,500,900,280]);
fig41=figure('Position',[1000,340,900,120]);
fig42=figure('Position',[1000,850,900,120]);
fig5=figure('Position',[1,500,900,280]);

for k=1:numel(fn)%for each direction
    figure(fig21);
    subplot(5,1,k);
    hold on;
    tvec=linspace(1,triallength,triallength)/FrameRate;
    for p=1:numel(fluordata_diff.(fn{k}))
        fn=fieldnames(fluordata_diff);
        facecolours=colormap(hsv(numel(fluordata_diff.(fn{k}))));
        try
            plot(tvec,fluordata_diff.(fn{k}){p}(index1,:),'Linewidth',2,'color',facecolours(p,:));
        catch
            disp('for real?');
        end
    end
    axx1=gca;
    allaxes1{k}=axx1;
    %add an extra and a k+1
    figure(fig31);
    hold on;
    subplot(3,5,k);
    plot(tvec,avgdiff.(fn{k})(index1,:),'Linewidth',2,'color',colours{k});
    axx=gca;
    allaxes{k}=axx;
    ymaxes{k}=max(avgdiff.(fn{k})(index1,:));
    ymins{k}=min(avgdiff.(fn{k})(index1,:));
    
    title(fn{k});
    xlim([0 45]);
    subplot(4,5,[5+k,10+k,15+k])
    try
        %get all five baselines (10-15)
        imagesc(tvec,[0,5],[fluordata_diff.(fn{k}){1}(index1,:);fluordata_diff.(fn{k}){2}(index1,:);fluordata_diff.(fn{k}){3}(index1,:);fluordata_diff.(fn{k}){4}(index1,:);fluordata_diff.(fn{k}){5}(index1,:)]);
    catch
        disp('hell no');
    end
    colormap('gray');
end
linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);
directionnames={'-90','-45','0','45','90'};

figure(fig21);
linkaxes([allaxes1{1},allaxes1{2},allaxes1{3},allaxes1{4},allaxes1{5}]);
directionnames={'-90','-45','0','45','90'};


for k=1:numel(fn)%for each direction
    figure(fig22);
    subplot(5,1,k);
    hold on;
    tvec=linspace(1,triallength,triallength)/FrameRate;
    for p=1:numel(fluordata_diff.(fn{k}))
        fn=fieldnames(fluordata_diff);
        facecolours=colormap(hsv(numel(fluordata_diff.(fn{k}))));
        try
            plot(tvec,fluordata_diff.(fn{k}){p}(index2,:),'Linewidth',2,'color',facecolours(p,:));
        catch
            disp('for real?');
        end
    end
    axx1=gca;
    allaxes1{k}=axx1;
    %add an extra and a k+1
    figure(fig32);
    hold on;
    subplot(3,5,k);
    plot(tvec,avgdiff.(fn{k})(index2,:),'Linewidth',2,'color',colours{k});
    axx=gca;
    allaxes{k}=axx;
    ymaxes{k}=max(avgdiff.(fn{k})(index2,:));
    ymins{k}=min(avgdiff.(fn{k})(index2,:));
    
    title(fn{k});
    xlim([0 45]);
    subplot(4,5,[5+k,10+k,15+k])
    try
        %get all five baselines (10-15)
        imagesc(tvec,[0,5],[fluordata_diff.(fn{k}){1}(index2,:);fluordata_diff.(fn{k}){2}(index2,:);fluordata_diff.(fn{k}){3}(index2,:);fluordata_diff.(fn{k}){4}(index2,:);fluordata_diff.(fn{k}){5}(index2,:)]);
    catch
        disp('hell no');
    end
    colormap('gray');
end
linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);
directionnames={'-90','-45','0','45','90'};

figure(fig22);
linkaxes([allaxes1{1},allaxes1{2},allaxes1{3},allaxes1{4},allaxes1{5}]);
directionnames={'-90','-45','0','45','90'};


figure(fig41);
%mode1=0;
for k=1:5
    bases=[nanmean(fluordata_diff.(fn{k}){1}(index1,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{k}){2}(index1,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{3}){1}(index1,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{k}){4}(index1,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{k}){5}(index1,FrameRate*10:FrameRate*15))];
    stdbases=[nanstd(fluordata_diff.(fn{k}){1}(index1,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{k}){2}(index1,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{3}){1}(index1,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{k}){4}(index1,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{k}){5}(index1,FrameRate*10:FrameRate*15))];
    % if mode1
    threshdat=[gt(fluordata_diff.(fn{k}){1}(index1,:),bases(1)+2*stdbases(1));gt(fluordata_diff.(fn{k}){2}(index1,:),bases(2)+2*stdbases(2));gt(fluordata_diff.(fn{k}){3}(index1,:),bases(3)+2*stdbases(3));gt(fluordata_diff.(fn{k}){4}(index1,:),bases(4)+2*stdbases(4));gt(fluordata_diff.(fn{k}){5}(index1,:),bases(5)+2*stdbases(5))];
    % else
    blankinds=[lt(fluordata_diff.(fn{k}){1}(index1,:),bases(1)+2*stdbases(1));lt(fluordata_diff.(fn{k}){2}(index1,:),bases(2)+2*stdbases(2));lt(fluordata_diff.(fn{k}){3}(index1,:),bases(3)+2*stdbases(3));lt(fluordata_diff.(fn{k}){4}(index1,:),bases(4)+2*stdbases(4));lt(fluordata_diff.(fn{k}){5}(index1,:),bases(5)+2*stdbases(5))];
    
    
    %end
    subplot(1,5,k);
    plot(tvec,movmean(sum(threshdat),3));%this is summed thresholded data. Num corresponds to number of trials that responded - should it do that or should it blank out the value and put the real value in? Could do both?
    axx=gca;
    allaxes{k}=axx;
end

linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);

figure(fig42);
%mode1=0;
for k=1:5
    bases=[nanmean(fluordata_diff.(fn{k}){1}(index2,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{k}){2}(index2,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{3}){1}(index2,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{k}){4}(index2,FrameRate*10:FrameRate*15)),nanmean(fluordata_diff.(fn{k}){5}(index2,FrameRate*10:FrameRate*15))];
    stdbases=[nanstd(fluordata_diff.(fn{k}){1}(index2,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{k}){2}(index2,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{3}){1}(index2,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{k}){4}(index2,FrameRate*10:FrameRate*15)),nanstd(fluordata_diff.(fn{k}){5}(index2,FrameRate*10:FrameRate*15))];
    % if mode1
    threshdat=[gt(fluordata_diff.(fn{k}){1}(index2,:),bases(1)+2*stdbases(1));gt(fluordata_diff.(fn{k}){2}(index2,:),bases(2)+2*stdbases(2));gt(fluordata_diff.(fn{k}){3}(index2,:),bases(3)+2*stdbases(3));gt(fluordata_diff.(fn{k}){4}(index2,:),bases(4)+2*stdbases(4));gt(fluordata_diff.(fn{k}){5}(index2,:),bases(5)+2*stdbases(5))];
    % else
    blankinds=[lt(fluordata_diff.(fn{k}){1}(index2,:),bases(1)+2*stdbases(1));lt(fluordata_diff.(fn{k}){2}(index2,:),bases(2)+2*stdbases(2));lt(fluordata_diff.(fn{k}){3}(index2,:),bases(3)+2*stdbases(3));lt(fluordata_diff.(fn{k}){4}(index2,:),bases(4)+2*stdbases(4));lt(fluordata_diff.(fn{k}){5}(index2,:),bases(5)+2*stdbases(5))];
    
    
    %end
    subplot(1,5,k);
    plot(tvec,movmean(sum(threshdat),3));%this is summed thresholded data. Num corresponds to number of trials that responded - should it do that or should it blank out the value and put the real value in? Could do both?
    axx=gca;
    allaxes{k}=axx;
end

linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}])

figure(fig5);
for k=1:5
    first=[fluordata_diff.(fn{k}){1}(index1,:);fluordata_diff.(fn{k}){2}(index1,:);fluordata_diff.(fn{k}){3}(index1,:);fluordata_diff.(fn{k}){4}(index1,:);fluordata_diff.(fn{k}){5}(index1,:)];
    second=[fluordata_diff.(fn{k}){1}(index2,:);fluordata_diff.(fn{k}){2}(index2,:);fluordata_diff.(fn{k}){3}(index2,:);fluordata_diff.(fn{k}){4}(index2,:);fluordata_diff.(fn{k}){5}(index2,:)];
    %get the correlation and lag for each trial between the two ROIs
    [c1,lags1]=xcorr(first(1,5*FrameRate:40*FrameRate),second(1,5*FrameRate:40*FrameRate),25,'coeff');
    [c2,lags2]=xcorr(first(2,5*FrameRate:40*FrameRate),second(2,5*FrameRate:40*FrameRate),25,'coeff');
    [c3,lags3]=xcorr(first(3,5*FrameRate:40*FrameRate),second(3,5*FrameRate:40*FrameRate),25,'coeff');
    [c4,lags4]=xcorr(first(4,5*FrameRate:40*FrameRate),second(4,5*FrameRate:40*FrameRate),25,'coeff');
    [c5,lags5]=xcorr(first(5,5*FrameRate:40*FrameRate),second(5,5*FrameRate:40*FrameRate),25,'coeff');
    shift1=mean(c1.*lags1);
    shift2=mean(c2.*lags2);
    shift3=mean(c3.*lags3);
    shift4=mean(c4.*lags4);
    shift5=mean(c5.*lags5);
    shifts=[shift1,shift2,shift3,shift4,shift5];
    
    subplot(1,5,k);
    hold on;
    plot([1 1 1 1 1],shifts,'o');%plot of top of each other? maybe add some jitter 
    plot(1,mean(shifts),'o','color','k','Linewidth',2);
    axx=gca;
    allaxes{k}=axx;
    xticklabels({});
    ylabel('peak lag');
    
end
linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}])


for k=1:5
    figure(fig21);
    subplot(5,1,k);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    xlim([0 45]);
    ylabel('deltaF/F');
end

for k=1:5
    figure(fig22);
    subplot(5,1,k);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    xlim([0 45]);
    ylabel('deltaF/F');
end
%now do for figure3
allaxes={};
for k=1:5
    figure(fig31);
    subplot(3,5,k);
    ylim([min(cell2mat(ymins)) max(cell2mat(ymaxes))]);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    xlim([0 45]);
    %axx=gca;
    %allaxes{k}=axx;
    % ylabel('deltaF/F');
end
%linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);
allaxes={};
for k=1:5
    figure(fig32);
    subplot(3,5,k);
    ylim([min(cell2mat(ymins)) max(cell2mat(ymaxes))]);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    xlim([0 45]);
    %axx=gca;
    %allaxes{k}=axx;
    % ylabel('deltaF/F');
end


for k=1:5
    figure(fig41);
    subplot(1,5,k);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    xlim([0 45]);
end

for k=1:5
    figure(fig42);
    subplot(1,5,k);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    xlim([0 45]);
end


end
