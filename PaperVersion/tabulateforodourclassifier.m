function [genotable]=tabulateforodourclassifier(chosenfluor,chosenframerate,windwindow,odourwindow)

totaldata=[];
odours=[];
flyIDs=[];

data=chosenfluor; 
Fr=chosenframerate;
fn=fieldnames(data);

for k=1:numel(fn)%for each fly 
    %get each response period 
    fly=data.(fn{k});
    windsamp1=windwindow(1)*Fr.(fn{k});
    windsamp2=windwindow(2)*Fr.(fn{k});
    odoursamp1=odourwindow(1)*Fr.(fn{k});
    odoursamp2=odourwindow(2)*Fr.(fn{k});
    curronewind=fly.one(:,windsamp1:windsamp2);
    currtwowind=fly.two(:,windsamp1:windsamp2);
    currthreewind=fly.three(:,windsamp1:windsamp2);
    currfourwind=fly.four(:,windsamp1:windsamp2);
    currfivewind=fly.five(:,windsamp1:windsamp2);

    curroneodour=fly.one(:,odoursamp1:odoursamp2);
    currtwoodour=fly.two(:,odoursamp1:odoursamp2);
    currthreeodour=fly.three(:,odoursamp1:odoursamp2);
    currfourodour=fly.four(:,odoursamp1:odoursamp2);
    currfiveodour=fly.five(:,odoursamp1:odoursamp2);
    temp=[];
    temp=[mean(mean(curronewind,2));mean(mean(currtwowind,2));mean(mean(currthreewind,2));mean(mean(currfourwind,2));mean(mean(currfivewind,2));mean(mean(curroneodour,2));mean(mean(currtwoodour,2));mean(mean(currthreeodour,2));mean(mean(currfourodour,2));mean(mean(currfiveodour,2))];
    %take z-score across each fly to normalize for inter-fly differences
    ztemp=zscore(temp);
    %add Z-score data to all data
    totaldata=[totaldata;ztemp];
    
    %build up direction order
    odour=[0,0,0,0,0,1,1,1,1,1];
    %include the fly's ID (fly number of total)
    flyID=[k,k,k,k,k,k,k,k,k,k];
    %add to overall vectors of these
    odours=[odours,odour];
    flyIDs=[flyIDs,flyID];
    
end
%convert to table and make variables categorical
if contains(fn{1},'21D07')
    disp('21D07');
end
genotable=table(odours',flyIDs',totaldata);
genotable.Var1=categorical(genotable.Var1);
genotable.Var2=categorical(genotable.Var2);

end



