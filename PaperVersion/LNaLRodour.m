
%this one does the difference 

load("LNa.mat");

Leftfluor=chosenfluor;
LeftFR=chosenFrameRate;

load("RIGHT.mat");

Rightfluor=chosenfluor;
RightFR=chosenFrameRate;


fn=fieldnames(Leftfluor);
window=[5 10];%this window is for wind - should we just do this for all the periods? 
window2=[15 20];
totaldata=[];
totaldataL=[];
totaldataR=[];
odours=[];
flyIDs=[];
for k=1:numel(fn)%for each fly 
    %get each response period 
    flyL=Leftfluor.(fn{k});
    flyR=Rightfluor.(fn{k});
    samp1L=window(1)*LeftFR.(fn{k});
    samp2L=window(2)*LeftFR.(fn{k});
    samp1R=window(1)*RightFR.(fn{k});
    samp2R=window(2)*RightFR.(fn{k});
    odoursamp1L=window2(1)*LeftFR.(fn{k});
    odoursamp2L=window2(2)*LeftFR.(fn{k});
    odoursamp1R=window2(1)*RightFR.(fn{k});
    odoursamp2R=window2(2)*RightFR.(fn{k});
    curronewindL=flyL.one(:,samp1L:samp2L);
    currtwowindL=flyL.two(:,samp1L:samp2L);
    currthreewindL=flyL.three(:,samp1L:samp2L);
    currfourwindL=flyL.four(:,samp1L:samp2L);
    currfivewindL=flyL.five(:,samp1L:samp2L);
    curronewindR=flyR.one(:,samp1R:samp2R);
    currtwowindR=flyR.two(:,samp1R:samp2R);
    currthreewindR=flyR.three(:,samp1R:samp2R);
    currfourwindR=flyR.four(:,samp1R:samp2R);
    currfivewindR=flyR.five(:,samp1R:samp2R);

    curroneodourL=flyL.one(:,odoursamp1L:odoursamp2L);
    currtwoodourL=flyL.two(:,odoursamp1L:odoursamp2L);
    currthreeodourL=flyL.three(:,odoursamp1L:odoursamp2L);
    currfourodourL=flyL.four(:,odoursamp1L:odoursamp2L);
    currfiveodourL=flyL.five(:,odoursamp1L:odoursamp2L);
    
    curroneodourR=flyR.one(:,odoursamp1R:odoursamp2R);
    currtwoodourR=flyR.two(:,odoursamp1R:odoursamp2R);
    currthreeodourR=flyR.three(:,odoursamp1R:odoursamp2R);
    currfourodourR=flyR.four(:,odoursamp1R:odoursamp2R);
    currfiveodourR=flyR.five(:,odoursamp1R:odoursamp2R);
    tempL=[];
    tempR=[];
    tempL=[mean(mean(curronewindL,2));mean(mean(currtwowindL,2));mean(mean(currthreewindL,2));mean(mean(currfourwindL,2));mean(mean(currfivewindL,2));mean(mean(curroneodourL));mean(mean(currtwoodourL));mean(mean(currthreeodourL));mean(mean(currfourodourL));mean(mean(currfiveodourL))];
    tempR=[mean(mean(curronewindR,2));mean(mean(currtwowindR,2));mean(mean(currthreewindR,2));mean(mean(currfourwindR,2));mean(mean(currfivewindR,2));mean(mean(curroneodourR));mean(mean(currtwoodourR));mean(mean(currthreeodourR));mean(mean(currfourodourR));mean(mean(currfiveodourR))];
    %take z-score across each fly to normalize for inter-fly differences
    ztemp=zscore(tempL-tempR); %%%CHANGED IT HERE ANDREW
    ztempL=zscore(tempL);
    ztempR=zscore(tempR);
    %add Z-score data to all data
    totaldata=[totaldata;ztemp];
    totaldataL=[totaldataL;ztempL];
    totaldataR=[totaldataR;ztempR];
    
    %build up direction order
    currodour=[0,0,0,0,0,1,1,1,1,1];
    %include the fly's ID (fly number of total)
    flyID=[k,k,k,k,k,k,k,k,k,k];
    %add to overall vectors of these
    odours=[odours,currodour];
    flyIDs=[flyIDs,flyID];

end
%convert to table and make variables categorical
Lnadifftabodour=table(odours',flyIDs',totaldata);
Lnadifftabodour.Var1=categorical(Lnadifftabodour.Var1);
Lnadifftabodour.Var2=categorical(Lnadifftabodour.Var2);


%basically need to do this but filter 
%%ANDREW LOOK AT THIS YOU ARE GOING TO FILTER THIS DIFF TAB _ AND THEN
%%INCLUDE IT _ THAT IS ALLL DO NOT FORGET ABOUT IT OR LET MATLAB CRASH




%% version for separate windows 

load("LNa.mat");

Leftfluor=chosenfluor;
LeftFR=chosenFrameRate;

load("RIGHT.mat");

Rightfluor=chosenfluor;
RightFR=chosenFrameRate;


fn=fieldnames(Leftfluor);
window=[5 10];%this window is for wind - should we just do this for all the periods? 
window2=[15 20];
totaldata=[];
totaldataL=[];
totaldataR=[];
odours=[];
flyIDs=[];
for k=1:numel(fn)%for each fly 
    %get each response period 
    flyL=Leftfluor.(fn{k});
    flyR=Rightfluor.(fn{k});
    samp1L=wwLR.dLNa(k,1);
    samp2L=wwLR.dLNa(k,2);
    samp1R=wwLR.dRIGHT(k,1);
    samp2R=wwLR.dRIGHT(k,2);
    odoursamp1L=owLR.dLNa(k,1);
    odoursamp2L=owLR.dLNa(k,2);
    odoursamp1R=owLR.dRIGHT(k,1);
    odoursamp2R=owLR.dRIGHT(k,2);
    curronewindL=flyL.one(:,samp1L:samp2L);
    currtwowindL=flyL.two(:,samp1L:samp2L);
    currthreewindL=flyL.three(:,samp1L:samp2L);
    currfourwindL=flyL.four(:,samp1L:samp2L);
    currfivewindL=flyL.five(:,samp1L:samp2L);
    curronewindR=flyR.one(:,samp1R:samp2R);
    currtwowindR=flyR.two(:,samp1R:samp2R);
    currthreewindR=flyR.three(:,samp1R:samp2R);
    currfourwindR=flyR.four(:,samp1R:samp2R);
    currfivewindR=flyR.five(:,samp1R:samp2R);

    curroneodourL=flyL.one(:,odoursamp1L:odoursamp2L);
    currtwoodourL=flyL.two(:,odoursamp1L:odoursamp2L);
    currthreeodourL=flyL.three(:,odoursamp1L:odoursamp2L);
    currfourodourL=flyL.four(:,odoursamp1L:odoursamp2L);
    currfiveodourL=flyL.five(:,odoursamp1L:odoursamp2L);
    
    curroneodourR=flyR.one(:,odoursamp1R:odoursamp2R);
    currtwoodourR=flyR.two(:,odoursamp1R:odoursamp2R);
    currthreeodourR=flyR.three(:,odoursamp1R:odoursamp2R);
    currfourodourR=flyR.four(:,odoursamp1R:odoursamp2R);
    currfiveodourR=flyR.five(:,odoursamp1R:odoursamp2R);
    tempL=[];
    tempR=[];
    tempL=[mean(mean(curronewindL,2));mean(mean(currtwowindL,2));mean(mean(currthreewindL,2));mean(mean(currfourwindL,2));mean(mean(currfivewindL,2));mean(mean(curroneodourL));mean(mean(currtwoodourL));mean(mean(currthreeodourL));mean(mean(currfourodourL));mean(mean(currfiveodourL))];
    tempR=[mean(mean(curronewindR,2));mean(mean(currtwowindR,2));mean(mean(currthreewindR,2));mean(mean(currfourwindR,2));mean(mean(currfivewindR,2));mean(mean(curroneodourR));mean(mean(currtwoodourR));mean(mean(currthreeodourR));mean(mean(currfourodourR));mean(mean(currfiveodourR))];
    %take z-score across each fly to normalize for inter-fly differences
    ztemp=zscore(tempL-tempR); %%%CHANGED IT HERE ANDREW
    ztempL=zscore(tempL);
    ztempR=zscore(tempR);
    %add Z-score data to all data
    totaldata=[totaldata;ztemp];
    totaldataL=[totaldataL;ztempL];
    totaldataR=[totaldataR;ztempR];
    
    %build up direction order
    currodour=[0,0,0,0,0,1,1,1,1,1];
    %include the fly's ID (fly number of total)
    flyID=[k,k,k,k,k,k,k,k,k,k];
    %add to overall vectors of these
    odours=[odours,currodour];
    flyIDs=[flyIDs,flyID];

end
%convert to table and make variables categorical
Lnadiff_windowtab=table(odours',flyIDs',totaldata);
Lnadiff_windowtab.Var1=categorical(Lnadifftabodour.Var1);
Lnadiff_windowtab.Var2=categorical(Lnadifftabodour.Var2);
