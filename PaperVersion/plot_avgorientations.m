% polar plot script
function[bins,orients,orients_mean]=plot_avgorientations(resdata1,resdata2,binwidth)

[bcob, chob, mhob]=avg_thetahist(resdata1,[5 25],binwidth);
[bclb, chlb, mhlb]=avg_thetahist(resdata2,[5 25],binwidth);
stdob=std(chob);
stdlb=std(chlb);
%convert to error and make loop for plotting
stdob=[stdob stdob(1)]/sqrt(size(chob,1));
stdlb=[stdlb stdlb(1)]/sqrt(size(chlb,1));

[bco, cho, mho]=avg_thetahist(resdata1,[30 35],binwidth);
[bcl, chl, mhl]=avg_thetahist(resdata2,[30 35],binwidth);
stdo=std(cho);
stdl=std(chl);
%convert to error and make loop for plotting
stdo=[stdo stdo(1)]/sqrt(size(cho,1));
stdl=[stdl stdl(1)]/sqrt(size(chl,1));

[bco2, cho2, mho2]=avg_thetahist(resdata1,[35 40],binwidth);
[bcl2, chl2, mhl2]=avg_thetahist(resdata2,[35 40],binwidth);
stdo2=std(cho2);
stdl2=std(chl2);
%convert to error and make loop for plotting
stdo2=[stdo2 stdo2(1)]/sqrt(size(cho2,1));
stdl2=[stdl2 stdl2(1)]/sqrt(size(chl2,1));
%convert these to x and y values to plot in cartesian like theresa does so
%I can jackknife crossval 

bins.base_odour=bcob;
bins.base_light=bclb;
bins.odour=bco;
bins.light=bcl;
bins.odour2=bco2;
bins.light2=bcl2;

orients.base_odour=chob;
orients.base_light=chlb;
orients.odour=cho;
orients.light=chl;
orients.odour2=cho2;
orients.light2=chl2;

orients_mean.base_odour=mhob;
orients_mean.base_light=mhlb;
orients_mean.odour=mho;
orients_mean.light=mhl;
orients_mean.odour2=mho2;
orients_mean.light2=mhl2;


figure;
subplot(131);
polarplot(deg2rad([bcob,bcob(1)]),[mhob mhob(1)],'k','LineWidth',2);
hold on;
polarplot(deg2rad([bcob,bcob(1)]),[mhob mhob(1)]-stdob,'k','LineWidth',0.25);
polarplot(deg2rad([bcob,bcob(1)]),[mhob mhob(1)]+stdob,'k','LineWidth',0.25);
polarplot(deg2rad([bclb,bclb(1)]),[mhlb mhlb(1)],'b','LineWidth',2);
polarplot(deg2rad([bclb,bclb(1)]),[mhlb mhlb(1)]-stdlb,'b','LineWidth',0.25);
polarplot(deg2rad([bclb,bclb(1)]),[mhlb mhlb(1)]+stdlb,'b','LineWidth',0.25);

title('baseline');

subplot(132);
polarplot(deg2rad([bco,bco(1)]),[mho mho(1)],'k','LineWidth',2);
hold on;
polarplot(deg2rad([bco,bco(1)]),[mho mho(1)]-stdo,'k','LineWidth',0.25);
polarplot(deg2rad([bco,bco(1)]),[mho mho(1)]+stdo,'k','LineWidth',0.25);
polarplot(deg2rad([bcl,bcl(1)]),[mhl mhl(1)],'b','LineWidth',2);
polarplot(deg2rad([bcl,bcl(1)]),[mhl mhl(1)]-stdl,'b','LineWidth',0.25);
polarplot(deg2rad([bcl,bcl(1)]),[mhl mhl(1)]+stdl,'b','LineWidth',0.25);
title('first 5s odor');

subplot(133);
polarplot(deg2rad([bco2,bco2(1)]),[mho2 mho2(1)],'k','LineWidth',2);
hold on;
polarplot(deg2rad([bco2,bco2(1)]),[mho2 mho2(1)]-stdo2,'k','LineWidth',0.25);
polarplot(deg2rad([bco2,bco2(1)]),[mho2 mho2(1)]+stdo2,'k','LineWidth',0.25);
polarplot(deg2rad([bcl2,bcl2(1)]),[mhl2 mhl2(1)],'b','LineWidth',2);
polarplot(deg2rad([bcl2,bcl2(1)]),[mhl2 mhl2(1)]-stdl2,'b','LineWidth',0.25);
polarplot(deg2rad([bcl2,bcl2(1)]),[mhl2 mhl2(1)]+stdl2,'b','LineWidth',0.25);
title('last 5s odor');

end
