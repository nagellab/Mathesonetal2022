
cd('vt062617');
filelist=dir;% generate a list of the hdeltaC flies

%% Look at ALL columns that go above baseline
counter=1;
allcols=[];
%store data for all the different directions
oneall=[];
twoall=[];
threeall=[];
fourall=[];
fiveall=[];
%keep count of how many responsive columns there are for each direction
onecounter=1;
twocounter=1;
threecounter=1;
fourcounter=1;
fivecounter=1;
for k=1:numel(filelist)
    dataname=filelist(k).name;%get data name for each hdeltac fly
    
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);%load the data for each
        
        for jj=2:9 % go through columns sequentially - skip the first becase its an ROI around all columns
            oneall(counter,:)=avgfluor.one(jj,:);
            twoall(counter,:)=avgfluor.two(jj,:);
            threeall(counter,:)=avgfluor.three(jj,:);
            fourall(counter,:)=avgfluor.four(jj,:);
            fiveall(counter,:)=avgfluor.five(jj,:);
            counter=counter+1;
        end
        
    end
    
end




% now take calculate which of the data are above 2std from baseline
fugh=figure;hold on; %make a figure
respcounter=1; %count responsive columns
fullgood=[];%put all together
tvec=linspace(1,236,236)/5;%all have same framerate - hardcode the trial length
for k=1:size(oneall,1)
    
    temp1=oneall(k,:);
    temp2=twoall(k,:);
    temp3=threeall(k,:);
    temp4=fourall(k,:);
    temp5=fiveall(k,:);
    %calculate baseline period excluding first few samples for shutter lab
    base1=mean(temp1(3:25));
    base2=mean(temp2(3:25));
    base3=mean(temp3(3:25));
    base4=mean(temp4(3:25));
    base5=mean(temp5(3:25));
    %calculate the standard deviation of the baseline
    basestd1=std(temp1(3:25));
    basestd2=std(temp2(3:25));
    basestd3=std(temp3(3:25));
    basestd4=std(temp4(3:25));
    basestd5=std(temp5(3:25));
    %calculate the response to wind 
    meanwind1=mean(temp1(25:50));
    meanwind2=mean(temp2(25:50));
    meanwind3=mean(temp3(25:50));
    meanwind4=mean(temp4(25:50));
    meanwind5=mean(temp5(25:50));
    %calculate the response to odour
    mean1=mean(temp1(75:100));
    mean2=mean(temp2(75:100));
    mean3=mean(temp3(75:100));
    mean4=mean(temp4(75:100));
    mean5=mean(temp5(75:100));
    %calculate the response to post odour wind
    meanwindoff1=mean(temp1(125:150));
    meanwindoff2=mean(temp2(125:150));
    meanwindoff3=mean(temp3(125:150));
    meanwindoff4=mean(temp4(125:150));
    meanwindoff5=mean(temp5(125:150));
    %calculate the response to the offset of wind 
    meanoff1=mean(temp1(175:200));
    meanoff2=mean(temp2(175:200));
    meanoff3=mean(temp3(175:200));
    meanoff4=mean(temp4(175:200));
    meanoff5=mean(temp5(175:200));
    
    
    
    %Does the column show a response? 
    factor=2;%how many standard devistions 
    if (mean1>(base1+factor*basestd1)||meanwind1>(base1+factor*basestd1)||meanwindoff1>(base1+factor*basestd1)||meanoff1>(base1+factor*basestd1))
        figure(fugh);%for all those above for first direction - plot
        subplot(1,5,1);
        hold on; plot(downsample(tvec,2),downsample(oneall(k,:),2),'color',[0.5 0.5 0.5]);
        fullgood(respcounter,:)=oneall(k,:);%collect all responsive columns together 
        respcounter=respcounter+1;
        goodones(onecounter,:)=oneall(k,:);
        
        onecounter=onecounter+1;
        ylim([0.9 1.5]);
    end
    if (mean2>(base2+factor*basestd2)||meanwind2>(base2+factor*basestd2)||meanwindoff2>(base2+factor*basestd2)||meanoff2>(base2+factor*basestd2))
        figure(fugh);
        subplot(1,5,2);
        hold on; plot(downsample(tvec,2),downsample(twoall(k,:),2),'color',[0.5 0.5 0.5]);
        goodtwos(twocounter,:)=twoall(k,:);
        fullgood(respcounter,:)=twoall(k,:);
        respcounter=respcounter+1;
        twocounter=twocounter+1;
        ylim([0.9 1.5]);

    end
    if (mean3>(base1+factor*basestd3)||meanwind3>(base3+factor*basestd3)||meanwindoff3>(base3+factor*basestd3)||meanoff3>(base3+factor*basestd3))
        figure(fugh);
        subplot(1,5,3);
        hold on; plot(downsample(tvec,2),downsample(threeall(k,:),2),'color',[0.5 0.5 0.5]);
        goodthrees(threecounter,:)=threeall(k,:);
        threecounter=threecounter+1;
        fullgood(respcounter,:)=threeall(k,:);
        respcounter=respcounter+1;
        ylim([0.9 1.5]);

    end
    if (mean4>(base4+factor*basestd4)||meanwind4>(base4+factor*basestd4)||meanwindoff4>(base4+factor*basestd4)||meanoff4>(base4+factor*basestd4))
        figure(fugh);
        subplot(1,5,4);
        hold on; plot(downsample(tvec,2),downsample(fourall(k,:),2),'color',[0.5 0.5 0.5]);
        goodfours(fourcounter,:)=fourall(k,:);
        fourcounter=fourcounter+1;
        fullgood(respcounter,:)=fourall(k,:);
        respcounter=respcounter+1;
        ylim([0.9 1.5]);

    end
    if (mean5>(base5+factor*basestd5)||meanwind5>(base5+factor*basestd5)||meanwindoff5>(base5+factor*basestd5)||meanoff5>(base5+factor*basestd5))
        figure(fugh);
        subplot(1,5,5);
        hold on; plot(downsample(tvec,2),downsample(fiveall(k,:),2),'color',[0.5 0.5 0.5]);
        goodfives(fivecounter,:)=fiveall(k,:);
        fivecounter=fivecounter+1;
        fullgood(respcounter,:)=fiveall(k,:);
        respcounter=respcounter+1;
        ylim([0.9 1.5]);
    end
    
end

%for subplots
%add stimulus window graphics and plot the mean for each direction 
subplot(1,5,1);
plot(tvec,nanmean(goodones),'k','linewidth',2);
patch([5 5 15 15],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.8 1.5 1.5 0.8],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
xlim([12.5 27.5]);
subplot(1,5,2);
plot(tvec,nanmean(goodtwos),'k','linewidth',2);
patch([5 5 15 15],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.8 1.5 1.5 0.8],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
xlim([12.5 27.5]);
subplot(1,5,3);
plot(tvec,nanmean(goodthrees),'k','linewidth',2);
patch([5 5 15 15],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.8 1.5 1.5 0.8],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
xlim([12.5 27.5]);
subplot(1,5,4);
plot(tvec,nanmean(goodfours),'k','linewidth',2);
patch([5 5 15 15],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.8 1.5 1.5 0.8],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
xlim([12.5 27.5]);
subplot(1,5,5);
plot(tvec,nanmean(goodfives),'k','linewidth',2);
patch([5 5 15 15],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.8 1.5 1.5 0.8],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
xlim([12.5 27.5]);

plot(tvec,nanmean(fullgood),'k','linewidth',2);
patch([5 5 15 15],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.8 1.5 1.5 0.8],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.8 1.5 1.5 0.8],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
xlim([2.5 27.5]);


%Generate another figure plotting all responsive columns
figure; hold on;
shadedErrorBar(tvec,nanmean(fullgood),nanstd(fullgood));
patch([5 5 15 15],[0.95 1.2 1.2 0.95],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.95 1.2 1.2 0.95],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.95 1.2 1.2 0.95],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
ylim([0.95 1.2]);
xlim([2.5 30]);

%Make a paired plot of column responses between wind and odour
figure; hold on;
allcolbase=fullgood(:,25:50);
meanallcolbase=nanmean(allcolbase,2);
allcolodour=fullgood(:,75:100);
meanallcolodour=nanmean(allcolodour,2);

plot([1*ones(size(meanallcolbase)),2*ones(size(meanallcolbase))]',[meanallcolbase,meanallcolodour]','color',[0.5 0.5 0.5]);
plot([1,2],[nanmean(meanallcolbase),nanmean(meanallcolodour)],'k','linewidth',2);
[h,p]=ttest(meanallcolbase,meanallcolodour)



%% Plot the maximally odour responsive column?
%max direction for max column for each fly


counter=1;
allcols=[];

onemaxes=[];
twomaxes=[];
threemaxes=[];
fourmaxes=[];
fivemaxes=[];
flymaxes=[];
for k=1:numel(filelist)
    dataname=filelist(k).name;

  
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);
        columnmaxes=[];
        columndata=[];
        for jj=2:9
            onemean=mean(avgfluor.one(jj,75:100));
            twomean=mean(avgfluor.two(jj,75:100));
            threemean=mean(avgfluor.three(jj,75:100));
            fourmean=mean(avgfluor.four(jj,75:100));
            fivemean=mean(avgfluor.five(jj,75:100));
            
            [colmax,maxind]=max([onemean, twomean,threemean,fourmean,fivemean]);
            
            if maxind==1
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.one(jj,:);
            elseif maxind==2
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.two(jj,:);
            elseif maxind==3
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.three(jj,:);
            elseif maxind==4
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.four(jj,:);
            else
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.five(jj,:);
            end
        end
        
        %now figure out which column had the biggest response
        [flymax,flyind]=max(columnmaxes);
        flymaxes(k-2,:)=columndata(flyind,:);
        
        
    end
    
end


figure; hold on;

plot(tvec,flymaxes,'color',[0.5 0.5 0.5]);
plot(tvec,nanmean(flymaxes),'k','Linewidth',2);
title('maximum columns')



%% Take the max direction for each fly. Then once you have it normalize to max/min
%then plot each column relative to that

%generate the column centered figure
allmaxes=[];
figure; hold on;
counter=0;
for k=1:numel(filelist)% for each fly
    dataname=filelist(k).name;
    
    if contains(dataname,'_analysis2')
        counter=counter+1;
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);
        cols=2:9;
        %calculate the mean responses of each direction
        onemean=nanmean(avgfluor.one(cols,75:100),2);
        twomean=nanmean(avgfluor.two(cols,75:100),2);
        threemean=nanmean(avgfluor.three(cols,75:100),2);
        fourmean=nanmean(avgfluor.four(cols,75:100),2);
        fivemean=nanmean(avgfluor.five(cols,75:100),2);
        allmeans=[onemean,twomean,threemean,fourmean,fivemean];
        %take the max across directions
        [overallmax,overallmaxind]=max([max(onemean),max(twomean),max(threemean),max(fourmean),max(fivemean)]);
        %normalize
        %find the max direction
        flymax=allmeans(:,overallmaxind);
        %subtract the min
        flymax=flymax-min(flymax);
        flymax=flymax/max(flymax);
        
        
        %find max index
        [~,maxi]=max(flymax);
        %circshift flymax so the peak is at column 4 so all flies are
        %centered in the same way
        flymax=circshift(flymax,4-maxi);
        allmaxes(counter,:)=flymax;

        
    end
end

%plot the matrix of adjacently responsive columns and overlay the sum of
%the normalized resps
figure; hold on; imagesc(allmaxes)
colormap(gray)
plot(cols-1,17*mean(allmaxes),'g','linewidth',2);


clear base* all* avg* col* counter filelist five* four* three* two* one* fly* good* mean* overallmax* std* temp*