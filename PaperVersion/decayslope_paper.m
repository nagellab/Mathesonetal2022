function [decay]=decayslope_paper(headpath,tuningfilename,version)

close all; %make sure nothing else is open when you start 

load(tuningfilename);
tuningname=strsplit(tuningfilename,'.');

cd(headpath);


fn=fieldnames(chosenfluor);

if version==1
    window=[15 25];
elseif version==2
    window=[20 30];
elseif version==3
    window=[5 10];
end


firsts=[];
seconds=[];
thirds=[];
fourths=[];
fifths=[];

figure; 
for k=1:numel(fn)
    framerate=chosenFrameRate.(fn{k});
    flyfluor=(chosenfluor.(fn{k}));
    
    average1=nanmean([flyfluor.one(1,(window(1)*framerate):(window(2)*framerate));flyfluor.two(1,window(1)*framerate:window(2)*framerate);flyfluor.three(1,window(1)*framerate:window(2)*framerate);flyfluor.four(1,window(1)*framerate:window(2)*framerate);flyfluor.five(1,window(1)*framerate:window(2)*framerate)]);
    average2=nanmean([flyfluor.one(2,(window(1)*framerate):(window(2)*framerate));flyfluor.two(2,window(1)*framerate:window(2)*framerate);flyfluor.three(2,window(1)*framerate:window(2)*framerate);flyfluor.four(2,window(1)*framerate:window(2)*framerate);flyfluor.five(2,window(1)*framerate:window(2)*framerate)]);
    average3=nanmean([flyfluor.one(3,(window(1)*framerate):(window(2)*framerate));flyfluor.two(3,window(1)*framerate:window(2)*framerate);flyfluor.three(3,window(1)*framerate:window(2)*framerate);flyfluor.four(3,window(1)*framerate:window(2)*framerate);flyfluor.five(3,window(1)*framerate:window(2)*framerate)]);
    average4=nanmean([flyfluor.one(4,(window(1)*framerate):(window(2)*framerate));flyfluor.two(4,window(1)*framerate:window(2)*framerate);flyfluor.three(4,window(1)*framerate:window(2)*framerate);flyfluor.four(4,window(1)*framerate:window(2)*framerate);flyfluor.five(4,window(1)*framerate:window(2)*framerate)]);
    try
        average5=nanmean([flyfluor.one(5,(window(1)*framerate):(window(2)*framerate));flyfluor.two(5,window(1)*framerate:window(2)*framerate);flyfluor.three(5,window(1)*framerate:window(2)*framerate);flyfluor.four(5,window(1)*framerate:window(2)*framerate);flyfluor.five(5,window(1)*framerate:window(2)*framerate)]);
    catch
        
    end
    firsts=[firsts;mean(average1)];
    seconds=[seconds;mean(average2)];
    thirds=[thirds;mean(average3)];
    fourths=[fourths;mean(average4)];
    fifths=[fifths;mean(average5)];
    
    %hold on; plot(1,mean(average1),'o');plot(2,mean(average2),'o');plot(3,mean(average3),'o');plot(4,mean(average4),'o');plot(5,mean(average5),'o');
    hold on; plot([1 2 3 4 5],[mean(average1),mean(average2),mean(average3),mean(average4),mean(average5)]);
end

plot([1,2,3,4,5],[mean(firsts),mean(seconds),mean(thirds),mean(fourths),mean(fifths)],'k','Linewidth',2);
decay.first=firsts;
decay.second=seconds;
decay.third=thirds;
decay.fourth=fourths;
decay.fith=fifths;
end