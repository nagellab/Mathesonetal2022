function [f,siglinesup,siglinesdown,magnitudes]=compareplot_tnt(data,parameter,genotypeinds,siglinesup,siglinesdown,magnitudes,mode)
%function f=compareplot(data,parameter,genotypeinds)
%insert parameter data for all parameters (data)
%the parameter of interest (ie curvature)
%the indices of the genotypes you wish to include (either assembled or
%based on anatomy)
%use mode to decide on the figure aspect ratio
%scattermore= @(x,y,c)   scatter(y*ones(length(x),1),x,40,c,'filled','linewidth',1.5);

genolist=fieldnames(data.(parameter));
genolist=genolist(genotypeinds); %reduce to the ones that you care about

%get the labels for the bottom (remove first char 'd' which was added so
%structfield did not start with a number
labels=cellfun(@(x) x(2:end), genolist,'un',0);
%get the name of the baseline parameter
[base, units, ax]=findbase(parameter);

%f=figure;%('visible','off');
%coreceptors 
%f=figure('color','white', 'Units','Inches','position',[0 0 1.95 1.1],'ToolBar','none');
%MB and LH

f=figure('color','white', 'Units','Inches','position',[0 0 1.62 1.0],'ToolBar','none');
hold on;
%Shoulder order them by magnitude of change
%colour mean line for significance
diffs=[];
for k=1:numel(genotypeinds)
    %get the differences to rank order
    %subtract the baseline from the response. Biggest difference from
    %baseline will be most positive.
    diff=nanmean(data.(parameter).(genolist{k}))-nanmean(data.(base).(genolist{k}));
    diffs(k)=diff;
    magnitudes.(parameter).(genolist{k})=diff;
end

%[~,sortedinds]=sort(diffs);
%labelsort=labels(sortedinds);


ctrldiff=data.(parameter).(genolist{1})-data.(base).(genolist{1});



for k=1:numel(genotypeinds)
    
    plot(k+(0.5)*(rand(numel(data.(parameter).(genolist{k})),1)-0.5),data.(parameter).(genolist{k})-data.(base).(genolist{k}),'.','color', [0.7 0.7 0.7],'Linewidth',0.75,'MarkerSize', 4);
    try
        p=ranksum(data.(parameter).(genolist{k})-data.(base).(genolist{k}),ctrldiff);
        disp(strcat(genolist{k},strcat(parameter, num2str(p))));
        
        if (p<0.05/(numel(genotypeinds)-1) && nanmean(data.(parameter).(genolist{k})-data.(base).(genolist{k}))<nanmean(ctrldiff))
            %significant decrease
            errorbar(k,nanmean(data.(parameter).(genolist{k})-nanmean(data.(base).(genolist{k}))),nanstd(data.(parameter).(genolist{k})-(data.(base).(genolist{k}))),'o','color',[159/255 0 121/255],'capsize',0,'Linewidth',0.75,'MarkerSize', 1);
            
            %plot(k,nanmean(data.(parameter).(genolist{k}))-nanmean(data.(base).(genolist{k})),'.','color',[159/255 0 121/255],'Linewidth',2,'MarkerSize', 30);
            if ~isfield(siglinesdown,parameter)
                siglinesdown.(parameter)={genolist{k}};
            else
                siglinesdown.(parameter)(end+1)={genolist{k}};
            end
            %how to draw a patch without having it change the limit
            
        elseif (p<0.05/(numel(genotypeinds)-1) && nanmean(data.(parameter).(genolist{k})-data.(base).(genolist{k}))>nanmean(ctrldiff))
            %significant increase
            
            %plot(k,nanmean(data.(parameter).(genolist{k}))-nanmean(data.(base).(genolist{k})),'.','color',[0 170/255 100/255],'Linewidth',2,'MarkerSize', 30);
            errorbar(k,nanmean(data.(parameter).(genolist{k})-nanmean(data.(base).(genolist{k}))),nanstd(data.(parameter).(genolist{k})-(data.(base).(genolist{k}))),'o','color',[0 170/255 100/255],'capsize',0,'Linewidth',0.75,'MarkerSize', 1);
            
            if ~isfield(siglinesup,parameter)
                siglinesup.(parameter)={genolist{k}};
            else
                siglinesup.(parameter)(end+1)={genolist{k}};
            end
        else
            errorbar(k,nanmean(data.(parameter).(genolist{k})-nanmean(data.(base).(genolist{k}))),nanstd(data.(parameter).(genolist{k})-(data.(base).(genolist{k}))),'o','color','k','capsize',0,'Linewidth',0.75,'MarkerSize', 1);
            
            %plot(k, nanmean(data.(parameter).(genolist{k}))-nanmean(data.(base).(genolist{k})),'.','color','k','Linewidth',2,'MarkerSize', 30);
        end
        
    catch
        disp(strcat('fuck ',genolist{k}));
    end
end
xlim([0 numel(genotypeinds)+1]);
xticks(linspace(1,numel(genotypeinds),numel(genotypeinds)))
xticklabels(labels)
xtickangle(90)
set(findall(gca, '-property', 'FontSize'), 'FontSize', 6)
%give some extra space so that they always fit?
axfig=gca;
if strcmp(mode,'region')
    %set(gcf,'Position',[100 100 ((300*numel(genotypeinds))) 600])
    %set(axfig,'Units','pixels','Position',[120 140 ((120*numel(genotypeinds))) 225]);
elseif strcmp(mode,'driver')
    %set(gcf,'Position',[100 100 ((300*numel(genotypeinds))) 600])
    %set(axfig,'Units','pixels','Position',[120 140 ((120*numel(genotypeinds))) 225]);
end


y=ylabel([units]); %ax ' ' units
%could make this better and use ax + whether or not if can find on/off
title(parameter,'FontWeight','normal');
set(gca, 'FontName', 'Helvetica')
set(gca, 'TickLength',[0.005  0.1]);
%axfig.LabelFontSizeMultiplier=1.4;
%axfig.TitleFontSizeMultiplier=2.0;

end


