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


%colours:
lightgrey=[160/255 160/255 160/255];
lightred=[250/255,150/255,145/255];
lightblue=[150/255,150/255,250/255];
lightgreen=[144/255,245/255,159/255];

%put them all together 
base=[];
shortbase=[];
wind1=[];
shortwind1=[];
odour=[];
shortodour=[];
wind2=[];
shortwind2=[];



for k=1:numel(fn)
    framerate=chosenFrameRate.(fn{k});
    [avgfluor,stdfluor]=averagedirections(chosenfluor.(fn{k}));


    
    %use the flags here for mean and short
    shortavgfluorperiod=fluormean(avgfluor,framerate,0,0);
    shortstdfluorperiod=fluormean(stdfluor,framerate,0,0);
    
    

    
    figure(fig4);

    subplot(132);
    hold on;
  
    plot([1 2 3 4 5],[shortavgfluorperiod.odour.one,shortavgfluorperiod.odour.two,shortavgfluorperiod.odour.three,shortavgfluorperiod.odour.four,shortavgfluorperiod.odour.five],'color',[0.5 0.5 0.5],'Linewidth',1.5);
    xlim([0 6]);
    title('short odour');
    xticks([0 1 2 3 4 5 6]);
    xticklabels({' ','-90','-45','0','45','90',' '});
    xlabel('directions - IPSI RIGHT');
    ylabel('delta f/f');
 
    [shortbase,shortwind1,shortodour,shortwind2]=poolfluoroverROIs(shortbase,shortwind1,shortodour,shortwind2,shortavgfluorperiod,k);
    
end

figure(fig4);
subplot(132);
errorbar([1 2 3 4 5],[nanmean(shortodour.one),nanmean(shortodour.two),nanmean(shortodour.three),nanmean(shortodour.four),nanmean(shortodour.five)],[nanstd(shortodour.one),nanstd(shortodour.two),nanstd(shortodour.three),nanstd(shortodour.four),nanstd(shortodour.five)],'.-','color','k','capsize',0,'Linewidth',2.5,'MarkerSize', 25);

odourtable=[shortodour.one,shortodour.two,shortodour.three,shortodour.four,shortodour.five];
anova1(odourtable);


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

