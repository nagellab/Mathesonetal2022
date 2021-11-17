function [fluordataperiod]=fluormean(fluordata,framerate,full,integrate)%this would be better if I took the mean of each trial and then averaged that and put the error on it right? I guess I have the std from before that I could just slap on
%NO LONGER TAKES IN THE AVERAGE VECTOR, TAKES IN THE FULL
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
fn=fieldnames(fluordata); % this is going to be the directions


for k=1:numel(fn)%for each direction
    %take the average for each ROI for each direction
    if isnan(fluordata.(fn{k}))
        b=NaN;
        w1=NaN;
        o=NaN;
        w2=NaN;
    else
        if full
            if integrate
                %take the baseline and calculate the wind and odour period
                %Then integrate
                %using the entire wind response here? Which is probably not
                %what I want to do?
                b=trapz(fluordata.(fn{k})(:,2:5*framerate),2);%skip the first because it is sometimes messed up
                w1=trapz(fluordata.(fn{k})(:,5*framerate:15*framerate),2); %responses seem transient - what if I took those?
                o=trapz(fluordata.(fn{k})(:,15*framerate:25*framerate),2);
                w2=trapz(fluordata.(fn{k})(:,25*framerate:35*framerate),2);
            else
                b=median(fluordata.(fn{k})(:,2:5*framerate),2);%skip the first because it is sometimes messed up
                w1=median(fluordata.(fn{k})(:,5*framerate:15*framerate),2); %responses seem transient - what if I took those?
                o=median(fluordata.(fn{k})(:,15*framerate:25*framerate),2);
                w2=median(fluordata.(fn{k})(:,25*framerate:35*framerate),2);
            end
            
        else
            if integrate

                flymean=fluordata.(fn{k})(:,round(15*framerate):round(20*framerate));
                resampflymean=resample(flymean,25,size(flymean,2));
                flymeanwind=fluordata.(fn{k})(:,round(5*framerate):round(10*framerate));
                resampflymeanwind=resample(flymeanwind,25,size(flymean,2));
                
                
                
                b=sum(fluordata.(fn{k})(:,12.5*framerate:15*framerate),2);%use the wind baseline - ok I was already doing this hmm.
                w1=sum(resampflymeanwind-1,2); 
                o=sum(resampflymean-1,2);
                w2=sum(fluordata.(fn{k})(:,25*framerate:30*framerate),2);
                
             
            else
                
                %this is what is being used in current version of paper
                %scripts
                
  
                %older thor
                b=nanmean(fluordata.(fn{k})(:,10*framerate:15*framerate),2);%use the wind baseline
                w1=nanmean(fluordata.(fn{k})(:,(round(5*framerate)):round(15*framerate)),2); %responses seem transient - what if I took those?
                o=nanmean(fluordata.(fn{k})(:,(round(15*framerate)):round(25*framerate)),2);
                w2=nanmean(fluordata.(fn{k})(:,25*framerate:30*framerate),2);
                
                %newer thor
%                 b=nanmean(fluordata.(fn{k})(:,10*framerate:15*framerate),2);%use the wind baseline
%                 w1=nanmean(fluordata.(fn{k})(:,(round(10*framerate)):round(20*framerate)),2); %responses seem transient - what if I took those?
%                 o=nanmean(fluordata.(fn{k})(:,(round(20*framerate)):round(30*framerate)),2);
%                 w2=nanmean(fluordata.(fn{k})(:,30*framerate:40*framerate),2);
            end
        end
    end
        
        
        base.(fn{k})=b;
        wind1.(fn{k})=w1;
        odour.(fn{k})=o;
        wind2.(fn{k})=w2;
        
    end
    fluordataperiod.base=base;
    fluordataperiod.wind1=wind1;
    fluordataperiod.odour=odour;
    fluordataperiod.wind2=wind2;
end




