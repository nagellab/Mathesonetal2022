function [dirratio]=directionalratio_paper(headpath,tuningfilename,version)

close all; %make sure nothing else is open when you start 
%load the genotype of interest
load(tuningfilename);
tuningname=strsplit(tuningfilename,'.');

cd(headpath);

%get all the experiments
fn=fieldnames(chosenfluor);

%choose the correct window depending on how much lead time there was before
%the stimulus came on
if version==1
    window=[15 25];
elseif version==2
    window=[20 30];
elseif version==3
    window=[5 10];
end

%make an empty vector to get the fly by fly directional ratio
dirratio=[];

for k=1:numel(fn)
    framerate=chosenFrameRate.(fn{k});
    [avgfluor,~]=averagedirections(chosenfluor.(fn{k}));%get average fluo
    avgfluor.one=avgfluor.one-1;%subtract the baseline (otherwise sits at 1)
    avgfluor.five=avgfluor.five-1;
    %take mean furing the window
    dir1avg=mean(avgfluor.one(window(1)*framerate:window(2)*framerate));
    dir2avg=mean(avgfluor.five(window(1)*framerate:window(2)*framerate));
    %take the difference between sides
    dr=(dir1avg-dir2avg);
    dirratio=[dirratio;dr];
end
    
end