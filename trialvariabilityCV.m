function[trialstds]=trialvariabilityCV(chosenfluor,chosenframerate,version)
fn=fieldnames(chosenfluor);
trialstds=[];
if version==1
    window=[15 20];
elseif version==2
    window=[20 25];
end
for k=1:numel(fn)
    alldat=[chosenfluor.(fn{k}).one;chosenfluor.(fn{k}).two;chosenfluor.(fn{k}).three;chosenfluor.(fn{k}).four;chosenfluor.(fn{k}).five];
    framerate=chosenframerate.(fn{k});
    %odourperiod=alldat(:,15*framerate:25*framerate);%old
    odourperiod=alldat(:,window(1)*framerate:window(2)*framerate);%new
    trialavgodour=mean(odourperiod,2);
    trialstd=std(trialavgodour)/mean(trialavgodour);
    trialstds=[trialstds;trialstd];
end

end