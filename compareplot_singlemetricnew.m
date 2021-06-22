function [f,siglinesup,siglinesdown,magnitudes,pvals,sortorder]=compareplot_singlemetricnew(data,parameter,genotypeinds,siglinesup,siglinesdown,magnitudes,pvals,mode,colour,sortorder)
%function f=compareplot(data,parameter,genotypeinds)
%insert parameter data for all parameters (data)
%the parameter of interest (ie curvature)
%the indices of the genotypes you wish to include (either assembled or
%based on anatomy)
%use mode to decide on the figure aspect ratio
%scattermore= @(x,y,c)   scatter(y*ones(length(x),1),x,40,c,'filled','linewidth',1.5);


genolist=fieldnames(data.(parameter));
genolist=genolist(genotypeinds); %reduce to the ones that you care about (indices are not right?) 

%get the labels for the bottom (remove first char 'd' which was added so
%structfield did not start with a number
labels=cellfun(@(x) x(2:end), genolist,'un',0);
%get the name of the baseline parameter
[base, units, ax]=findbase(parameter);
%for ORs 
%f=figure('color','white', 'Units','Inches','position',[0 0 2.4 1.0],'ToolBar','none');
%for coreceptors
%f=figure('color','white', 'Units','Inches','position',[0 0 0.4 1.0],'ToolBar','none');
%for basics
%f=figure('color','white', 'Units','Inches','position',[0 0 1.62 1.15],'ToolBar','none');
%for main MBLH
f=figure('color','white', 'Units','Inches','position',[0 0 1.62 1.0],'ToolBar','none');


%('visible','off');
hold on;
%Shoulder order them by magnitude of change
%colour mean line for significance
diffs=[];
for k=1:numel(genotypeinds)
    %get the differences to rank order -> change this so they stay in the
    %same order??
    %subtract the baseline from the response. Biggest difference from
    %baseline will be most positive.
    diff=nanmean(data.(parameter).(genolist{k}))-nanmean(data.(base).(genolist{k}));
    diffs(k)=diff;
    magnitudes.(parameter).(genolist{k})=diff;
end


[~,sortedinds]=sort(diffs);
labelsort=labels(sortedinds);






for k=1:numel(sortedinds)
    %get the real index but plot them in the sorted order.
    ind=sortedinds(k);
    %plot it as the difference between the values rather than the sibe by
    %side
    %plots the grey dots
    plot(k+(0.5)*(rand(numel(data.(parameter).(genolist{ind})),1)-0.5),data.(parameter).(genolist{ind})-data.(base).(genolist{ind}),'.','color', [0.7 0.7 0.7],'Linewidth',0.5,'MarkerSize', 4);
    try
        p=signrank(data.(base).(genolist{ind}),data.(parameter).(genolist{ind}));
        pvals.(parameter).(genolist{ind})=p;%should be ind not k for the pvals to match the sorted.
        disp(strcat('parameter: ', parameter));
        disp('/n');
        disp(p);
        disp(pvals.(parameter).(genolist{ind}));
        
        if (p<0.05/numel(genotypeinds) && nanmean(data.(base).(genolist{ind}))>nanmean(data.(parameter).(genolist{ind})))
           
            %plot(k,nanmean(data.(parameter).(genolist{ind}))-nanmean(data.(base).(genolist{ind})),'.','color',[159/255 0 121/255],'Linewidth',2,'MarkerSize', 20);
            errorbar(k,nanmean(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),nanstd(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),'o','color',colour,'capsize',0,'Linewidth',0.75,'MarkerSize', 1);
            if ~isfield(siglinesdown,parameter)
                siglinesdown.(parameter)={genolist{ind}};
            else
                siglinesdown.(parameter)(end+1)={genolist{ind}};
            end
            
            
        elseif (p<0.05/numel(genotypeinds) && nanmean(data.(base).(genolist{ind}))<nanmean(data.(parameter).(genolist{ind})))
            %significant increase
            add=0;
            if (strcmp(parameter,'upwind') && nanmean(data.(parameter).(genolist{ind}))>1)
                errorbar(k,nanmean(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),nanstd(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),'o','color',colour,'MarkerFaceColor',colour,'capsize',0,'Linewidth',0.75,'MarkerSize', 1);
                add=1;
            elseif(strcmp(parameter,'curvatureoff') && nanmean(data.('angvoff').(genolist{ind}))>50 && nanmean(data.('groundspeedoff').(genolist{ind}))>4)
                errorbar(k,nanmean(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),nanstd(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),'o','color',colour,'capsize',0,'MarkerFaceColor',colour,'Linewidth',0.75,'MarkerSize', 1);
                add=1;
            elseif(strcmp(parameter,'curvature') && nanmean(data.('angv').(genolist{ind}))>50 && nanmean(data.('groundspeed').(genolist{ind}))>4)
                errorbar(k,nanmean(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),nanstd(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),'o','color',colour,'capsize',0,'MarkerFaceColor',colour,'Linewidth',0.75,'MarkerSize', 1);
                add=1;
            elseif (strcmp(parameter,'pmove') || strcmp(parameter,'groundspeed') || strcmp(parameter,'groundspeedoff') || strcmp(parameter,'upwindoff') || strcmp(parameter,'angv') || strcmp(parameter,'angvon') || strcmp(parameter,'angvoff') || strcmp(parameter,'curvatureon') || strcmp(parameter,'placepref') )
                errorbar(k,nanmean(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),nanstd(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),'o','color',colour,'capsize',0,'MarkerFaceColor',colour,'Linewidth',0.75,'MarkerSize', 1);
                add=1;
            else 
                errorbar(k,nanmean(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),nanstd(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),'o','color',colour,'MarkerFaceColor',colour,'capsize',0,'Linewidth',0.75,'MarkerSize', 1);
            end
            if add
                if ~isfield(siglinesup,parameter)
                    siglinesup.(parameter)={genolist{ind}};
                else
                    siglinesup.(parameter)(end+1)={genolist{ind}};
                end
            end
            
        else
            errorbar(k,nanmean(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),nanstd(data.(parameter).(genolist{ind})-(data.(base).(genolist{ind}))),'o','color',colour,'MarkerFaceColor',colour,'capsize',0,'Linewidth',0.75,'MarkerSize', 2);
        end
    catch
        disp(strcat('error in compareplot_singlemetricnew ',genolist{ind}));
    end
    
end
xlim([0 numel(genotypeinds)+1]);
xticks(linspace(1,numel(genotypeinds),numel(genotypeinds)))
xticklabels(labelsort)
xtickangle(90)
set(findall(gca, '-property', 'FontSize'), 'FontSize', 6 )
%give some extra space so that they always fit?
axfig=gca;
if strcmp(mode,'region')
    %set(gcf,'Position',[100 100 ((300*numel(genotypeinds))) 400])
    %set(axfig,'Units','pixels','Position',[200 200 ((25*numel(genotypeinds))) 150]);
elseif strcmp(mode,'driver')
    %set(gcf,'Position',[100 100 ((300*numel(genotypeinds))) 600])
    %set(axfig,'Units','pixels','Position',[120 140 ((120*numel(genotypeinds))) 225]);
end
%axfig.LabelFontSizeMultiplier=1.2;
%axfig.TitleFontSizeMultiplier=1.2;

y=ylabel([ax ' ' units]);
%could make this better and use ax + whether or not if can find on/off
title(parameter,'FontWeight','normal');
set(gca, 'FontName', 'Helvetica')
set(gca, 'TickLength',[0.005  0.1]);

end


