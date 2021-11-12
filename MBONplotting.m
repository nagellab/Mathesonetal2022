function MBONplotting(physdata,filtphysdata,savefigs)

samprate=10000;
fncontra=fieldnames(physdata.contra);
fnipsi=fieldnames(physdata.ipsi);

avgfilt={};

contrabases=[];
ipsibases=[];
contrass=[];
ipsiss=[];
contraoff=[];
ipsioff=[];
contrameans=[];
ipsimeans=[];
baselinevoltcontra=[];
pulserespcontra=[];
baselinevoltipsi=[];
pulserespipsi=[];
for k=1:numel(fncontra)
    meantrace=mean((filtphysdata.contra.(fncontra{k})));
    contrabases(k)=mean(meantrace(1.5*samprate:3.5*samprate));
    contrass(k)=mean(meantrace(8*samprate:12*samprate));
    contraoff(k)=mean(meantrace(15*samprate:17*samprate));
    contrameans(k,:)=meantrace;
    baselinevoltcontra(k)=mean(meantrace(1:950));
    pulserespcontra(k)=mean(meantrace(1500:5000));
end
for k=1:numel(fnipsi)
    meantrace=mean((filtphysdata.ipsi.(fnipsi{k})));
    ipsibases(k)=mean(meantrace(1.5*samprate:3.5*samprate));
    ipsiss(k)=mean(meantrace(8*samprate:12*samprate));%ss stands for steady state 
    ipsioff(k)=mean(meantrace(15*samprate:17*samprate));
    ipsimeans(k,:)=meantrace;
    baselinevoltipsi(k)=mean(meantrace(1:950));
    pulserespipsi(k)=mean(meantrace(1500:5000));
end


%plot the average traces for contra
f1=figure('color','white','Units','Inches','position',[0 0 0.9 1.55],'ToolBar','none');
hold on;
patch([4*samprate 4*samprate 14*samprate 14*samprate],[-600 600 600 -600],[180/255 180/255 180/255],'EdgeColor',[120/255 120/255 120/255],'FaceAlpha',0.5,'EdgeAlpha',0.5)
for k=1:numel(fncontra)
    plot(mean(filtphysdata.contra.(fncontra{k}))-contrabases(k),'color',[0.5 0.5 0.5],'Linewidth',0.5);
end
plot(mean(contrameans)-mean(contrabases),'color','k');
ylim([-3 13]);
xlim([1*samprate 18*samprate]);
%plot([1.5*samprate 1.5*samprate],[-10 25]);
%plot([3.5*samprate 3.5*samprate],[-10 25]);
ylabel('Voltage (mV)');
set(gca,'xtick',[])
xticks([]);
xticklabels([]);
title('contra');

set(findall(gca, '-property', 'FontSize'), 'FontSize', 6)
%title(gca,'FontWeight','normal','FontSize',22);
set(gca, 'FontName', 'Helvetica');
%plot the average traces for ipsi 
f2=figure('color','white','Units','Inches','position',[0 0 0.9 1.55],'ToolBar','none'); hold on;
patch([4*samprate 4*samprate 14*samprate 14*samprate],[-600 600 600 -600],[180/255 180/255 180/255],'EdgeColor',[120/255 120/255 120/255],'FaceAlpha',0.5,'EdgeAlpha',0.5)
for k=1:numel(fnipsi)
    plot(mean(filtphysdata.ipsi.(fnipsi{k}))-ipsibases(k),'color',[0.5 0.5 0.5],'Linewidth',0.5);
end
plot(mean(ipsimeans)-mean(ipsibases),'color','k');
ylim([-3 13]);
xlim([1*samprate 18*samprate]);
%plot([1.5*samprate 1.5*samprate],[-10 25]);
%plot([3.5*samprate 3.5*samprate],[-10 25]);
ylabel('Voltage (mV)');
set(gca,'xtick',[])
xticks([]);
xticklabels([]);
title('ipsi');

set(findall(gca, '-property', 'FontSize'), 'FontSize', 6)
%title(gca,'FontWeight','normal','FontSize',22);
set(gca, 'FontName', 'Helvetica');

%set the axes the same at some point;

%make paired plot of the data for each

%get the bases and the steady state response
%make this 2 separate figures
f3=figure('color','white','Units','Inches','position',[0 0 0.81 0.92],'ToolBar','none'); hold on;

for k=1:numel(contrabases)
    plot([1 2],[contrabases(k),contrass(k)],'color',[0.5 0.5 0.5]);
    plot([1 2],[mean(contrabases),mean(contrass)],'color','k','Linewidth',1.5);
end
xlim([0 3]);
xticks([1 2]);
xticklabels({'base','odour'});
ylabel('Voltage (mV)');

set(findall(gca, '-property', 'FontSize'), 'FontSize', 6)
%title(gca,'FontWeight','normal','FontSize',22);
set(gca, 'FontName', 'Helvetica');
f4=figure('color','white','Units','Inches','position',[0 0 0.81 0.92],'ToolBar','none'); hold on;
for k=1:numel(ipsibases)
    plot([1 2],[ipsibases(k),ipsiss(k)],'color',[0.5 0.5 0.5]);
    plot([1 2],[mean(ipsibases),mean(ipsiss)],'color','k','Linewidth',1.5);
    
end
xlim([0 3]);
xticks([1 2]);
xticklabels({'base','odour'});
ylabel('Voltage (mV)');

set(findall(gca, '-property', 'FontSize'), 'FontSize', 6)
%title(gca,'FontWeight','normal','FontSize',22);
set(gca, 'FontName', 'Helvetica');

if savefigs
    savefig(f1,'contravolt');
    print(f1,'contravolt','-depsc','-painters');
    savefig(f2,'ipsivolt');
    print(f2,'ipsivolt','-depsc','-painters');
    savefig(f3,'basestim');
    print(f3,'basestim','-depsc','-painters');
    savefig(f4,'voltdiff');
    print(f4,'voltdiff','-depsc','-painters');
end

[h,pipsi]=ttest(ipsibases,ipsiss)
[h,pcontra]=ttest(contrabases,contrass)
[h,ppaired]=ttest2(contrass-contrabases,ipsiss-ipsibases)




end