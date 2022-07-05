function [genotable]=tabulateforodourclassifier_abvbase(chosenfluor,chosenframerate,windwindow,odourwindow)

totaldata=[];
odours=[];
flyIDs=[];

data=chosenfluor;
Fr=chosenframerate;
fn=fieldnames(data);

for k=1:numel(fn)%for each fly
    %get each response period
    %count how many responses are above baseline -> only include the sample
    %if above baseline? or only include the fly if odour is above baseline
    windcount=0;
    odourcount=0;
    fly=data.(fn{k});
    base1=fly.one(:,3:5*Fr.(fn{k}));
    base2=fly.two(:,3:5*Fr.(fn{k}));
    base3=fly.three(:,3:5*Fr.(fn{k}));
    base4=fly.four(:,3:5*Fr.(fn{k}));
    base5=fly.five(:,3:5*Fr.(fn{k}));

    mb1=(mean(base1,2));
    mb2=(mean(base2,2));
    mb3=(mean(base3,2));
    mb4=(mean(base4,2));
    mb5=(mean(base5,2));

    stb1=std(base1');
    stb2=std(base2');
    stb3=std(base3');
    stb4=std(base4');
    stb5=std(base5');
    stb1=stb1';
    stb2=stb2';
    stb3=stb3';
    stb4=stb4';
    stb5=stb5';

    %using two standard devs as the threshold 
    thresh1=(mb1+(2*stb1));
    thresh2=(mb2+(2*stb2));
    thresh3=(mb3+(2*stb3));
    thresh4=(mb4+(2*stb4));
    thresh5=(mb5+(2*stb5));

    rthresh1=(mb1-(2*stb1));
    rthresh2=(mb2-(2*stb2));
    rthresh3=(mb3-(2*stb3));
    rthresh4=(mb4-(2*stb4));
    rthresh5=(mb5-(2*stb5));



    windsamp1=windwindow(1)*Fr.(fn{k});
    windsamp2=windwindow(2)*Fr.(fn{k});
    odoursamp1=odourwindow(1)*Fr.(fn{k});
    odoursamp2=odourwindow(2)*Fr.(fn{k});
    curronewind=mean(fly.one(:,windsamp1:windsamp2),2);
    currtwowind=mean(fly.two(:,windsamp1:windsamp2),2);
    currthreewind=mean(fly.three(:,windsamp1:windsamp2),2);
    currfourwind=mean(fly.four(:,windsamp1:windsamp2),2);
    currfivewind=mean(fly.five(:,windsamp1:windsamp2),2);

    curroneodour=mean(fly.one(:,odoursamp1:odoursamp2),2);
    currtwoodour=mean(fly.two(:,odoursamp1:odoursamp2),2);
    currthreeodour=mean(fly.three(:,odoursamp1:odoursamp2),2);
    currfourodour=mean(fly.four(:,odoursamp1:odoursamp2),2);
    currfiveodour=mean(fly.five(:,odoursamp1:odoursamp2),2);

    %windinds>thresh
    wi1=find(curronewind>thresh1);
    wi2=find(currtwowind>thresh2);
    wi3=find(currthreewind>thresh3);
    wi4=find(currfourwind>thresh4);
    wi5=find(currfivewind>thresh5);

    %odourinds>thresh

    oi1=find(curroneodour>thresh1);
    oi2=find(currtwoodour>thresh2);
    oi3=find(currthreeodour>thresh3);
    oi4=find(currfourodour>thresh4);
    oi5=find(currfiveodour>thresh5);

%     rwi1=find(curronewind<rthresh1);
%     rwi2=find(currtwowind<rthresh2);
%     rwi3=find(currthreewind<rthresh3);
%     rwi4=find(currfourwind<rthresh4);
%     rwi5=find(currfivewind<rthresh5);
% 
%     roi1=find(curroneodour<rthresh1);
%     roi2=find(currtwoodour<rthresh2);
%     roi3=find(currthreeodour<rthresh3);
%     roi4=find(currfourodour<rthresh4);
%     roi5=find(currfiveodour<rthresh5);
    

    %merge inds and remove duplicates to get good indices
    %just use above
    gi1=unique([wi1;oi1]);
    gi2=unique([wi2;oi2]);
    gi3=unique([wi3;oi3]);
    gi4=unique([wi4;oi4]);
    gi5=unique([wi5;oi5]);

%     gi1=unique([wi1;oi1;rwi1;roi1]);
%     gi2=unique([wi2;oi2;rwi2;roi2]);
%     gi3=unique([wi3;oi3;rwi3;roi3]);
%     gi4=unique([wi4;oi4;rwi4;roi4]);
%     gi5=unique([wi5;oi5;rwi5;roi5]);

    

    %temp has to make sure there are no nans -check if any of them are
    %empty first and then add 
    
    temp=[mean(curronewind(gi1));mean(currtwowind(gi2));mean(currthreewind(gi3));mean(currfourwind(gi4));mean(currfivewind(gi5));mean(curroneodour(gi1));mean(currtwoodour(gi2));mean(currthreeodour(gi3));mean(currfourodour(gi4));mean(currfiveodour(gi5))];
    notnaninds=~isnan(temp);
    temp=temp(notnaninds);
    ztemp=zscore(temp);
    totaldata=[totaldata;ztemp];
    %have to have some edge 

    %build up direction order
    odour=[0,0,0,0,0,1,1,1,1,1];
    odour=odour(notnaninds);
    %include the fly's ID (fly number of total)
    flyID=[k,k,k,k,k,k,k,k,k,k];
    flyID=flyID(notnaninds);
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



