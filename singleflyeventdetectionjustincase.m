%%OLD COPY JUST IN CASE 

function index=singleflyeventdetection(headpath,fileexpnum,version,saveex,picknew,savefigs)
%This is for doing every trial, plotting the colour, and the sum of
%detected events

%make another version that does the mean

if ~picknew
    load('paperexample')
end
if version==2
    cd('extracted2')
    if picknew
        savefilename=strcat(fileexpnum,'_analysis2');
    end
else
    cd('extracted')
    if picknew
        savefilename=strcat(fileexpnum,'_analysis');
    end
end

load(savefilename);
cd(headpath);
%make a picker in here to select the ROI you want to look at?


[numROIs,triallength]=size(fluordata.one{1});
% if there are 9 ROIs skip the 1st since it's a;;
% this will need to change if you want to do this for any data other than
% FB where there's 8 cols
if numROIs==9
    jj=2;
elseif numROIs==8
    jj=1;
else
    jj=1;
    disp('ROIcount WRONGGGGG');
end

fig4=figure('Position',[609,550,500,800]);
figure(fig4);
allthresholded=[];
allthresholdedcolour=[];
alldirs=[];
dirthresh={};
dirthresh.one=[];
dirthresh.two=[];
dirthresh.three=[];
dirthresh.four=[];
dirthresh.five=[];
dirthreshcolour=dirthresh;

facecolours=[[1 1 1];[186/225,141/255,180/255];[25/255,101/255,176/255];[78/255,178/255,101/255];[247/255,203/255,69/255];[220/255,5/255,12/255]];
colormap(facecolours)
for p=jj:numROIs
    
    index=p;
    
    allaxes={};
    fn=fieldnames(fluordata);% this is the directions
    
    %facecolours=colormap(hsv(numel(fn)));
    colours={[186/225,141/255,180/255];[25/255,101/255,176/255];[78/255,178/255,101/255];[247/255,203/255,69/255];[220/255,5/255,12/255]};
    tvec=linspace(1,triallength,triallength)/FrameRate;
    directionnames={'-90','-45','0','45','90'};
    %fig2=figure('Position',[1, 1, 500, 900]);
    %fig3=figure('Position',[609,200,900,280]);
    
    %annoyingly concat data 
    currentfluor.one=[fluordata.('one'){1}(index,:);fluordata.('one'){2}(index,:);fluordata.('one'){3}(index,:);fluordata.('one'){4}(index,:);fluordata.('one'){5}(index,:)];
    currentfluor.two=[fluordata.('two'){1}(index,:);fluordata.('two'){2}(index,:);fluordata.('two'){3}(index,:);fluordata.('two'){4}(index,:);fluordata.('two'){5}(index,:)];
    currentfluor.three=[fluordata.('three'){1}(index,:);fluordata.('three'){2}(index,:);fluordata.('three'){3}(index,:);fluordata.('three'){4}(index,:);fluordata.('three'){5}(index,:)];
    currentfluor.four=[fluordata.('four'){1}(index,:);fluordata.('four'){2}(index,:);fluordata.('four'){3}(index,:);fluordata.('four'){4}(index,:)];
    currentfluor.five=[fluordata.('five'){1}(index,:);fluordata.('five'){2}(index,:);fluordata.('five'){3}(index,:);fluordata.('five'){4}(index,:);fluordata.('five'){5}(index,:)];
    currentfluor.one=[fluordata_red.('one'){1}(index,:);fluordata_red.('one'){2}(index,:);fluordata_red.('one'){3}(index,:);fluordata_red.('one'){4}(index,:);fluordata_red.('one'){5}(index,:)];
    currentfluor.two=[fluordata_red.('two'){1}(index,:);fluordata_red.('two'){2}(index,:);fluordata_red.('two'){3}(index,:);fluordata_red.('two'){4}(index,:);fluordata_red.('two'){5}(index,:)];
    currentfluor.three=[fluordata_red.('three'){1}(index,:);fluordata_red.('three'){2}(index,:);fluordata_red.('three'){3}(index,:);fluordata_red.('three'){4}(index,:);fluordata_red.('three'){5}(index,:)];
    currentfluor.four=[fluordata_red.('four'){1}(index,:);fluordata_red.('four'){2}(index,:);fluordata_red.('four'){3}(index,:);fluordata_red.('four'){4}(index,:);fluordata_red.('four'){5}(index,:)];
    currentfluor.five=[fluordata_red.('five'){1}(index,:);fluordata_red.('five'){2}(index,:);fluordata_red.('five'){3}(index,:);fluordata_red.('five'){4}(index,:);fluordata_red.('five'){5}(index,:)];
    
    
    currentfluor=rmmotion_cell(currentfluor,currentred,0.08,FrameRate);
    
    %figure out max and min for scaling
    overallmax=0;
    overallmin=0;
    for k=1:numel(fn)
        for q=1:numel(fluordata.(fn{k}))
            currmax=max(fluordata.(fn{k}){q}(index,:));
            currmin=min(fluordata.(fn{k}){q}(index,:));
            if currmax>overallmax
                overallmax=currmax;
            end
            if currmin<overallmin
                overallmin=currmin;
            end
        end
    end
    
    
    
    
    
    
    
    %mode1=0;
    for k=1:5
        
        windowstart=0.5;
        windowend=5;
        bases=[nanmean(fluordata.(fn{k}){1}(index,FrameRate*windowstart:FrameRate*windowend)),nanmean(fluordata.(fn{k}){2}(index,FrameRate*windowstart:FrameRate*windowend)),nanmean(fluordata.(fn{3}){1}(index,FrameRate*windowstart:FrameRate*windowend)),nanmean(fluordata.(fn{k}){4}(index,FrameRate*windowstart:FrameRate*windowend)),nanmean(fluordata.(fn{k}){5}(index,FrameRate*windowstart:FrameRate*windowend))];
        stdbases=[nanstd(fluordata.(fn{k}){1}(index,FrameRate*windowstart:FrameRate*windowend)),nanstd(fluordata.(fn{k}){2}(index,FrameRate*windowstart:FrameRate*windowend)),nanstd(fluordata.(fn{3}){1}(index,FrameRate*windowstart:FrameRate*windowend)),nanstd(fluordata.(fn{k}){4}(index,FrameRate*windowstart:FrameRate*windowend)),nanstd(fluordata.(fn{k}){5}(index,FrameRate*windowstart:FrameRate*windowend))];
        % if mode1
        stdmult=5;
        threshdat=[gt(fluordata.(fn{k}){1}(index,:),bases(1)+stdmult*stdbases(1));gt(fluordata.(fn{k}){2}(index,:),bases(2)+stdmult*stdbases(2));gt(fluordata.(fn{k}){3}(index,:),bases(3)+stdmult*stdbases(3));gt(fluordata.(fn{k}){4}(index,:),bases(4)+stdmult*stdbases(4));gt(fluordata.(fn{k}){5}(index,:),bases(5)+stdmult*stdbases(5))];
        
        
        dirthresh.(fn{k})=[dirthresh.(fn{k}),threshdat];
        dirthreshcolour.(fn{k})=[dirthreshcolour.(fn{k}),k*threshdat];
        allthresholded=[allthresholded;threshdat];
        allthresholdedcolour=[allthresholdedcolour;k*threshdat];
        alldirs=[alldirs,[k,k,k,k,k]];
        % else
        blankinds=[lt(fluordata.(fn{k}){1}(index,:),bases(1)+2*stdbases(1));lt(fluordata.(fn{k}){2}(index,:),bases(2)+2*stdbases(2));lt(fluordata.(fn{k}){3}(index,:),bases(3)+2*stdbases(3));lt(fluordata.(fn{k}){4}(index,:),bases(4)+2*stdbases(4));lt(fluordata.(fn{k}){5}(index,:),bases(5)+2*stdbases(5))];
        
        
        %end
        %     subplot(1,5,k);
        %     imagesc(tvec,[0 5],blankinds);%what I really want to do is take the threshdata and stick it into one big matrix
        %     colormap('gray');
        %     axx=gca;
        %     allaxes{k}=axx;
    end
    
    %linkaxes([allaxes{1},allaxes{2},allaxes{3},allaxes{4},allaxes{5}]);
    
    
    
    % for k=1:5
    %     figure(fig4);
    %     subplot(1,5,k);
    %     yl=ylim;
    %     patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    %     patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
    %     patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
    %     title(directionnames{k});
    %     xlabel('t(s)');
    %     xlim([0 45]);
    %
    % end
    %if saveex
    %save the variables that you care about - the filename to load and the
    %ROI number that you want to select and show the trials for.
    %   saveexample='paperexample';
    %savefilename is the one to load,
    %  save(saveexample,'savefilename','index');
    %end
    
end

image(tvec,[0 200],allthresholdedcolour+1);%what I really want to do is take the threshdata and stick it into one big matrix
%colormap(flipud(gray));
set(gca,'YDir','normal')
patch([5 5 15 15],[0 200 200 0],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0 200 200 0],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0 200 200 0],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
%for k=1:200%each one is 5
%    patch([0 0 47 47],[k-1 k k k-1],facecolours((alldirs(k)),:),'FaceAlpha',0.2,'EdgeAlpha',0);
%end
hold on; plot(tvec,sum(allthresholded),'Linewidth',2,'color',[0.5,0.5,0.5])

if savefigs
    if ~exist('threshplots', 'dir')
        mkdir('threshplots');
    end
    cd('threshplots');
    savefig(fig4,['threshplot_',savefilename,num2str(index)]);
    print(fig4,['threshplot_',savefilename,num2str(index)],'-dpdf','-painters');
    cd(headpath);
end
yt=0:25:175;
yticks(yt);
yticklabels({'1','2','3','4','5','6','7','8'});
ylabel('Column Number');
xlabel('time (s)');
xlim([0 45]);

%figure this out later
%for kk=1:40

%    patch([0 45 45 0],[blank blank+5 blank+5 blank],'FaceAlpha',0.2,'EdgeAlpha'0);

%figure; hold on;
%colormap(facecolours)
%something is messed up I don't know
%subplot(151); hold on;
%image(tvec,[0 5],dirthreshcolour.one+1); plot(tvec,sum(dirthresh.one),'Linewidth',2,'color',[0.5,0.5,0.5])
%subplot(152);hold on;
%image(tvec,[0 5],dirthreshcolour.two+1);plot(tvec,sum(dirthresh.two),'Linewidth',2,'color',[0.5,0.5,0.5])
%subplot(153);hold on;
%image(tvec,[0 5],dirthreshcolour.three+1);plot(tvec,sum(dirthresh.three),'Linewidth',2,'color',[0.5,0.5,0.5])
%subplot(154);hold on;
%image(tvec,[0 5],dirthreshcolour.four+1);plot(tvec,sum(dirthresh.four),'Linewidth',2,'color',[0.5,0.5,0.5])
%subplot(155);hold on;
%image(tvec,[0 5],dirthreshcolour.five+1);plot(tvec,sum(dirthresh.five),'Linewidth',2,'color',[0.5,0.5,0.5])

end
