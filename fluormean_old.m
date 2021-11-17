function [avgfluorperiod]=fluormean_old(avgfluor,framerate,full,integrate)%this would be better if I took the mean of each trial and then averaged that and put the error on it right? I guess I have the std from before that I could just slap on
%chan
%change mean to integrate under the curve (trapz)
%change the base to the wind period
%but still normalize to the first 5s?
%if integrate use trapz rather than mean integrate=0 use

base={};
wind1={};
odour={};
wind2={};

%base on at 0 off at 5
%wind on at 5 off at 15
%odour on at 15 off at 25
%wind on at 25 off at 35
fn=fieldnames(avgfluor);

% normfluor=avgfluor;
% maxfluor=max([max(avgfluor.one),max(avgfluor.two),max(avgfluor.three),max(avgfluor.four),max(avgfluor.five)]);
% minfluor=min([min(avgfluor.one),min(avgfluor.two),min(avgfluor.three),min(avgfluor.four),min(avgfluor.five)]);
% normfluor.one=((avgfluor.one-minfluor)./(maxfluor-minfluor));
% normfluor.two=((avgfluor.two-minfluor)./(maxfluor-minfluor));
% normfluor.three=((avgfluor.three-minfluor)./(maxfluor-minfluor));
% normfluor.four=((avgfluor.four-minfluor)./(maxfluor-minfluor));
% normfluor.five=((avgfluor.five-minfluor)./(maxfluor-minfluor));

for k=1:numel(fn)%for each direction
    %take the average for each ROI for each direction
    if full
        if integrate
            %take the baseline and calculate the wind and odour period
            %Then integrate 
            %using the entire wind response here? Which is probably not
            %what I want to do? 
            b=trapz(avgfluor.(fn{k})(:,2:5*framerate),2);%skip the first because it is sometimes messed up
            w1=trapz(avgfluor.(fn{k})(:,5*framerate:15*framerate),2); %responses seem transient - what if I took those?
            o=trapz(avgfluor.(fn{k})(:,15*framerate:25*framerate),2);
            w2=trapz(avgfluor.(fn{k})(:,25*framerate:35*framerate),2);
        else
            b=mean(avgfluor.(fn{k})(:,2:5*framerate),2);%skip the first because it is sometimes messed up
            w1=mean(avgfluor.(fn{k})(:,5*framerate:15*framerate),2); %responses seem transient - what if I took those?
            o=mean(avgfluor.(fn{k})(:,15*framerate:25*framerate),2);
            w2=mean(avgfluor.(fn{k})(:,25*framerate:35*framerate),2);
        end
        
    else
        if integrate
            %%MAKING CHANGES HERE IN JAN 2021 *** To change the short avg
            %%fluor period. 
            b=trapz(avgfluor.(fn{k})(:,12.5*framerate:15*framerate),2);%use the wind baseline - ok I was already doing this hmm. 
            w1=trapz(avgfluor.(fn{k})(:,5*framerate:7.5*framerate),2); %responses seem transient - what if I took those?
            o=trapz(avgfluor.(fn{k})(:,79:90),2);
            w2=trapz(avgfluor.(fn{k})(:,25*framerate:30*framerate),2);
            
            
               %use this weird dimension stuff because

            %b=max(avgfluor.(fn{k})(:,12.5*framerate:15*framerate),[],2);%use the wind baseline - ok I was already doing this hmm. 
            %w1=max(avgfluor.(fn{k})(:,5*framerate:7.5*framerate),[],2); %responses seem transient - what if I took those?
            %o=max(avgfluor.(fn{k})(:,79:90),[],2);
            %w2=max(avgfluor.(fn{k})(:,25*framerate:30*framerate),[],2);


%             b=max(normfluor.(fn{k})(:,12.5*framerate:15*framerate),[],2);%use the wind baseline - ok I was already doing this hmm. 
%             w1=max(normfluor.(fn{k})(:,5*framerate:7.5*framerate),[],2); %responses seem transient - what if I took those?
%             o=max(normfluor.(fn{k})(:,15*framerate:17.5*framerate),[],2);
%             w2=max(normfluor.(fn{k})(:,25*framerate:30*framerate),[],2);
        else
            
            b=mean(avgfluor.(fn{k})(:,10*framerate:15*framerate),2);%use the wind baseline
            w1=mean(avgfluor.(fn{k})(:,10*framerate:1*framerate),2); %responses seem transient - what if I took those?
            o=mean(avgfluor.(fn{k})(:,79:90),2);
            w2=mean(avgfluor.(fn{k})(:,25*framerate:30*framerate),2);
        end
    end
    
    
    base.(fn{k})=b;
    wind1.(fn{k})=w1;
    odour.(fn{k})=o;
    wind2.(fn{k})=w2;
    
end
avgfluorperiod.base=base;
avgfluorperiod.wind1=wind1;
avgfluorperiod.odour=odour;
avgfluorperiod.wind2=wind2;

end


