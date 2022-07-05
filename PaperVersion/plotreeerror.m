function plotreeerror(err,shufferr)

%have to set some colours
genotypes=fieldnames(err);
%reordergenotypes 

%with PFNa
genotypes=genotypes([12,10,7,11,1,8,9,2,6,3,5,4]); 
colours={[0 0 0],[0 0 0],[0 0 0],[0 0 0],[54/255, 75/255, 154/255],[74/255,123/255,183/255],[110/255,166/255,205/255],[152/255,202/255,225/255],[253/255,179/255,102/255],[246/255,126/255,75/255],[221/255,61/255,45/255],[165/255,0,38/255]};
colours=colours([1,2,3,4,12,11,10,9,8,7,6,5]);
%without PFNa
% genotypes=genotypes([7,1,8,9,2,6,3,5,4]); 
% colours={[0 0 0],[54/255, 75/255, 154/255],[74/255,123/255,183/255],[110/255,166/255,205/255],[152/255,202/255,225/255],[253/255,179/255,102/255],[246/255,126/255,75/255],[221/255,61/255,45/255],[165/255,0,38/255]};
% colours=colours([1,9,8,7,6,5,4,3,2]);

%colours={[165/255,0,38/255],[253/255,179/255,102/255],[74/255,123/255,183/255], };
% figure; hold on;
% for k=1:numel(genotypes)
%     genoerror=err.(genotypes{k});
%     plot([1,2,3],genoerror,'o','Color',colours{k})
% end
% 
% xlim([0 4]);
% xticks([1,2,3]);
% xticklabels({'Wind','Odour','Windoff'});
% ylabel('classification error');
% 
% plot([1,3],[0.1636,0.1636],'k');%error from PFNa firing
% ylim([0 1]);

figure; hold on; 

subplot(311); hold on;
for k=1:numel(genotypes)
    genoerror=err.(genotypes{k})(:,1);
    errorbar(k,1-mean(genoerror),std(genoerror)/sqrt(numel(genoerror)),'o','Color',colours{k},'Linewidth',2);
end
xlim([0 13]);
ylim([0 1]);
xticks([1:1:12]);
xticklabels(genotypes);
ylabel('classification performance');
title('wind onset');
shuffperf=1-mean(shufferr);
plot([0 13],[shuffperf shuffperf],'--');
subplot(312); hold on;
for k=1:numel(genotypes)
    genoerror=err.(genotypes{k})(:,2);
    errorbar(k,1-mean(genoerror),std(genoerror)/sqrt(numel(genoerror)),'o','Color',colours{k},'Linewidth',2);
end
xlim([0 13]);
ylim([0 1]);
xticks([1:1:12]);
xticklabels(genotypes);
ylabel('classification performance');
title('oddour onset');
shuffperf=1-mean(shufferr);
plot([0 13],[shuffperf shuffperf],'--');
subplot(313); hold on;
for k=1:numel(genotypes)
    genoerror=err.(genotypes{k})(:,3);
    errorbar(k,1-mean(genoerror),std(genoerror)/sqrt(numel(genoerror)),'o','Color',colours{k},'Linewidth',2);
end
xlim([0 13]);
ylim([0 1]);
xticks([1:1:12]);
xticklabels(genotypes);
ylabel('classification performance');
title('wind offset');

%plot the error -> will have to compute the shuffled error
shuffperf=1-mean(shufferr);
plot([0 13],[shuffperf shuffperf],'--');



end