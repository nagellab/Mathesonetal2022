
function [physdata,filtphysdata] = MBONphysanalysis(savefigs)

cd ../../../../Volumes/'Samsung_T5'/'Electrophysiology data'/'MBONDAN raw data'
physatlasloc='/Volumes/Samsung_T5/Electrophysiology/MBON.xlsx';

atlas=readtable(physatlasloc);
atlas=rmmissing(atlas);
%atlas=table2struct(atlas);
atlas.celltype=categorical(atlas.celltype);
atlas.side=categorical(atlas.side);
mboninds=(atlas.celltype=='MBON');
%mboninds=(atlas.celltype=='side');
atlas=atlas(mboninds,:);%get rid of the DANs




%get the MBONs
%sort into contra and ipsi
%load the data from the date and exp num
%from the data figure out which trials were 10s of acv
%stitch those together into a struct
%MBON.[contra/ipsi].[date_exp].trials
%go through and find the avg VM increase for these
%plot average trace? or some example traces
%compare ipsi and contra
%at some point be able to pull out the spike rate

physdata={};
filtphysdata={};
samprate=10000;
[b, a] = butter(2,2.5/(10000/2));
for k=1:size(atlas,1)
    try
        
        datedir=atlas.expdate(k);
    catch
        disp('error with mbon phys date');
    end
    datedir=datedir{:};
    datedir=datedir(2:end-1);%remove quotes
    nodashdate=datedir;
    nodashdate(regexp(datedir,'[-]'))=[];
    cd(datedir);
    expnum=atlas.expnum(k);
    
    %load the master set of data - the WC waveforms
    load(['WCwaveform_',datedir,'_E',num2str(expnum)]);
    
    %gets the directory ones
    %find the data where it's 10s and ACV
    %load those indices into this hecking master matrix
    
    %data has entered the workspace
    
    
    
    %this is annoying have to get like it into a matrix I can work with.
    %GAH.tomorrow
    odours={data.odorname};
    stimlengths={data.stimname};
    acvinds=find(strcmp(odours,'acv'));
    tensecinds=find(strcmp(stimlengths,'10spulse'));
    tensecacvinds=intersect(acvinds,tensecinds);
    
    
    currexpdata=[];
    
    
    for j=1:numel(tensecacvinds)
        load(['Raw_WCwaveform_', datedir, '_E', num2str(expnum), '_', num2str(tensecacvinds(j))]);
        currexpdata(j,:)=voltage;
    end
    
    if atlas.side(k)=='C' %if it's contra
        physdata.contra.(['d',nodashdate, '_E', num2str(expnum)])=currexpdata;
        
        for jj=1:size(currexpdata,1)
            currfilt(jj,:)=filtfilt(b,a,currexpdata(jj,:));
        end
        
        filtphysdata.contra.(['d',nodashdate, '_E', num2str(expnum)])=currfilt;
        
        
    else%has to be ipsi
        physdata.ipsi.(['d',nodashdate, '_E', num2str(expnum)])=currexpdata;
        for jj=1:size(currexpdata,1)
            currfilt(jj,:)=filtfilt(b,a,currexpdata(jj,:));
        end
        filtphysdata.ipsi.(['d',nodashdate, '_E', num2str(expnum)])=currfilt;
    end
    cd('..');
end


%ok we got the data together -> now we have to average it or take the base
%and compare

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
