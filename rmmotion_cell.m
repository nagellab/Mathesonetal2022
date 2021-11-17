function currentfluor=rmmotion_cell(currentfluor,currentred, thresholdstd,framerate)


%should this do something different if it's shaped differently? Like if it
%is taken in as a cell? 

axall=[];
figteststd=figure('Position',[1 1 1920 237]); hold on;

redstd=[];
directions=fieldnames(currentred);
for p=1:5
    %allred=[currentred.(directions{p}){1};currentred.(directions{p}){2};currentred.(directions{p}){3};currentred.(directions{p}){4};currentred.(directions{p}){5}];
    redstd(p,:)=nanstd(currentred.(directions{p})');
    ax=subplot(1,5,p); hold on;
    axall=[axall;ax];
    plot([1 2 3 4 5],redstd(p,:),'o')
    plot([0 6],[thresholdstd,thresholdstd],'k');
    
end

linkaxes(axall);




figtest1=figure('Position',[1 681 1920 297]); hold on; subplot(151); hold on; plot(currentred.one');subplot(152); hold on; plot(currentred.two');subplot(153); hold on; plot(currentred.three');subplot(154'); hold on; plot(currentred.four');subplot(155); hold on; plot(currentred.five');

figtest2=figure('Position',[1 312 1920 295]); hold on; subplot(151); hold on; plot(currentfluor.one');subplot(152); hold on; plot(currentfluor.two');subplot(153); hold on; plot(currentfluor.three');subplot(154'); hold on; plot(currentfluor.four');subplot(155); hold on; plot(currentfluor.five');
for iter=1:5
    subplot(1,5,iter)
    yl=ylim;
    plot([round(15.4*framerate), round(15.4*framerate)],yl);
    plot([round(18*framerate), round(18*framerate)],yl);
end
%identify any trials where there the standard deviation of the red
%channel is too high and NaN them out;
excludematrix=redstd>thresholdstd;

%exclude the fly if it has too many trials that are bad

kwait=waitforbuttonpress;




close(figtest1);
close(figtest2);
close(figteststd);

%sum up how many are moving for each direction
nummovingtrials=sum(excludematrix,2);
%find the max number moved
maxmovingtrials=max(nummovingtrials);
if maxmovingtrials>=3
    %instead of making nan just don't do anything
    currentfluor.one=NaN;
    currentfluor.two=NaN;
    currentfluor.three=NaN;
    currentfluor.four=NaN;
    currentfluor.five=NaN;
    %chosenfluor.(fn{k})=currentfluor;
else
    for p=1:5% go through for each direction
        currexclude=excludematrix(p,:);
        %get the trial numbers (indices to exclude)
        indicesex=find(currexclude);
        %if none have to be delted just skip
        if ~isempty(indicesex)
            
            for q=1:numel(indicesex)
                %this is probably deleting too many eugh
                currentfluor.(directions{p})(indicesex(q),:)=NaN;
            end
        end
    end
end




end