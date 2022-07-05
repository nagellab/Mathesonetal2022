
%this one does the difference 

load("LNa.mat");

Leftfluor=chosenfluor;
LeftFR=chosenFrameRate;

load("RIGHT.mat");

Rightfluor=chosenfluor;
RightFR=chosenFrameRate;


fn=fieldnames(Leftfluor);
window=[5 10]%this window is for wind - should we just do this for all the periods? 

totaldata=[];
totaldataL=[];
totaldataR=[];
dirs={};
sides={};
flyIDs=[];
for k=1:numel(fn)%for each fly 
    %get each response period 
    flyL=Leftfluor.(fn{k});
    flyR=Rightfluor.(fn{k});
    samp1L=window(1)*LeftFR.(fn{k});
    samp2L=window(2)*LeftFR.(fn{k});
    samp1R=window(1)*RightFR.(fn{k});
    samp2R=window(2)*RightFR.(fn{k});
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
    tempL=[];
    tempR=[];
    tempL=[mean(mean(curronewindL,2));mean(mean(currtwowindL,2));mean(mean(currthreewindL,2));mean(mean(currfourwindL,2));mean(mean(currfivewindL,2))];
    tempR=[mean(mean(curronewindR,2));mean(mean(currtwowindR,2));mean(mean(currthreewindR,2));mean(mean(currfourwindR,2));mean(mean(currfivewindR,2))];
    %take z-score across each fly to normalize for inter-fly differences
    ztemp=zscore(tempL-tempR); %%%CHANGED IT HERE ANDREW
    ztempL=zscore(tempL);
    ztempR=zscore(tempR);
    %add Z-score data to all data
    totaldata=[totaldata;ztemp];
    totaldataL=[totaldataL;ztempL];
    totaldataR=[totaldataR;ztempR];
    
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
Lnadifftab=table(dirs',flyIDs',totaldata);
Lnadifftab.Var1=categorical(Lnadifftab.Var1);
Lnadifftab.Var2=categorical(Lnadifftab.Var2);



%make a second table but with side data
Lnadifftabsides=table(sides',flyIDs',totaldata);
Lnadifftabsides.Var1=categorical(Lnadifftabsides.Var1);
Lnadifftabsides.Var2=categorical(Lnadifftabsides.Var2);

LnaLtabsides=table(sides',flyIDs',totaldataL);
LnaLtabsides.Var1=categorical(LnaLtabsides.Var1);
LnaLtabsides.Var2=categorical(LnaLtabsides.Var2);

LnaRtabsides=table(sides',flyIDs',totaldataR);
LnaRtabsides.Var1=categorical(LnaRtabsides.Var1);
LnaRtabsides.Var2=categorical(LnaRtabsides.Var2);



LNatree=fitctree(Lnadifftab,"Var1",'crossval','on');
errLNa=kfoldLoss(LNatree,'Mode','individual');

LNatreeside=fitctree(Lnadifftabsides,"Var1",'crossval','on');
errLNasides=kfoldLoss(LNatreeside,'Mode','individual');
LNaLtreeside=fitctree(LnaLtabsides,"Var1",'crossval','on');
errLLNasides=kfoldLoss(LNaLtreeside,'Mode','individual');
LNaRtreeside=fitctree(LnaRtabsides,"Var1",'crossval','on');
errRLNasides=kfoldLoss(LNaRtreeside,'Mode','individual');

figure;hold on;
errorbar(0,1-mean(err.dPFNa(:,1)),std(err.dPFNa(:,1)/sqrt(numel(err.dPFNa(:,1)))),'o','Linewidth',2)
errorbar(1,1-mean(errLNasides),std(errLNasides)/sqrt(numel(errLNasides)),'o','Linewidth',2);
errorbar(2,1-mean(errLLNasides),std(errLLNasides)/sqrt(numel(errLLNasides)),'o','Linewidth',2);
errorbar(3,1-mean(errRLNasides),std(errRLNasides)/sqrt(numel(errRLNasides)),'o','Linewidth',2);
xlim([-1 4]);
xticks([0 1 2 3]);
xticklabels({'PFN','both LNa','left LNa','right LNa'});
ylim([0 1]);
ylabel('classification performance');