%lets start easy - just get all the responsive ones and plot the average
%directional response
load('/Volumes/Samsung_T5 1/2-photon imaging/vt062617/incides.mat')
load('/Volumes/Samsung_T5/2-photon imaging/vt062617/incides.mat')
cd ../../../../../../../Volumes/'Samsung_T5 1'/'2-photon imaging'/vt062617
cd ../../../../../../../Volumes/'Samsung_T5'/'2-photon imaging'/vt062617

cd('extracted2');
filelist=dir;
%direction matrices
one=[];
two=[];
three=[];
four=[];
five=[];

%generate indices in a way that makes sense ->


counter=1;
allresponsivecols=[];
for k=1:numel(filelist)
    dataname=filelist(k).name;
    %cd(headpath);
    
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);
        
        currindices=indices.(fileexpnum);
        responsivecols=find(currindices);
        allresponsivecols=[allresponsivecols,responsivecols];
        if responsivecols>0
            for jj=1:numel(responsivecols)
                one(counter,:)=avgfluor.one(responsivecols(jj),:);
                two(counter,:)=avgfluor.two(responsivecols(jj),:);
                three(counter,:)=avgfluor.three(responsivecols(jj),:);
                four(counter,:)=avgfluor.four(responsivecols(jj),:);
                five(counter,:)=avgfluor.five(responsivecols(jj),:);
                counter=counter+1;
            end
        end
        
    end
end

figure; hold on;
subplot(151); plot(one');
subplot(152); plot(two');
subplot(153); plot(three');
subplot(154); plot(four');
subplot(155); plot(five');

subplot(151); hold on; plot(mean(one),'k', 'Linewidth',2);
subplot(152); hold on; plot(mean(two),'k', 'Linewidth',2);
subplot(153); hold on; plot(mean(three),'k', 'Linewidth',2);
subplot(154); hold on; plot(mean(four),'k', 'Linewidth',2);
subplot(155); hold on; plot(mean(five),'k', 'Linewidth',2);


shortavgfluorperiod=fluormean(avgfluor,FrameRate,0,1);

figure; hold on;
for k=1:numel(allresponsivecols)
    
    temp1=one(k,:);
    temp2=two(k,:);
    temp3=three(k,:);
    temp4=four(k,:);
    temp5=five(k,:);
    
    mean1=mean(temp1(75:100));
    mean2=mean(temp2(75:100));
    mean3=mean(temp3(75:100));
    mean4=mean(temp4(75:100));
    mean5=mean(temp5(75:100));
    
    totalfluor=sum([mean1,mean2,mean3,mean4,mean5]);
    v1=mean1/totalfluor;
    v2=mean2/totalfluor;
    v3=mean3/totalfluor;
    v4=mean4/totalfluor;
    v5=mean5/totalfluor;
    
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
    
    meanx=mean([v1x,v2x,v3x,v4x,v5x]);
    meany=mean([v1y,v2y,v3y,v4y,v5y]);
    [ang,mag]=cart2pol(meanx,meany);
    ang=round(rad2deg(ang));
    try
        plot(allresponsivecols(k),ang-90,'ko');
    catch
        disp('stop');
    end
    
    
    
end




figure; hold on;
for k=1:numel(allresponsivecols)
    
    temp1=one(k,:);
    temp2=two(k,:);
    temp3=three(k,:);
    temp4=four(k,:);
    temp5=five(k,:);
    
    mean1=mean(temp1(75:100));
    mean2=mean(temp2(75:100));
    mean3=mean(temp3(75:100));
    mean4=mean(temp4(75:100));
    mean5=mean(temp5(75:100));
    
    [maxresp,maxind]=max([mean1,mean2,mean3,mean4,mean5]);
    
    
    subplot(1,5,maxind); hold on;
    if maxind==1
        plot(one(k,:));
    elseif maxind==2
        plot(two(k,:));
    elseif maxind==3
        plot(three(k,:));
    elseif maxind==4
        plot(four(k,:));
    else
        plot(five(k,:));
    end
    
end

%plot all of the good responsive columns that are above some standard dev
%and then plot the average fluor of them vs the column number
f=figure; hold on;
f2=figure; hold on;
f3=figure('color','white', 'Units','Inches','position',[0 0 0.42 0.72],'ToolBar','none'); hold on;
goodones=[];
goodtwos=[];
goodthrees=[];
goodfours=[];
goodfives=[];

onecounter=1;
twocounter=1;
threecounter=1;
fourcounter=1;
fivecounter=1;
tvec=linspace(1,236,236)/5;
for k=1:numel(allresponsivecols)
    
    temp1=one(k,:);
    temp2=two(k,:);
    temp3=three(k,:);
    temp4=four(k,:);
    temp5=five(k,:);
    
    base1=mean(temp1(3:25));
    base2=mean(temp2(3:25));
    base3=mean(temp3(3:25));
    base4=mean(temp4(3:25));
    base5=mean(temp5(3:25));
    
    basestd1=std(temp1(3:25));
    basestd2=std(temp2(3:25));
    basestd3=std(temp3(3:25));
    basestd4=std(temp4(3:25));
    basestd5=std(temp5(3:25));
    
    meanwind1=mean(temp1(25:50));
    meanwind2=mean(temp2(25:50));
    meanwind3=mean(temp3(25:50));
    meanwind4=mean(temp4(25:50));
    meanwind5=mean(temp5(25:50));
    
    mean1=mean(temp1(75:100));
    mean2=mean(temp2(75:100));
    mean3=mean(temp3(75:100));
    mean4=mean(temp4(75:100));
    mean5=mean(temp5(75:100));
    %instead of max ask if is above some threshold, ie does it respond
    factor=2;
    if mean1>(base1+factor*basestd1)
        figure(f);
        subplot(1,5,1); hold on; plot(tvec,one(k,:),'color',[0.5 0.5 0.5]);
        goodones(onecounter,:)=one(k,:);
        onecounter=onecounter+1;
        ylim([0.9 1.5]);
        xlim([12.5 27.5]);
        figure(f2);
        subplot(1,5,1); hold on;
        %plot(allresponsivecols(k)+rand/2,mean1,'ko');
        plot(allresponsivecols(k),mean2,'k.','MarkerSize',12);
        figure(f3);
        plot([1,2],[meanwind1,mean1],'color',[0.5 0.5 0.5]);
    end
    if mean2>(base2+factor*basestd2)
        figure(f);
        subplot(1,5,2); hold on; plot(tvec,two(k,:),'color',[0.5 0.5 0.5]);
        goodtwos(twocounter,:)=two(k,:);
        twocounter=twocounter+1;
        ylim([0.9 1.5]);
        xlim([12.5 27.5]);
        figure(f2);
        subplot(1,5,2); hold on;
        %plot(allresponsivecols(k)+rand/2,mean2,'ko');
        plot(allresponsivecols(k),mean2,'k.','MarkerSize',12);
        figure(f3);
        plot([1,2],[meanwind2,mean2],'color',[0.5 0.5 0.5]);
    end
    if mean3>(base3+factor*basestd3)
        figure(f);
        subplot(1,5,3); hold on; plot(tvec,three(k,:),'color',[0.5 0.5 0.5]);
        goodthrees(threecounter,:)=three(k,:);
        threecounter=threecounter+1;
        ylim([0.9 1.5]);
        xlim([12.5 27.5]);
        figure(f2);
        subplot(1,5,3); hold on;
        %plot(allresponsivecols(k)+rand/2,mean3,'ko');
        plot(allresponsivecols(k),mean3,'k.','MarkerSize',12);
        figure(f3);
        plot([1,2],[meanwind3,mean3],'color',[0.5 0.5 0.5]);
    end
    if mean4>(base4+factor*basestd4)
        figure(f);
        subplot(1,5,4); hold on; plot(tvec,four(k,:),'color',[0.5 0.5 0.5]);
        goodfours(fourcounter,:)=four(k,:);
        fourcounter=fourcounter+1;
        ylim([0.9 1.5]);
        xlim([12.5 27.5]);
        figure(f2);
        subplot(1,5,4); hold on;
        %plot(allresponsivecols(k)+rand/2,mean4,'ko');
        plot(allresponsivecols(k),mean4,'k.','MarkerSize',12);
        figure(f3);
        plot([1,2],[meanwind4,mean4],'color',[0.5 0.5 0.5]);
    end
    if mean5>(base5+factor*basestd5)
        figure(f);
        subplot(1,5,5); hold on; plot(tvec,five(k,:),'color',[0.5 0.5 0.5]);
        goodfivess(fivecounter,:)=five(k,:);
        fivecounter=fivecounter+1;
        ylim([0.9 1.5]);
        xlim([12.5 27.5]);
        figure(f2);
        subplot(1,5,5); hold on;
        %plot(allresponsivecols(k)+rand/2,mean5,'ko');
        plot(allresponsivecols(k),mean5,'k.','MarkerSize',12);
        figure(f3);
        plot([1,2],[meanwind5,mean5],'color',[0.5 0.5 0.5]);
    end
    
end
figure(f);
yl=ylim;
subplot(151);hold on;
plot(tvec,mean(goodones),'k','Linewidth',2);
patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
subplot(152);hold on;
plot(tvec,mean(goodtwos),'k','Linewidth',2);
patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
subplot(153);hold on;
plot(tvec,mean(goodthrees),'k','Linewidth',2);
patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
subplot(154);hold on;
plot(tvec,mean(goodfours),'k','Linewidth',2);
patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
subplot(155);hold on;
plot(tvec,mean(goodfives),'k','Linewidth',2);
patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
figure(f3);
xlim([0 3]);
allgood=[goodones;goodtwos;goodthrees;goodfours;goodfives];
plot([1,2],[nanmean(nanmean(allgood(:,25:50))),nanmean(nanmean(allgood(:,75:100)))],'k','linewidth',2);
[h,p]=ttest((nanmean(allgood(:,25:50))),(nanmean(allgood(:,75:100))))

xticks([1,2]);
xticklabels({'wind','odour'});
ylabel('DF/f');
set(gca, 'FontName', 'Helvetica')
set(findall(gcf,'-property','FontSize'),'FontSize',6)
figure(f2)
for k=1:5
    subplot(1,5,k)
    xlim([1 10]);
    ylim([1 1.3]);
    xticks([2 3 4 5 6 7 8 9]);
    xticklabels([1 2 3 4 5 6 7 8]);
    xlabel('column number');
    ylabel('DF/f');
end
set(gca, 'FontName', 'Helvetica')
set(findall(gcf,'-property','FontSize'),'FontSize',14)




%% overlay all responsive columns?


figure; hold on; plot(tvec,allgood','color',[0.5 0.5 0.5]);
hold on; plot(tvec,nanmean(allgood),'k','linewidth',2);
ylim([0.85 1.45]);
ylabel('DF/F');







%% ALTERNATIVELY -> Look at ALL columns that go above baseline
counter=1;
allcols=[];

oneall=[];
twoall=[];
threeall=[];
fourall=[];
fiveall=[];
onecounter=1;
twocounter=1;
threecounter=1;
fourcounter=1;
fivecounter=1;
for k=1:numel(filelist)
    dataname=filelist(k).name;
    %cd(headpath);
    
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);
        
        for jj=2:9
            oneall(counter,:)=avgfluor.one(jj,:);
            twoall(counter,:)=avgfluor.two(jj,:);
            threeall(counter,:)=avgfluor.three(jj,:);
            fourall(counter,:)=avgfluor.four(jj,:);
            fiveall(counter,:)=avgfluor.five(jj,:);
            counter=counter+1;
        end
        
    end
    
end




% now take above the std for any time -> 
fugh=figure;hold on;
respcounter=1;
fullgood=[];
tvec=linspace(1,236,236)/5;
for k=1:size(oneall,1)
    
    temp1=oneall(k,:);
    temp2=twoall(k,:);
    temp3=threeall(k,:);
    temp4=fourall(k,:);
    temp5=fiveall(k,:);
    
    base1=mean(temp1(3:25));
    base2=mean(temp2(3:25));
    base3=mean(temp3(3:25));
    base4=mean(temp4(3:25));
    base5=mean(temp5(3:25));
    
    basestd1=std(temp1(3:25));
    basestd2=std(temp2(3:25));
    basestd3=std(temp3(3:25));
    basestd4=std(temp4(3:25));
    basestd5=std(temp5(3:25));
    
    meanwind1=mean(temp1(25:50));
    meanwind2=mean(temp2(25:50));
    meanwind3=mean(temp3(25:50));
    meanwind4=mean(temp4(25:50));
    meanwind5=mean(temp5(25:50));
    
    mean1=mean(temp1(75:100));
    mean2=mean(temp2(75:100));
    mean3=mean(temp3(75:100));
    mean4=mean(temp4(75:100));
    mean5=mean(temp5(75:100));
    
    meanwindoff1=mean(temp1(125:150));
    meanwindoff2=mean(temp2(125:150));
    meanwindoff3=mean(temp3(125:150));
    meanwindoff4=mean(temp4(125:150));
    meanwindoff5=mean(temp5(125:150));
    
    meanoff1=mean(temp1(175:200));
    meanoff2=mean(temp2(175:200));
    meanoff3=mean(temp3(175:200));
    meanoff4=mean(temp4(175:200));
    meanoff5=mean(temp5(175:200));
    
    
    
    %instead of max ask if is above some threshold, ie does it respond
    factor=2;
    if (mean1>(base1+factor*basestd1)||meanwind1>(base1+factor*basestd1)||meanwindoff1>(base1+factor*basestd1)||meanoff1>(base1+factor*basestd1))
        figure(fugh);
        subplot(1,5,1);
        hold on; plot(downsample(tvec,2),downsample(oneall(k,:),2),'color',[0.5 0.5 0.5]);
        fullgood(respcounter,:)=oneall(k,:);
        respcounter=respcounter+1;
        goodones(onecounter,:)=oneall(k,:);
        
        onecounter=onecounter+1;
        ylim([0.9 1.5]);
        
        %xlim([12.5 27.5]);
        %figure(f2);
        %subplot(1,5,1); hold on;
        %plot(allresponsivecols(k)+rand/2,mean1,'ko');
        %plot(allresponsivecols(k),mean2,'k.','MarkerSize',12);
        %figure(f3);
        %plot([1,2],[meanwind1,mean1],'color',[0.5 0.5 0.5]);
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
        %xlim([12.5 27.5]);
        %figure(f2);
        %subplot(1,5,2); hold on;
        %plot(allresponsivecols(k)+rand/2,mean2,'ko');
        %plot(allresponsivecols(k),mean2,'k.','MarkerSize',12);
        %figure(f3);
        %plot([1,2],[meanwind2,mean2],'color',[0.5 0.5 0.5]);
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
        %xlim([12.5 27.5]);
        %figure(f2);
        %subplot(1,5,3); hold on;
        %plot(allresponsivecols(k)+rand/2,mean3,'ko');
        %plot(allresponsivecols(k),mean3,'k.','MarkerSize',12);
        %figure(f3);
        %plot([1,2],[meanwind3,mean3],'color',[0.5 0.5 0.5]);
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
        %xlim([12.5 27.5]);
        %figure(f2);
        %subplot(1,5,4); hold on;
        %plot(allresponsivecols(k)+rand/2,mean4,'ko');
        %plot(allresponsivecols(k),mean4,'k.','MarkerSize',12);
        %figure(f3);
        %plot([1,2],[meanwind4,mean4],'color',[0.5 0.5 0.5]);
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
        %xlim([12.5 27.5]);
        %figure(f2);
        %subplot(1,5,5); hold on;
        %plot(allresponsivecols(k)+rand/2,mean5,'ko');
        %plot(allresponsivecols(k),mean5,'k.','MarkerSize',12);
        %figure(f3);
        %plot([1,2],[meanwind5,mean5],'color',[0.5 0.5 0.5]);
    end
    
end

%for subplots

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

figure; hold on;
shadedErrorBar(tvec,nanmean(fullgood),nanstd(fullgood));
patch([5 5 15 15],[0.95 1.2 1.2 0.95],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[0.95 1.2 1.2 0.95],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[0.95 1.2 1.2 0.95],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
ylim([0.95 1.2]);
xlim([2.5 30]);

figure; hold on;
allcolbase=fullgood(:,25:50);
meanallcolbase=nanmean(allcolbase,2);
allcolodour=fullgood(:,75:100);
meanallcolodour=nanmean(allcolodour,2);

plot([1*ones(size(meanallcolbase)),2*ones(size(meanallcolbase))]',[meanallcolbase,meanallcolodour]','color',[0.5 0.5 0.5]);
plot([1,2],[nanmean(meanallcolbase),nanmean(meanallcolodour)],'k','linewidth',2);
[h,p]=ttest(meanallcolbase,meanallcolodour)



%% can we do for each fly just plot the maximally odour responsive column?
%max direction for max column for each fly - should have 17?


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
    %cd(headpath);
    
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



%% ok take the max direction for each fly. Then once you have it normalize to max/min
%then plot each column relative to that
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
        
        onemean=nanmean(avgfluor.one(cols,75:100),2);
        twomean=nanmean(avgfluor.two(cols,75:100),2);
        threemean=nanmean(avgfluor.three(cols,75:100),2);
        fourmean=nanmean(avgfluor.four(cols,75:100),2);
        fivemean=nanmean(avgfluor.five(cols,75:100),2);
        allmeans=[onemean,twomean,threemean,fourmean,fivemean];
        
        [overallmax,overallmaxind]=max([max(onemean),max(twomean),max(threemean),max(fourmean),max(fivemean)]);
        %normalize
        %find the max direction
        flymax=allmeans(:,overallmaxind);
        %subtract the min
        flymax=flymax-min(flymax);
        flymax=flymax/max(flymax);
        
        %circshift flymax so the peak is at 4
        
        [~,maxi]=max(flymax);
        
        flymax=circshift(flymax,4-maxi);
        allmaxes(counter,:)=flymax;
        
        
        
        hold on; plot(cols-1,flymax);
        w = waitforbuttonpress
        
        
        %find the column with the max response
        
    end
end
plot(cols-1,mean(allmaxes),'k','linewidth',2);


figure; hold on; imagesc(allmaxes)
colormap(gray)
plot(cols-1,17*mean(allmaxes),'g','linewidth',2);




%% test if a fly has any above a certain standard dev.

counter=1;
allresp=[];
allrespcount=1;
allcols=[];

oneall=[];
twoall=[];
threeall=[];
fourall=[];
fiveall=[];
onecounter=1;
twocounter=1;
threecounter=1;
fourcounter=1;
fivecounter=1;
for k=1:numel(filelist)
    dataname=filelist(k).name;
    %cd(headpath);
    
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);
        
        for jj=2:9
            oneall(counter,:)=avgfluor.one(jj,:);
            twoall(counter,:)=avgfluor.two(jj,:);
            threeall(counter,:)=avgfluor.three(jj,:);
            fourall(counter,:)=avgfluor.four(jj,:);
            fiveall(counter,:)=avgfluor.five(jj,:);
            counter=counter+1;
        end
        counter=1;
        for jj=1:size(oneall,1)
            temp1=oneall(jj,:);
            temp2=twoall(jj,:);
            temp3=threeall(jj,:);
            temp4=fourall(jj,:);
            temp5=fiveall(jj,:);
            
            
            base1=mean(temp1(3:25));
            base2=mean(temp2(3:25));
            base3=mean(temp3(3:25));
            base4=mean(temp4(3:25));
            base5=mean(temp5(3:25));
            
            basestd1=std(temp1(3:25));
            basestd2=std(temp2(3:25));
            basestd3=std(temp3(3:25));
            basestd4=std(temp4(3:25));
            basestd5=std(temp5(3:25));
            
            mean1=mean(temp1(75:100));
            mean2=mean(temp2(75:100));
            mean3=mean(temp3(75:100));
            mean4=mean(temp4(75:100));
            mean5=mean(temp5(75:100));
            
            meanwind1=mean(temp1(25:50));
            meanwind2=mean(temp2(25:50));
            meanwind3=mean(temp3(25:50));
            meanwind4=mean(temp4(25:50));
            meanwind5=mean(temp5(25:50));
            
            meanwindoff1=mean(temp1(125:150));
            meanwindoff2=mean(temp2(125:150));
            meanwindoff3=mean(temp3(125:150));
            meanwindoff4=mean(temp4(125:150));
            meanwindoff5=mean(temp5(125:150));
            
            meanoff1=mean(temp1(175:200));
            meanoff2=mean(temp2(175:200));
            meanoff3=mean(temp3(175:200));
            meanoff4=mean(temp4(175:200));
            meanoff5=mean(temp5(175:200));
            
            factor=2;
            if (mean1>(base1+factor*basestd1)||meanwind1>(base1+factor*basestd1)||meanwindoff1>(base1+factor*basestd1)||meanoff1>(base1+factor*basestd1))
                disp(dataname);
                %allresp(end+1)=dataname;
                
            end
            if (mean2>(base2+factor*basestd2)||meanwind2>(base2+factor*basestd2)||meanwindoff2>(base2+factor*basestd2)||meanoff2>(base2+factor*basestd2))
                disp(dataname);
                %allresp(end+1)=dataname;
            end
            if (mean3>(base3+factor*basestd3)||meanwind3>(base3+factor*basestd3)||meanwindoff3>(base3+factor*basestd3)||meanoff5>(base3+factor*basestd3))
                disp(dataname);
                %allresp(end+1)=dataname;
            end
            if (mean4>(base4+factor*basestd4)||meanwind4>(base4+factor*basestd4)||meanwindoff4>(base4+factor*basestd4)||meanoff4>(base4+factor*basestd4))
                disp(dataname);
                %allresp(end+1)=dataname;
            end
            if (mean5>(base5+factor*basestd5)||meanwind5>(base5+factor*basestd5)||meanwindoff5>(base5+factor*basestd5)||meanoff5>(base5+factor*basestd5))
                disp(dataname);
                %allresp(end+1)=dataname;
            end
        end
        
        
        
        
        
    end
    
end
