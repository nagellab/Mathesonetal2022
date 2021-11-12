function index=alltrialstimecourse_paper(chosenfluor,chosenframerate,fileexpnum,savefigs)
%use this one when the data has been analyzed before and saved.
%return the index of the example to be saved with the filename for the
%paper

savefilename=strcat('exp',strcat(fileexpnum,'_analysis2'));

fluordata=chosenfluor.(savefilename);
FrameRate=chosenframerate.(savefilename);

[~,triallength]=size(fluordata.one);
index=1;
allaxes={};
fn=fieldnames(fluordata);% this is the directions
facecolours=colormap(hsv(numel(fn)));%average colours
colours={[186/225,141/255,180/255];[25/255,101/255,176/255];[78/255,178/255,101/255];[247/255,203/255,69/255];[220/255,5/255,12/255]};%direction colours

fig2=figure('Position',[1, 1, 500, 900]);
fig3=figure('Position',[609,200,900,280]);
%fig3=figure('color','white','Units','Inches','position',[0 0 2.5 1.55],'ToolBar','none');




%figure out max and min for scaling
overallmax=0;
overallmin=inf;
for k=1:numel(fn)
    currmax=max(fluordata.(fn{k})(index,3:end));
    currmin=min(fluordata.(fn{k})(index,3:end));
    if currmax>overallmax
        overallmax=currmax;
    end
    if currmin<overallmin
        overallmin=currmin;
    end
    
end
        


for k=1:numel(fn)%for each direction
    figure(fig2);
    subplot(5,1,k);
    hold on;
    tvec=linspace(1,triallength,triallength)/FrameRate;
    for p=1:5%for all 5 of a trial 
        fn=fieldnames(fluordata);
        facecolours=colormap(hsv(5));
        try
            % JAN 2021 This is where I can change it to look at just green
            % or just red of the diff or whatever. 
            plot(tvec,fluordata.(fn{k})(p,:),'Linewidth',2,'color',facecolours(p,:));
        catch
            disp('for real?');
        end
    end
    axx1=gca;
    allaxes1{k}=axx1;
    %add an extra and a k+1
    
    %get average traces
    avgfluor.one=mean(fluordata.one);
    avgfluor.two=mean(fluordata.two);
    avgfluor.three=mean(fluordata.three);
    avgfluor.four=mean(fluordata.four);
    avgfluor.five=mean(fluordata.five);
    
    figure(fig3);
    hold on;
    subplot(3,5,k);
    plot(tvec,avgfluor.(fn{k})(index,:),'Linewidth',2,'color',colours{k});
    axx=gca;
    allaxes{k}=axx;
    ymaxes{k}=max(avgfluor.(fn{k})(index,:));
    ymins{k}=min(avgfluor.(fn{k})(index,:));
    
    title(fn{k});
    xlim([0 45]);
    xlabel('t(s)');
    ylabel('Df/F');
    
    subplot(4,5,[5+k,10+k,15+k])
    try
        %get all five baselines (10-15)
        %have to somehow check the max and min of the whole example? can't
        %use means because some are far above or below. 
        imagesc(tvec,[0,5],[fluordata.(fn{k})],[overallmin, overallmax]);
    catch
        disp('hell no');
    end
    colormap('gray');
    xlabel('t(s)');
    yticklabels(' ');
end
linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);
directionnames={'-90','-45','0','45','90'};

figure(fig2);
linkaxes([allaxes1{1},allaxes1{2},allaxes1{3},allaxes1{4},allaxes1{5}]);
directionnames={'-90','-45','0','45','90'};



for k=1:5%this is drawing the patches on the timecourses BIG ONE LEFT
    figure(fig2);
    subplot(5,1,k);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    %xlabel('t(s)');
    xticklabels(' ');
    xlim([0 45]);
    ylabel('deltaF/F');
    
end
%now do for figure3
allaxes={};
for k=1:5
    figure(fig3);
    heatsub=subplot(4,5,[5+k,10+k,15+k]);
    tracesub=subplot(3,5,k);
    
    ylim([min(cell2mat(ymins)) max(cell2mat(ymaxes))]);
    %ylim([-0.1144    0.5547]);
    yl=ylim;
    patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    title(directionnames{k});
    xlabel('t(s)');
    %xlim([0 45]);
    pause(1) % I hate matlab without this the axes refuse to line up on the first plot.
    heatsub.Position=[tracesub.Position(1), heatsub.Position(2), tracesub.Position(3), heatsub.Position(4)];
    heatsub.XLim=[0 45];
    %axx=gca;
    %allaxes{k}=axx;
    % ylabel('deltaF/F');
end
%linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);



if savefigs
    if ~exist('singletrialex', 'dir')
        mkdir('singletrialex');
    end
    cd('singletrialex');
    savefig(fig3,['exampleheatmap_',savefilename,num2str(index)]);
    print(fig3,['exampleheatmap_',savefilename,num2str(index)],'-dpdf','-painters');
    cd(headpath);
end


end
