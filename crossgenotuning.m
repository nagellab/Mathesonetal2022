function chosenfluor=crossgenotuning(chosenfluor,chosenred,chosenROIs,chosentemps,chosenFrameRate)
%maybe ask it to skip some ROIs that clearly don't fit?

fig=figure('Position',[1 1 509 458]);
hold on;
fig2=figure('Position',[509, 1, 500, 200]);
fig3=figure('Position',[509, 200, 500, 200]);
fig4=figure('Position',[509, 400, 500, 200]);


fn=fieldnames(chosentemps);
facecolours=colormap(hsv(numel(fn)));
for k=1:numel(fn)
    
    %draw the ROIs around the red channel images 
    figure(fig);
    subplot(ceil(numel(fn)/2),2,k);
    %set(gca,'XColor', 'none','YColor','none')

    imagesc(chosentemps.(fn{k}));
    colormap('gray');
    hold on;
    currROI=chosenROIs.(fn{k});
    title(num2str(sum(sum(currROI))));
    B=bwboundaries(currROI);
    for n=1:length(B)
        boundary=B{n};
        patch(boundary(:,2),boundary(:,1),facecolours(k,:),'FaceAlpha',0.2,'Edgealpha',0);
    end
    axis equal
    daspect([1 1 1]);
    set(gca,'ydir','reverse');
    %set(gca,'visible','off')
    box off;
    set(gca,'xtick',[])
    set(gca,'ytick',[])
end

%now plot all the short tuning curves
%then all the long ones
%convert all to

%colours:
lightgrey=[160/255 160/255 160/255];
lightred=[250/255,150/255,145/255];
lightblue=[150/255,150/255,250/255];
lightgreen=[144/255,245/255,159/255];

%put them all together because structs don't have a great shape
base=[];
shortbase=[];
wind1=[];
shortwind1=[];
odour=[];
shortodour=[];
wind2=[];
shortwind2=[];

%chosenfluor=removemotion(chosenfluor,chosenred,0.08,chosenFrameRate);
%figure out how many trials were excluded 

for k=1:numel(fn)
    framerate=chosenFrameRate.(fn{k});
    [avgfluor,stdfluor]=averagedirections(chosenfluor.(fn{k}));

    %avgfluorperiod=fluormean(avgfluor.(fn{k}),framerate,1,1);
    
    %use the flags here for mean and short
    shortavgfluorperiod=fluormean(avgfluor,framerate,0,0);
    shortstdfluorperiod=fluormean(stdfluor,framerate,0,0);
    
    
%     figure(fig2);
%     hold on;
%     subplot(131);
%     hold on; %should be able to just take k out because it should be only 1 ROI in each case
%     plot([1 2 3 4 5],[avgfluorperiod.base.one,avgfluorperiod.base.two,avgfluorperiod.base.three,avgfluorperiod.base.four,avgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
%     plot([1 2 3 4 5],[avgfluorperiod.wind1.one,avgfluorperiod.wind1.two,avgfluorperiod.wind1.three,avgfluorperiod.wind1.four,avgfluorperiod.wind1.five],'color',lightred,'LineWidth',2);
%     title('prewind');
%     xticks([1 2 3 4 5]);
%     xticklabels({'-90','-45','0','45','90'});
%     xlabel('directions - IPSI RIGHT');
%     ylabel('delta f/f');
%     a1=gca;
%     
%     subplot(132);
%     hold on;
%     plot([1 2 3 4 5],[avgfluorperiod.base.one,avgfluorperiod.base.two,avgfluorperiod.base.three,avgfluorperiod.base.four,avgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
%     plot([1 2 3 4 5],[avgfluorperiod.odour.one,avgfluorperiod.odour.two,avgfluorperiod.odour.three,avgfluorperiod.odour.four,avgfluorperiod.odour.five],'color',lightred,'LineWidth',2);
%     title('odour');
%     xticks([1 2 3 4 5]);
%     xticklabels({'-90','-45','0','45','90'});
%     xlabel('directions - IPSI RIGHT');
%     ylabel('delta f/f');
%     a2=gca;
%     subplot(133);
%     hold on;
%     plot([1 2 3 4 5],[avgfluorperiod.base.one,avgfluorperiod.base.two,avgfluorperiod.base.three,avgfluorperiod.base.four,avgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
%     plot([1 2 3 4 5],[avgfluorperiod.wind2.one,avgfluorperiod.wind1.two,avgfluorperiod.wind2.three,avgfluorperiod.wind2.four,avgfluorperiod.wind2.five],'color',lightred,'LineWidth',2);
%     title('post wind');
%     xticks([1 2 3 4 5]);
%     xticklabels({'-90','-45','0','45','90'});
%     xlabel('directions - IPSI RIGHT');
%     ylabel('delta f/f');
%     a3=gca;
%     %linkaxes([a1,a2,a3]);
%     [base,wind1,odour,wind2]=poolfluoroverROIs(base,wind1,odour,wind2,avgfluorperiod,k);
%     
%     
%     figure(fig3);
%     subplot(131);
%     hold on;
%     plot([1 2 3 4 5],[shortavgfluorperiod.base.one,shortavgfluorperiod.base.two,shortavgfluorperiod.base.three,shortavgfluorperiod.base.four,shortavgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
%     plot([1 2 3 4 5],[shortavgfluorperiod.wind1.one,shortavgfluorperiod.wind1.two,shortavgfluorperiod.wind1.three,shortavgfluorperiod.wind1.four,shortavgfluorperiod.wind1.five],'color',lightblue,'LineWidth',2);
%     title('Short prewind');
%     xticks([1 2 3 4 5]);
%     xticklabels({'-90','-45','0','45','90'});
%     xlabel('directions - IPSI RIGHT');
%     ylabel('delta f/f');
%     a4=gca;
%     subplot(132);
%     hold on;
%     plot([1 2 3 4 5],[shortavgfluorperiod.base.one,shortavgfluorperiod.base.two,shortavgfluorperiod.base.three,shortavgfluorperiod.base.four,shortavgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
%     plot([1 2 3 4 5],[shortavgfluorperiod.odour.one,shortavgfluorperiod.odour.two,shortavgfluorperiod.odour.three,shortavgfluorperiod.odour.four,shortavgfluorperiod.odour.five],'color',lightblue,'LineWidth',2);
%     title('short odour');
%     xticks([1 2 3 4 5]);
%     xticklabels({'-90','-45','0','45','90'});
%     xlabel('directions - IPSI RIGHT');
%     ylabel('delta f/f');
%     a5=gca;
%     subplot(133);
%     hold on;
%     plot([1 2 3 4 5],[shortavgfluorperiod.base.one,shortavgfluorperiod.base.two,shortavgfluorperiod.base.three,shortavgfluorperiod.base.four,shortavgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
%     plot([1 2 3 4 5],[shortavgfluorperiod.wind2.one,shortavgfluorperiod.wind1.two,shortavgfluorperiod.wind2.three,shortavgfluorperiod.wind2.four,shortavgfluorperiod.wind2.five],'color',lightblue,'LineWidth',2);
%     title('short post wind');
%     xticks([1 2 3 4 5]);
%     xticklabels({'-90','-45','0','45','90'});
%     xlabel('directions - IPSI RIGHT');
%     ylabel('delta f/f');
%     a6=gca;
%     [shortbase,shortwind1,shortodour,shortwind2]=poolfluoroverROIs(shortbase,shortwind1,shortodour,shortwind2,shortavgfluorperiod,k);
    
    figure(fig4);
    %subplot(131);
    %hold on;
    %plot([1 2 3 4 5],[shortavgfluorperiod.base.one,shortavgfluorperiod.base.two,shortavgfluorperiod.base.three,shortavgfluorperiod.base.four,shortavgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
    %plot([1 2 3 4 5],[shortavgfluorperiod.wind1.one-shortavgfluorperiod.base.one,shortavgfluorperiod.wind1.two-shortavgfluorperiod.base.two,shortavgfluorperiod.wind1.three-shortavgfluorperiod.base.three,shortavgfluorperiod.wind1.four-shortavgfluorperiod.base.three,shortavgfluorperiod.wind1.five-shortavgfluorperiod.base.five],'color',lightgreen,'LineWidth',2);
    %title('Short prewind');
    %xticks([1 2 3 4 5]);
    %xticklabels({'-90','-45','0','45','90'});
    %xlabel('directions - IPSI RIGHT');
    %ylabel('delta f/f');
    %a7=gca;
    subplot(132);
    hold on;
    %plot([1 2 3 4 5],[shortavgfluorperiod.base.one,shortavgfluorperiod.base.two,shortavgfluorperiod.base.three,shortavgfluorperiod.base.four,shortavgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
    %plot([1 2 3 4 5],[shortavgfluorperiod.odour.one-shortavgfluorperiod.base.one,shortavgfluorperiod.odour.two-shortavgfluorperiod.base.two,shortavgfluorperiod.odour.three-shortavgfluorperiod.base.three,shortavgfluorperiod.odour.four-shortavgfluorperiod.base.four,shortavgfluorperiod.odour.five-shortavgfluorperiod.base.five],'color',lightgreen,'LineWidth',2);
    %errorbar([1 2 3 4 5],[shortavgfluorperiod.odour.one,shortavgfluorperiod.odour.two,shortavgfluorperiod.odour.three,shortavgfluorperiod.odour.four,shortavgfluorperiod.odour.five],[shortstdfluorperiod.odour.one,shortstdfluorperiod.odour.two,shortstdfluorperiod.odour.three,shortstdfluorperiod.odour.four,shortstdfluorperiod.odour.five],'.-','color',facecolours(k,:),'capsize',0,'Linewidth',2,'MarkerSize', 20);
    plot([1 2 3 4 5],[shortavgfluorperiod.odour.one,shortavgfluorperiod.odour.two,shortavgfluorperiod.odour.three,shortavgfluorperiod.odour.four,shortavgfluorperiod.odour.five],'color',[0.5 0.5 0.5],'Linewidth',1.5);
    %plot([1,2,3,4,5],[shortavgfluorperiod.odour.one-shortavgfluorperiod.base.one,shortavgfluorperiod.odour.two-shortavgfluorperiod.base.two,shortavgfluorperiod.odour.three-shortavgfluorperiod.base.three,shortavgfluorperiod.odour.four-shortavgfluorperiod.base.four,shortavgfluorperiod.odour.five-shortavgfluorperiod.base.five])
    xlim([0 6]);
    title('short odour');
    xticks([0 1 2 3 4 5 6]);
    xticklabels({' ','-90','-45','0','45','90',' '});
    xlabel('directions - IPSI RIGHT');
    ylabel('delta f/f');
    %a8=gca;
    
    %temp change to see what it looks like if you don't subtract the wind 
    %subplot(133);
    %hold on;
    %plot([1 2 3 4 5],[shortavgfluorperiod.base.one,shortavgfluorperiod.base.two,shortavgfluorperiod.base.three,shortavgfluorperiod.base.four,shortavgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
    %plot([1 2 3 4 5],[shortavgfluorperiod.odour.one,shortavgfluorperiod.odour.two,shortavgfluorperiod.odour.three,shortavgfluorperiod.odour.four,shortavgfluorperiod.odour.five],'color',lightgreen,'LineWidth',2);
    %title('short post wind');
    %xticks([1 2 3 4 5]);
    %xticklabels({'-90','-45','0','45','90'});
    %xlabel('directions - IPSI RIGHT');
    %ylabel('delta f/f');
    %a9=gca;
    [shortbase,shortwind1,shortodour,shortwind2]=poolfluoroverROIs(shortbase,shortwind1,shortodour,shortwind2,shortavgfluorperiod,k);
    
    
    
    
    
%     subplot(133);
%     hold on;
%     %plot([1 2 3 4 5],[shortavgfluorperiod.base.one,shortavgfluorperiod.base.two,shortavgfluorperiod.base.three,shortavgfluorperiod.base.four,shortavgfluorperiod.base.five],'color',lightgrey,'LineWidth',2);
%     plot([1 2 3 4 5],[shortavgfluorperiod.wind2.one-shortavgfluorperiod.base.one,shortavgfluorperiod.wind1.two-shortavgfluorperiod.base.two,shortavgfluorperiod.wind2.three-shortavgfluorperiod.base.three,shortavgfluorperiod.wind2.four-shortavgfluorperiod.base.four,shortavgfluorperiod.wind2.five-shortavgfluorperiod.base.five],'color',lightgreen,'LineWidth',2);
%     title('short post wind');
%     xticks([1 2 3 4 5]);
%     xticklabels({'-90','-45','0','45','90'});
%     xlabel('directions - IPSI RIGHT');
%     ylabel('delta f/f');
%     a9=gca;
%     [shortbase,shortwind1,shortodour,shortwind2]=poolfluoroverROIs(shortbase,shortwind1,shortodour,shortwind2,shortavgfluorperiod,k);
end
%linkaxes([a1,a2,a3]);
%linkaxes([a4,a5,a6]);
%linkaxes([a7,a8,a9]);

%now plot the means overtop
% figure(fig2);
% subplot(131);
% plot([1 2 3 4 5],[mean(wind1.one),mean(wind1.two),mean(wind1.three),mean(wind1.four),mean(wind1.five)],'r','LineWidth',2.5);
% subplot(132);
% plot([1 2 3 4 5],[mean(odour.one),mean(odour.two),mean(odour.three),mean(odour.four),mean(odour.five)],'r','LineWidth',2.5);
% subplot(133);
% plot([1 2 3 4 5],[mean(wind2.one),mean(wind2.two),mean(wind2.three),mean(wind2.four),mean(wind2.five)],'r','LineWidth',2.5);
% 
% figure(fig3);
% subplot(131);
% plot([1 2 3 4 5],[mean(shortwind1.one),mean(shortwind1.two),mean(shortwind1.three),mean(shortwind1.four),mean(shortwind1.five)],'b','LineWidth',2.5);
% plot([1 2 3 4 5],[mean(shortbase.one),mean(shortbase.two),mean(shortbase.three),mean(shortbase.four),mean(shortbase.five)],'k','LineWidth',2.5);
% subplot(132);
% plot([1 2 3 4 5],[mean(shortodour.one),mean(shortodour.two),mean(shortodour.three),mean(shortodour.four),mean(shortodour.five)],'b','LineWidth',2.5);
% plot([1 2 3 4 5],[mean(shortbase.one),mean(shortbase.two),mean(shortbase.three),mean(shortbase.four),mean(shortbase.five)],'k','LineWidth',2.5);
% subplot(133);
% plot([1 2 3 4 5],[mean(shortwind2.one),mean(shortwind2.two),mean(shortwind2.three),mean(shortwind2.four),mean(shortwind2.five)],'b','LineWidth',2.5);
% plot([1 2 3 4 5],[mean(shortbase.one),mean(shortbase.two),mean(shortbase.three),mean(shortbase.four),mean(shortbase.five)],'k','LineWidth',2.5);

figure(fig4);
%subplot(131);
%plot([1 2 3 4 5],[mean(shortwind1.one)-mean(shortbase.one),mean(shortwind1.two)-mean(shortbase.two),mean(shortwind1.three)-mean(shortbase.three),mean(shortwind1.four)-mean(shortbase.four),mean(shortwind1.five)-mean(shortbase.five)],'g','LineWidth',2.5);
subplot(132);
%errorbar([1 2 3 4 5],,'g','LineWidth',2.5);
%errorbar([1 2 3 4 5],[nanmean(shortodour.one),nanmean(shortodour.two),nanmean(shortodour.three),nanmean(shortodour.four),nanmean(shortodour.five)],[nanstd(shortodour.one)/sqrt(sum(~isnan(shortodour.one))),nanstd(shortodour.two)/sqrt(sum(~isnan(shortodour.two))),nanstd(shortodour.three/sqrt(sum(~isnan(shortodour.three)))),nanstd(shortodour.four)/sqrt(sum(~isnan(shortodour.four))),nanstd(shortodour.five)/sqrt(sum(~isnan(shortodour.five)))],'.-','color','k','capsize',0,'Linewidth',2.5,'MarkerSize', 25);
errorbar([1 2 3 4 5],[nanmean(shortodour.one),nanmean(shortodour.two),nanmean(shortodour.three),nanmean(shortodour.four),nanmean(shortodour.five)],[nanstd(shortodour.one),nanstd(shortodour.two),nanstd(shortodour.three),nanstd(shortodour.four),nanstd(shortodour.five)],'.-','color','k','capsize',0,'Linewidth',2.5,'MarkerSize', 25);

%subplot(133);
%plot([1 2 3 4 5],[mean(shortwind2.one)-mean(shortbase.one),mean(shortwind2.two)-mean(shortbase.two),mean(shortwind2.three)-mean(shortbase.three),mean(shortwind2.four)-mean(shortbase.four),mean(shortwind2.five)-mean(shortbase.five)],'g','LineWidth',2.5);
%plot([1 2 3 4 5],[mean(shortodour.one),mean(shortodour.two),mean(shortodour.three),mean(shortodour.four),mean(shortodour.five)],'g','LineWidth',2.5);

odourtable=[shortodour.one,shortodour.two,shortodour.three,shortodour.four,shortodour.five];
%directionlabel=[1*ones(numel(shortodour.one),1),2*ones(numel(shortodour.two),1),3*ones(numel(shortodour.three),1),4*ones(numel(shortodour.four),1),5*ones(numel(shortodour.five),1)];

%flylabel=(1:1:numel(shortodour.one))'.*ones(9,5)
anova1(odourtable);


kruskalwallis(odourtable);


fxx=figure('color','white', 'Units','Inches','position',[0 0 0.42 0.72],'ToolBar','none'); hold on; 

shortodourmean=nanmean([shortodour.one,shortodour.two,shortodour.three,shortodour.four,shortodour.five],2);
shortwindmean=nanmean([shortwind1.one,shortwind1.two,shortwind1.three,shortwind1.four,shortwind1.five],2);

for k=1:numel(shortodourmean)
    plot([1,2],[shortwindmean(k),shortodourmean(k)],'color',[0.5 0.5 0.5]);
end
plot([1,2],[nanmean(shortwindmean),nanmean(shortodourmean)],'k','Linewidth',2);
xlim([0 3]);

[h,p]=ttest(shortwindmean,shortodourmean)
xticks([1 2]);
xticklabels({'wind','odour'});
ylabel('DF/f');
set(gca, 'FontName', 'Helvetica')
set(findall(gcf,'-property','FontSize'),'FontSize',6)

disp(num2str(p));


end
%eventually will need to plot mean too
