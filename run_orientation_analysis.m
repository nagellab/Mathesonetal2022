%% Run orientation analysis for SPARC (15%) VT062617-GAL4
close all
load('sparc2_vt062617_15perc_all_filt.mat')
behavior_res = sparc2_vt062617_15perc_all_filt.resblankalwayson10s;
[vector_strengths_sparc2] = orientation_hist(behavior_res);

%% Run orientation analysis for SPARC (15%) empty-GAL4
close all
load('sparc2_empty_filt.mat')
behavior_res = sparc2_empty_filt.resblankalwayson10s;
[vector_strengths_sparc2_empty] = orientation_hist(behavior_res);

%% Compare orientation preferences between VT062617 sparc and empty sparc
close all
data{1} = vector_strengths_sparc2_empty;
data{2} = vector_strengths_sparc2;
groupnames = {'Sparc Empty GAL4', 'Sparc VT062617'};

numgroups = length(data);

figure; hold on
for k = 1:numgroups
    plot(k+(0.5)*(rand(numel(data{k}),1)-0.5), data{k},'.','color', [0.7 0.7 0.7],'Linewidth',0.5,'MarkerSize', 24);
    errorbar(k,nanmean(data{k}),nanstd(data{k}),'o','color','k','capsize',0,'MarkerFaceColor','k','Linewidth',2,'MarkerSize', 14);
end

xlim([0 numgroups+1]);
xticks(linspace(1,numgroups,numgroups))
xticklabels(groupnames)
ylabel('Preferred orientation strength', 'fontsize', 14)
ylim([1,5])

[h,p,ci,stats] = ttest2(vector_strengths_sparc2_empty, vector_strengths_sparc2)
