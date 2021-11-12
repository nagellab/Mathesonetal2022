figure; 

hold on;

plot(1*ones(size(dirratioLNa)),dirratioLNa,'.');
plot(2*ones(size(dirratioMB052B)),dirratioMB052B,'.');
plot(3*ones(size(dirratioMB077B)),dirratioMB077B,'.');
plot(4*ones(size(dirratioMB082C)),dirratioMB082C,'.');
plot(5*ones(size(dirratiolh1396)),dirratiolh1396,'.');
plot(6*ones(size(dirratio65C03)),dirratio65C03,'.');
plot(7*ones(size(dirratiovfb)),dirratiovfb,'.');
plot(8*ones(size(dirratio21D07)),dirratio21D07,'.');
plot(9*ones(size(dirratio12d12)),dirratio12d12,'.');


figure;

colours={[0 0 0],[54/255, 75/255, 154/255],[74/255,123/255,183/255],[110/255,166/255,205/255],[152/255,202/255,225/255],[253/255,179/255,102/255],[246/255,126/255,75/255],[221/255,61/255,45/255],[165/255,0,38/255]};

hold on;
plot([0 10],[0 0],'--','color','k','Linewidth',0.75);
errorbar(1,mean(dirratioLNa),std(dirratioLNa),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{1});
errorbar(2,mean(dirratioMB052B),std(dirratioMB052B),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{9});
errorbar(3,mean(dirratioMB077B),std(dirratioMB077B),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{8});
errorbar(4,mean(dirratioMB082C),std(dirratioMB082C),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{7});
errorbar(5,mean(dirratiolh1396),std(dirratiolh1396),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{6});
errorbar(6,mean(dirratio65C03),std(dirratio65C03),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{5});
errorbar(7,mean(dirratiovfb),std(dirratiovfb),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{4});
errorbar(8,mean(dirratio21D07),std(dirratio21D07),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{3});
errorbar(9,mean(dirratio12d12),std(dirratio12d12),'.','capsize',0,'Linewidth',2,'MarkerSize', 20,'color',colours{2});
xlim([0 10]);
xticklabels({'','LNa','MB052B','MB077B','MB082C','lh1396','65C03','vFB','21D07','12D12'});
ylabel('tuning index');
[h,p]=signrank(dirratioLNa)

figure;

hold on;

errorbar(1,mean(dirratioLNa2),std(dirratioLNa2),'o','capsize',0,'Linewidth',1,'MarkerSize', 8);
errorbar(3,mean(dirratioMB077B2),std(dirratioMB077B2),'o','capsize',0,'Linewidth',1,'MarkerSize', 8);
errorbar(4,mean(dirratioMB082C2),std(dirratioMB082C2),'o','capsize',0,'Linewidth',1,'MarkerSize', 8);
errorbar(8,mean(dirratio21D072),std(dirratio21D072),'o','capsize',0,'Linewidth',1,'MarkerSize', 8);
errorbar(9,mean(dirratio12d122),std(dirratio12d122),'o','capsize',0,'Linewidth',1,'MarkerSize', 8);


