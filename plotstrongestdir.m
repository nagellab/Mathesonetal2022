function plotstrongestdir(avgfluor,redtemps,ROIs,Xpix,Ypix,framerate,maxvec)
%plot the data averaged for each ROI
%show the ROI?
fn=fieldnames(avgfluor);
[numROIs,triallength]=size(avgfluor.(fn{1}));

fig=figure('Position',[1 1 509 458]);
hold on;
subone=subplot(211);
subtwo=subplot(212);
fig2=figure('Position',[509, 1, 500, 200]);
fig3=figure('Position',[509, 200, 500, 200]);
fig4=figure('Position',[509,500,500,50]);


tvec=linspace(1,triallength,triallength)/framerate;
colours={[186/225,141/255,180/255];[25/255,101/255,176/255];[78/255,178/255,101/255];[247/255,203/255,69/255];[220/255,5/255,12/255]};
facecolours=colormap(hsv(numROIs));
popcolours=colormap(hsv(180));
popcolours=flipud(popcolours);%make it at least sort of match the colours I've used?
for k=1:numROIs
    
    figure(fig);
    subplot(211);hold on;
    %h=imagesc(redtemps{1});%just plot the first one for now
    imagesc(redtemps{1});
    colormap('gray');
    currROI=reshape(ROIs(:,k),[Ypix,Xpix]);
    B=bwboundaries(currROI);
    %for n=1:length(B)
    %    boundary=B{n};
    %    patch(boundary(:,2),boundary(:,1),facecolours(k,:),'FaceAlpha',0.2,'Edgealpha',0);
    %end
    axis equal
    daspect([1 1 1]);
    set(gca,'ydir','reverse');
    subplot(212);
    hold on;
    for p=1:numel(fn)
        plot(tvec,avgfluor.(fn{p})(k,:),'Linewidth',2,'color',colours{p});
    end
    %legend({'0R 180L','45R 135L','90RL','135R 45L','180R 0L'});
    
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    xlabel('t(s)');
    ylabel('deltaF/F');
    
    
    %    calculate the mean for different sections for each direction
    warning('off', 'MATLAB:colon:nonIntegerIndex')
    avgfluorperiod=fluormean(avgfluor,framerate,1,1);
    shortavgfluorperiod=fluormean(avgfluor,framerate,0,1);
    figure(fig);
    subplot(211);
    hold on;
    if maxvec
        [maxfluor, maxind]=max([mean(shortavgfluorperiod.odour.one(k)),mean(shortavgfluorperiod.odour.two(k)),mean(shortavgfluorperiod.odour.three(k)),mean(shortavgfluorperiod.odour.four(k)),mean(shortavgfluorperiod.odour.five(k))]);
        for n=1:length(B)
            boundary=B{n};
            patch(boundary(:,2),boundary(:,1),colours{maxind},'FaceAlpha',0.2,'Edgealpha',0);
        end
    else
        %popvec
        %make a colour system that spans 180
        
        %this is all the fluorescence 
        totalfluor=sum([shortavgfluorperiod.odour.one(k)-shortavgfluorperiod.base.one(k),shortavgfluorperiod.odour.two(k)-shortavgfluorperiod.base.two(k),shortavgfluorperiod.odour.three(k)-shortavgfluorperiod.base.three(k),shortavgfluorperiod.odour.four(k)-shortavgfluorperiod.base.four(k),shortavgfluorperiod.odour.five(k)-shortavgfluorperiod.base.five(k)]);
        v1=((shortavgfluorperiod.odour.one(k)-shortavgfluorperiod.base.one(k))/totalfluor);
        v2=((shortavgfluorperiod.odour.two(k)-shortavgfluorperiod.base.two(k))/totalfluor);
        v3=((shortavgfluorperiod.odour.three(k)-shortavgfluorperiod.base.three(k))/totalfluor);
        v4=((shortavgfluorperiod.odour.four(k)-shortavgfluorperiod.base.four(k))/totalfluor);
        v5=((shortavgfluorperiod.odour.five(k)-shortavgfluorperiod.base.five(k))/totalfluor);
        %prevent negative magnitude Make the smallest 0 so all can be on
        %the right scale
        vmin=min([v1,v2,v3,v4,v5]);
        v1=v1-vmin;
        v2=v2-vmin;
        v3=v3-vmin;
        v4=v4-vmin;
        v5=v5-vmin;
        
        [v1x,v1y]=pol2cart(deg2rad(0),v1);
        [v2x,v2y]=pol2cart(deg2rad(45),v2);
        [v3x,v3y]=pol2cart(deg2rad(90),v3);
        [v4x,v4y]=pol2cart(deg2rad(135),v4);
        [v5x,v5y]=pol2cart(deg2rad(180),v5);
        %negative angles are still a problem...... GAH
        meanx=mean([v1x,v2x,v3x,v4x,v5x]);
        meany=mean([v1y,v2y,v3y,v4y,v5y]);
        [ang,mag]=cart2pol(meanx,meany);
        ang=round(rad2deg(ang));
        try
        for n=1:length(B)
            boundary=B{n};
            patch(boundary(:,2),boundary(:,1),popcolours(ang+1,:),'FaceAlpha',0.2,'Edgealpha',0);
        end
        %convert to value and display that in the legend
        strang=num2str(ang-90);
        %legend(strang);
        text(375,20,strang,'Color',popcolours(ang+1,:),'FontSize',14)
        %colorbar(popcolours);
        catch
            disp('hm'); % the colours don't really line up
        end
    end
    
    
    
    
    










figure(fig2);
hold on;
subplot(131);
hold on;
plot([1 2 3 4 5],[avgfluorperiod.base.one(k),avgfluorperiod.base.two(k),avgfluorperiod.base.three(k),avgfluorperiod.base.four(k),avgfluorperiod.base.five(k)],'k','LineWidth',2);
plot([1 2 3 4 5],[avgfluorperiod.wind1.one(k),avgfluorperiod.wind1.two(k),avgfluorperiod.wind1.three(k),avgfluorperiod.wind1.four(k),avgfluorperiod.wind1.five(k)],'r','LineWidth',2);
title('prewind');
xticks([1 2 3 4 5]);
xticklabels({'-90','-45','0','45','90'});
xlabel('directions - IPSI RIGHT');
a1=gca;
subplot(132);
hold on;
plot([1 2 3 4 5],[avgfluorperiod.base.one(k),avgfluorperiod.base.two(k),avgfluorperiod.base.three(k),avgfluorperiod.base.four(k),avgfluorperiod.base.five(k)],'k','LineWidth',2);
plot([1 2 3 4 5],[avgfluorperiod.odour.one(k),avgfluorperiod.odour.two(k),avgfluorperiod.odour.three(k),avgfluorperiod.odour.four(k),avgfluorperiod.odour.five(k)],'r','LineWidth',2);
title('odour');
xticks([1 2 3 4 5]);
xticklabels({'-90','-45','0','45','90'});
xlabel('directions - IPSI RIGHT');
a2=gca;
subplot(133);
hold on;
plot([1 2 3 4 5],[avgfluorperiod.base.one(k),avgfluorperiod.base.two(k),avgfluorperiod.base.three(k),avgfluorperiod.base.four(k),avgfluorperiod.base.five(k)],'k','LineWidth',2);
plot([1 2 3 4 5],[avgfluorperiod.wind2.one(k),avgfluorperiod.wind1.two(k),avgfluorperiod.wind2.three(k),avgfluorperiod.wind2.four(k),avgfluorperiod.wind2.five(k)],'r','LineWidth',2);
title('post wind');
xticks([1 2 3 4 5]);
xticklabels({'-90','-45','0','45','90'});
xlabel('directions - IPSI RIGHT');
a3=gca;
linkaxes([a1,a2,a3]);

figure(fig3);
subplot(131);
hold on;
plot([1 2 3 4 5],[shortavgfluorperiod.base.one(k),shortavgfluorperiod.base.two(k),shortavgfluorperiod.base.three(k),shortavgfluorperiod.base.four(k),shortavgfluorperiod.base.five(k)],'k','LineWidth',2);
plot([1 2 3 4 5],[shortavgfluorperiod.wind1.one(k),shortavgfluorperiod.wind1.two(k),shortavgfluorperiod.wind1.three(k),shortavgfluorperiod.wind1.four(k),shortavgfluorperiod.wind1.five(k)],'b','LineWidth',2);
title('Short prewind');
xticks([1 2 3 4 5]);
xticklabels({'-90','-45','0','45','90'});
xlabel('directions - IPSI RIGHT');
a1=gca;
subplot(132);
hold on;
plot([1 2 3 4 5],[shortavgfluorperiod.base.one(k),shortavgfluorperiod.base.two(k),shortavgfluorperiod.base.three(k),shortavgfluorperiod.base.four(k),shortavgfluorperiod.base.five(k)],'k','LineWidth',2);
plot([1 2 3 4 5],[shortavgfluorperiod.odour.one(k),shortavgfluorperiod.odour.two(k),shortavgfluorperiod.odour.three(k),shortavgfluorperiod.odour.four(k),shortavgfluorperiod.odour.five(k)],'b','LineWidth',2);
title('short odour');
xticks([1 2 3 4 5]);
xticklabels({'-90','-45','0','45','90'});
xlabel('directions - IPSI RIGHT');
a2=gca;
subplot(133);
hold on;
plot([1 2 3 4 5],[shortavgfluorperiod.base.one(k),shortavgfluorperiod.base.two(k),shortavgfluorperiod.base.three(k),shortavgfluorperiod.base.four(k),shortavgfluorperiod.base.five(k)],'k','LineWidth',2);
plot([1 2 3 4 5],[shortavgfluorperiod.wind2.one(k),shortavgfluorperiod.wind1.two(k),shortavgfluorperiod.wind2.three(k),shortavgfluorperiod.wind2.four(k),shortavgfluorperiod.wind2.five(k)],'b','LineWidth',2);
title('short post wind');
xticks([1 2 3 4 5]);
xticklabels({'-90','-45','0','45','90'});
xlabel('directions - IPSI RIGHT');
a3=gca;
linkaxes([a1,a2,a3]);

figure(fig4)
colormap(popcolours);
cbh=colorbar('southoutside');
cbh.Ticks=linspace(0,1,19);
cbh.TickLabels=num2cell(-90:10:90);





figure(fig);
figure(fig2);
figure(fig3);
kwait=waitforbuttonpress;
clf(fig);
clf(fig2);
clf(fig3);
clf(fig4);




%cla(subone);
%cla(subtwo);
hold on;


end
close(fig); close(fig2); close(fig3); close(fig4);
end