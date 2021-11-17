function plotROIsummary(Cin,ROI,template_red)

%might need to get the frameratefrom this computer and merge that data?
%why is it mad

[imwidth,imheight,roinum]=size(ROI);
 figure;
 hold on;
 imframerate=5.3;%get value from notebook or xml file
 tvec=linspace(1,numel(Cin(1,:)),251)/5.3;
for k=1:roinum%iterate through each ROI
 ax1=subplot(211);
 
 hold on;
 xlabel('t(s)');
 ylabel('deltaF/F');
 patch([5 5 15 15],[-1 1 1 -1],[180/255 180/255 180/255],'FaceAlpha',0.5,'EdgeAlpha',0);
 patch([15 15 25 25],[-1 1 1 -1],[0 0.6 230/255],'FaceAlpha',0.3,'EdgeAlpha',0);
 patch([25 25 35 35],[-1 1 1 -1],[180/255 180/255 180/255],'FaceAlpha',0.5,'EdgeAlpha',0);
 plot(tvec,Cin(k,:),'k');
 %convert axis to seconds 
 
 %plot period when stimulus is on
 ax2=subplot(212);
 
 imagesc(template_red);
 hold on;
 try
 B=bwboundaries(ROI(:,:,k));
 for n=1:length(B)
     boundary=B{n};
     plot(boundary(:,2),boundary(:,1),'w','Linewidth',2);
 end
 catch
     disp('fuck');
 end
 kwait=waitforbuttonpress;
 cla(ax1);
 cla(ax2);
end

 
    