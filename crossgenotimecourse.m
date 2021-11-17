function crossgenotimecourse(chosenfluor,chosenROIs,chosentemps,chosenFrameRate)
%maybe ask it to skip some ROIs that clearly don't fit?
len=15;%change
fig=figure('Position',[1 1 509 458]);
hold on;
fig2=figure('Position',[509, 1, 500, 900]);%make 5 subplots here
%fig3=figure('Position',[509, 200, 500, 200]);


fn=fieldnames(chosenfluor);
facecolours=colormap(hsv(numel(fn))); %one for each fly
for k=1:numel(fn)%basically for each fly
    
    %draw the ROIs
    figure(fig);
    subplot(ceil(numel(fn)/2),2,k);
    %set(gca,'XColor', 'none','YColor','none')
    imagesc(chosentemps.(fn{k}));
    colormap('gray');
    hold on;
    currROI=chosenROIs.(fn{k});
    B=bwboundaries(currROI);
    for n=1:length(B)
        boundary=B{n};
        patch(boundary(:,2),boundary(:,1),facecolours(k,:),'FaceAlpha',0.2,'Edgealpha',0);
    end
    axis equal
    daspect([1 1 1]);
    set(gca,'ydir','reverse');
    set(gca,'visible','off')
    box off;
    set(gca,'xtick',[])
    set(gca,'ytick',[])
end

%colours:




allaxes={};
alldat=[];
counter=1;
timing=[5,15,25,35];
%timing=[10,20,30,40];
for k=1:numel(fn)
    framerate=chosenFrameRate.(fn{k});
    figure(fig2);
    directions=fieldnames(chosenfluor.(fn{k}));
    for p=1:5%for each direction
        subplot(1,5,p);
        axx=gca;
        allaxes{p}=axx;
        hold on;
        [~,triallength]=size(chosenfluor.(fn{k}).(directions{p}));
        tvec=linspace(1,triallength,triallength)/framerate;
        plot(tvec(framerate*(timing(2)-2.5):framerate*(timing(2)-2.5+len)),nanmean(chosenfluor.(fn{k}).(directions{p})(:,framerate*(timing(2)-2.5):framerate*(timing(2)-2.5+len))),'Linewidth',1,'color',[0.5 0.5 0.5]);
        try
            currmean=nanmean(chosenfluor.(fn{k}).(directions{p})(:,1:framerate*40));
            resampall=resample(currmean,200,size(currmean,2));
            alldat(counter,:)=resampall;%plot(tvec,nanmean(chosenfluor.(fn{k}).(directions{p})),'Linewidth',2,'color',facecolours(k,:));
            counter=counter+1;
        catch
            disp('error in making mean tuning');
        end
    end
end
linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);
figure(fig2);
directionnames={'-90','-45','0','45','90'};

for k=1:5
    subplot(1,5,k);
    yl=ylim;
    patch([timing(1) timing(1) timing(2) timing(2)],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([timing(2) timing(2) timing(3) timing(3)],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([timing(3) timing(3) timing(4) timing(4)],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    xlim([0 45]);
    ylabel('deltaF/F');
end

for k=1:5
    dirmean=[];
    
    for p=1:numel(fn)%for each direction
        try
            framerate=chosenFrameRate.(fn{p});
            flydat=chosenfluor.(fn{p}).(directions{k})(:,(timing(2)-2.5)*framerate:((timing(2)-2.5)+len)*framerate);
            flymean=nanmean(flydat);%resample this to 25 
            resampflymean=resample(flymean,5*len,size(flymean,2));
            dirmean=[dirmean;resampflymean];
            
        catch
            disp('problem with the resampling');
        end
    end
    subplot(1,5,k)
    try
    tvec=linspace(timing(2)-2.5,(timing(2)-2.5+len),5*len);
    plot(tvec,nanmean(dirmean),'Linewidth',2,'color','k');
    catch
        disp('jesus');
    end
    xlim([timing(2)-2.5 (timing(2)+len-2.5)]);
end

tvec=linspace(0,40,200);
figure; hold on; shadedErrorBar(tvec,nanmean(alldat),nanstd(alldat));

patch([timing(1) timing(1) timing(2) timing(2)],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([timing(2) timing(2) timing(3) timing(3)],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([timing(3) timing(3) timing(4) timing(4)],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
ylim([0.8 2]);
%plot mean for each

end


