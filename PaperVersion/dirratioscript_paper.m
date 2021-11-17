%calculate the direction ratios of all imaged genotypes

dirratiolh1396=directionalratio_paper(pwd,'lh1396',1);
dirratioMB052B=directionalratio_paper(pwd,'MB052B',1);
dirratioMB082C=directionalratio_paper(pwd,'MB082C',2);
dirratioMB077B=directionalratio_paper(pwd,'MB077B',2);
dirratio65C03=directionalratio_paper(pwd,'65C03',1);
dirratio21D07=directionalratio_paper(pwd,'21D07',1);
dirratio12d12=directionalratio_paper(pwd,'12D12',2);
dirratiovfb=directionalratio_paper(pwd,'vFB',1);
dirratioLNa=directionalratio_paper(pwd,'LNa',3);

%plot a figure with the directional index, standard dev
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

[h,p]=ttest(dirratioLNa)
[h,p]=ttest(dirratiolh1396)
[h,p]=ttest(dirratioMB052B)
[h,p]=ttest(dirratioMB077B)
[h,p]=ttest(dirratioMB082C)
[h,p]=ttest(dirratio65C03)
[h,p]=ttest(dirratio21D07)
[h,p]=ttest(dirratio12d12)
[h,p]=ttest(dirratiovfb)


