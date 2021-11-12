function [dirratio]=directionalratio(headpath,tuningfilename,version)

close all; %make sure nothing else is open when you start 
cd('tuning2');
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


dirratio=[];

for k=1:numel(fn)
    framerate=chosenFrameRate.(fn{k});
    [avgfluor,~]=averagedirections(chosenfluor.(fn{k}));
    avgfluor.one=avgfluor.one-1;%subtract the baseline
    avgfluor.five=avgfluor.five-1;
    
    dir1avg=mean(avgfluor.one(window(1)*framerate:window(2)*framerate));
    dir2avg=mean(avgfluor.five(window(1)*framerate:window(2)*framerate));
    
    dr=(dir1avg-dir2avg);
    dirratio=[dirratio;dr];
end
    
end