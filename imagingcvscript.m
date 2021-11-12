
%% standard deviation 
figure; hold on; 


figure; hold on; plot(ones(1,numel(MB052Bstd)),MB052Bstd,'.','color',[0.7 0.7 0.7]);
plot(2*ones(1,numel(stdMB077B)),stdMB077B,'.','color',[0.7 0.7 0.7]);
plot(3*ones(1,numel(stdMB082C)),stdMB082C,'.','color',[0.7 0.7 0.7]);
plot(4*ones(1,numel(lh1396std)),lh1396std,'.','color',[0.7 0.7 0.7]);
plot(5*ones(1,numel(std65C03)),std65C03,'.','color',[0.7 0.7 0.7]);
plot(6*ones(1,numel(stdvfb)),stdvfb,'.','color',[0.7 0.7 0.7]);
plot(7*ones(1,numel(std21D07)),std21D07,'.','color',[0.7 0.7 0.7]);
plot(8*ones(1,numel(std12D12)),std12D12,'.','color',[0.7 0.7 0.7]);

plot(1,mean(MB052Bstd),'ko');
plot(2,mean(stdMB077B),'ko');
plot(3,mean(stdMB082C),'ko');
plot(4,mean(lh1396std),'ko');
plot(5,mean(std65C03),'ko');
plot(6,mean(stdvfb),'ko');
plot(7,mean(std21D07),'ko');
plot(8,mean(std12D12),'ko');

xlim([0 9])
xticklabels({'','MB052B','MB077B','MB082C','lh1396','65C03','vFB','FB5AB','12D12'});
ylabel('standard deviation');



%% CV

figure; hold on; 

colours={[54/255, 75/255, 154/255],[74/255,123/255,183/255],[110/255,166/255,205/255],[152/255,202/255,225/255],[253/255,179/255,102/255],[246/255,126/255,75/255],[221/255,61/255,45/255],[165/255,0,38/255]};


figure; hold on; 
plot(ones(1,numel(cvMB052B)),cvMB052B,'.','color',[0.7 0.7 0.7],'MarkerSize', 10);
plot(2*ones(1,numel(cvMB077B)),cvMB077B,'.','color',[0.7 0.7 0.7],'MarkerSize', 10);
plot(3*ones(1,numel(cvMB082C)),cvMB082C,'.','color',[0.7 0.7 0.7],'MarkerSize', 10);
plot(4*ones(1,numel(cvlh1396)),cvlh1396,'.','color',[0.7 0.7 0.7],'MarkerSize', 10);
plot(5*ones(1,numel(cv65C03)),cv65C03,'.','color',[0.7 0.7 0.7],'MarkerSize', 10);
plot(6*ones(1,numel(cvvfb)),cvvfb,'.','color',[0.7 0.7 0.7],'MarkerSize', 10);
plot(7*ones(1,numel(cv21D07)),cv21D07,'.','color',[0.7 0.7 0.7],'MarkerSize',10);
plot(8*ones(1,numel(cv12D12)),cv12D12,'.','color',[0.7 0.7 0.7],'MarkerSize', 10);

plot(1,mean(cvMB052B),'.','color',colours{8},'Linewidth',1,'MarkerSize', 20);
plot(2,mean(cvMB077B),'.','color',colours{7},'Linewidth',1,'MarkerSize', 20);
plot(3,mean(cvMB082C),'.','color',colours{6},'Linewidth',1,'MarkerSize', 20);
plot(4,mean(cvlh1396),'.','color',colours{5},'Linewidth',1,'MarkerSize', 20);
plot(5,mean(cv65C03),'.','color',colours{4},'Linewidth',1,'MarkerSize', 20);
plot(6,mean(cvvfb),'.','color',colours{3},'Linewidth',1,'MarkerSize',20);
plot(7,mean(cv21D07),'.','color',colours{2},'Linewidth',1,'MarkerSize', 20);
plot(8,mean(cv12D12),'.','color',colours{1},'Linewidth',1,'MarkerSize', 20);

xlim([0 9])
xticklabels({'','MB052B','MB077B','MB082C','lh1396','65C03','vFB','FB5AB','12D12'});
ylabel('CV');


