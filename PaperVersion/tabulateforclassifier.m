function [genotable,genosidetable]=tabulateforclassifier(chosenfluor,chosenframerate,window)

totaldata=[];
dirs={};
sides={};
flyIDs=[];

data=chosenfluor; 
Fr=chosenframerate;
fn=fieldnames(data);
for k=1:numel(fn)%for each fly 
    %get each response period 
    fly=data.(fn{k});
    samp1=window(1)*Fr.(fn{k});
    samp2=window(2)*Fr.(fn{k});
    curronewind=fly.one(:,samp1:samp2);
    currtwowind=fly.two(:,samp1:samp2);
    currthreewind=fly.three(:,samp1:samp2);
    currfourwind=fly.four(:,samp1:samp2);
    currfivewind=fly.five(:,samp1:samp2);
    temp=[];
    temp=[mean(mean(curronewind,2));mean(mean(currtwowind,2));mean(mean(currthreewind,2));mean(mean(currfourwind,2));mean(mean(currfivewind,2))];
    %take z-score across each fly to normalize for inter-fly differences
    ztemp=zscore(temp);
    %add Z-score data to all data
    fn=fieldnames(chosenfluor);
    if contains(fn{1},'lh1')
        totaldata=[totaldata;ztemp];
    else
        totaldata=[totaldata;ztemp];
    end
    
    %build up direction order
    currdirs={'one','two','three','four','five'};
    %recode directions as to side of the fly
    side={'left','left','center','right','right'};
    %include the fly's ID (fly number of total)
    flyID=[k,k,k,k,k];
    %add to overall vectors of these
    dirs=[dirs,currdirs];
    flyIDs=[flyIDs,flyID];
    sides=[sides,side];
end
%convert to table and make variables categorical
genotable=table(dirs',flyIDs',totaldata);
genotable.Var1=categorical(genotable.Var1);
genotable.Var2=categorical(genotable.Var2);

%make a second table but with side data
genosidetable=table(sides',flyIDs',totaldata);
genosidetable.Var1=categorical(genosidetable.Var1);
genosidetable.Var2=categorical(genosidetable.Var2);

end



