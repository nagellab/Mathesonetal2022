%% Script to generate plot for stimulus data 

load('./stimulusdata/manifold.mat')

%has all 5 directions, subtracted baseline, and converted from anemometer
%voltage to windspeed. Three trials at each direction. 

figure; hold on;
tvec=linspace(1,400000,400000)/10000;
meandir=nanmean([dir1subscale;dir2subscale;dir3subscale;dir4subscale;dir5subscale]);
stddir=nanstd([dir1subscale;dir2subscale;dir3subscale;dir4subscale;dir5subscale]);
plot(downsample(tvec,40),downsample(meandir,40)); %downsample so it doesn't take as long. 
%shadedErrorBar(tvec,meandir,stddir);
xlabel('time(s)');
ylabel('wind speed (cm/s)');
ylim([-1 30]);
yl=ylim;
patch([5 5 15 15],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
patch([15 15 25 25],[yl(1) yl(2) yl(2) yl(1)],[0 0.6 230/255],'FaceAlpha',0.1,'EdgeAlpha',0);
patch([25 25 35 35],[yl(1) yl(2) yl(2) yl(1)],[180/255 180/255 180/255],'FaceAlpha',0.2,'EdgeAlpha',0);
