function [chosenfluor]=removemotion(chosenfluor,chosenred,thresholdstd,chosenframerate)
%THIS FUNCTION REMOVES FROM EVERY FLY

%TO DO A SINGLE FLY CALL THE HELPER RMmotion
%remove any trial where the red channel is moving too much since in
%practice this has not been something that is easy to correct.

%go through each of the chosen flies
fn=fieldnames(chosenfluor);
for k=1:numel(fn)
    %single fly's data
    currentfluor=chosenfluor.(fn{k});
    currentred=chosenred.(fn{k});
    framerate=chosenframerate.(fn{k});
    %I also need all the red data. i think I threw that out. Go back and
    %get the red data.
    
    %collect the
    currentfluor=rmmotion(currentfluor,currentred,thresholdstd,framerate);
    chosenfluor.(fn{k})=currentfluor;
end




end

