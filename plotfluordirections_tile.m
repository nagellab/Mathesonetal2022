function plotfluordirections_tile(avgfluor,redtemps,ROIs,Xpix,Ypix,framerate)
%plot the data averaged for each ROI
%show the ROI?
fn=fieldnames(avgfluor);
[numROIs,triallength]=size(avgfluor.(fn{1}));

%make the layout as 3 separate figures
fig1=figure('units','normalized','outerposition',[0 0 0.2 1]);%make each figure 1/3 of the screen
set(fig1,'MenuBar','none');
set(fig1,'ToolBar','none');
hold on;
fig2=figure('units','normalized','outerposition',[0.2 0 0.2 1]);
set(fig2,'MenuBar','none');
set(fig2,'ToolBar','none');
hold on;
fig3=figure('units','normalized','outerposition',[0.4 0 0.2 1]);
set(fig3,'MenuBar','none');
set(fig3,'ToolBar','none');
hold on;
fig4=figure('units','normalized','outerposition',[0.6 0 0.2 1]);
set(fig4,'MenuBar','none');
set(fig4,'ToolBar','none');
hold on;
fig5=figure('units','normalized','outerposition',[0.8 0 0.2 1]);
set(fig5,'MenuBar','none');
set(fig5,'ToolBar','none');
hold on;



%generate some useful variables
tvec=linspace(1,triallength,triallength)/framerate;
colours={[186/225,141/255,180/255];[25/255,101/255,176/255];[78/255,178/255,101/255];[247/255,203/255,69/255];[220/255,5/255,12/255]};
facecolours=colormap(hsv(numROIs));

%for this one make 3 figures with different planes, and then plot the locations of ROIs on each
figure(fig1);
f1s1=subplot(311);
hold on;
plotcolouredROIs(f1s1,ROIs,redtemps,facecolours,1);
title('First Image');
f1s2=subplot(312);
hold on;
plotcolouredROIs(f1s2,ROIs,redtemps,facecolours,12);%something in the middle
title('Middle Image');
f1s3=subplot(313);
hold on;
plotcolouredROIs(f1s3,ROIs,redtemps,facecolours,25);
title('Last Image');


figure(fig2);
hold on;
for k=1:round(numROIs/2) %for each ROI plot the timecourse of all 5 directions
    
    tight_subplot(round(numROIs/2),1,[.01 .03],[.1 .01],[.01 .01]);
    hold on;
    for p=1:numel(fn)
        axes(ha(k));
        plot(tvec,avgfluor.(fn{p})(k,:),'Linewidth',0.5,'color',colours{p});
    end
    %legend({'0R 180L','45R 135L','90RL','135R 45L','180R 0L'});
    
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    set(gca,'XTickLabel',[]);
    set(gca,'YTickLabel',[]);

    
    %xlabel('t(s)');
    %ylabel('deltaF/F');
end


%calculate the mean for different sections for each direction
warning('off', 'MATLAB:colon:nonIntegerIndex')
avgfluorperiod=fluormean(avgfluor,framerate,1);
shortavgfluorperiod=fluormean(avgfluor,framerate,0);

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





figure(fig);
figure(fig2);
figure(fig3);
kwait=waitforbuttonpress;
clf(fig);
clf(fig2);
clf(fig3);




%cla(subone);
%cla(subtwo);
hold on;


end
end