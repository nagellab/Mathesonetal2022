function makefigure1(savefigs)
%% Generate figure 1 and figure S1
%% Figure Constants 

actatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/refinedlines.xlsx';
orcoacvatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure1Timecourses.xlsx';
ctrlatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/basics.xlsx';
basicsatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/basics_full.xlsx';
ORatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Fig1OR.xlsx';
tntatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/TNTatlas_newcategories.xlsx';
exampletrajectorieslist='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure1exampletraj.xlsx';

coreceptorgenotypes={'orcoir8a','empty'};
tntgenotypes={'control5905','orcoir8a','orco','ir8a'};
emptygenotype={'emptygal4','emptysplit'};


%% Make subplot 1C) Orco-ACV trajectories
trajectories('/Users/andrew/Documents/Nagel/Andrew Behaviour/refinedlines.xlsx','/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure1exampletraj.xlsx',' ')

%% Make subplot 1D) Orco ACV timecourses 

%extract the data for orco vs acv in the same flies
[parameterslight,parametersodour]=orcoacvextract(orcoacvatlasloc,'resblankalwayson10s','res10salwaysonblank');
[ctrlparameters]=extract(ctrlatlasloc,'resblankalwayson10s');
[basicparameters]=extract(basicsatlasloc,'resblankalwayson10s');

%plot the matched timecourses (inside set the parameters - right now will
%do all)
%[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ctrlatlasloc,ctrlparameters,{'upwind','curvatureoff'},{'basic'},' ','region');
%[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(orcoacvatlasloc,parametersodour,{'upwind','curvatureoff'},{'OR coreceptor'},' ','region');
%[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(orcoacvatlasloc,parameterslight,{'upwind','curvatureoff'},{'OR coreceptor'},' ','region');

%merge the parameters 
mergedparameters.upwind.dparent=ctrlparameters.upwind.dparent;
mergedparameters.upwind.dempty=ctrlparameters.upwind.dempty;
mergedparameters.upwind.demptysplit=ctrlparameters.upwind.demptysplit;
mergedparameters.upwind.dACV=parametersodour.upwind.dorco5905acv;
mergedparameters.upwind.dorco=parameterslight.upwind.dorco5905acv;
mergedparameters.upwind.dorcoir8a=basicparameters.upwind.dorcoir8a;
mergedparameters.upwind.dir8a=basicparameters.upwind.dir8a;

mergedparameters.upwindbase.dparent=ctrlparameters.upwindbase.dparent;
mergedparameters.upwindbase.dempty=ctrlparameters.upwindbase.dempty;
mergedparameters.upwindbase.demptysplit=ctrlparameters.upwindbase.demptysplit;
mergedparameters.upwindbase.dACV=parametersodour.upwindbase.dorco5905acv;
mergedparameters.upwindbase.dorco=parameterslight.upwindbase.dorco5905acv;
mergedparameters.upwindbase.dorcoir8a=basicparameters.upwindbase.dorcoir8a;
mergedparameters.upwindbase.dir8a=basicparameters.upwindbase.dir8a;

mergedparameters.curvatureoff.dparent=ctrlparameters.curvatureoff.dparent;
mergedparameters.curvatureoff.dempty=ctrlparameters.curvatureoff.dempty;
mergedparameters.curvatureoff.demptysplit=ctrlparameters.curvatureoff.demptysplit;
mergedparameters.curvatureoff.dACV=parametersodour.curvatureoff.dorco5905acv;
mergedparameters.curvatureoff.dorco=parameterslight.curvatureoff.dorco5905acv;
mergedparameters.curvatureoff.dorcoir8a=basicparameters.curvatureoff.dorcoir8a;
mergedparameters.curvatureoff.dir8a=basicparameters.curvatureoff.dir8a;

mergedparameters.angvoff.dparent=ctrlparameters.angvoff.dparent;
mergedparameters.angvoff.dempty=ctrlparameters.angvoff.dempty;
mergedparameters.angvoff.demptysplit=ctrlparameters.angvoff.demptysplit;
mergedparameters.angvoff.dACV=parametersodour.angvoff.dorco5905acv;
mergedparameters.angvoff.dorco=parameterslight.angvoff.dorco5905acv;
mergedparameters.angvoff.dorcoir8a=basicparameters.angvoff.dorcoir8a;
mergedparameters.angvoff.dir8a=basicparameters.angvoff.dir8a;

mergedparameters.groundspeedoff.dparent=ctrlparameters.groundspeedoff.dparent;
mergedparameters.groundspeedoff.dempty=ctrlparameters.groundspeedoff.dempty;
mergedparameters.groundspeedoff.demptysplit=ctrlparameters.groundspeedoff.demptysplit;
mergedparameters.groundspeedoff.dACV=parametersodour.groundspeedoff.dorco5905acv;
mergedparameters.groundspeedoff.dorco=parameterslight.groundspeedoff.dorco5905acv;
mergedparameters.groundspeedoff.dorcoir8a=basicparameters.groundspeedoff.dorcoir8a;
mergedparameters.groundspeedoff.dir8a=basicparameters.groundspeedoff.dir8a;

mergedparameters.curvaturebase.dparent=ctrlparameters.curvaturebase.dparent;
mergedparameters.curvaturebase.dempty=ctrlparameters.curvaturebase.dempty;
mergedparameters.curvaturebase.demptysplit=ctrlparameters.curvaturebase.demptysplit;
mergedparameters.curvaturebase.dACV=parametersodour.curvaturebase.dorco5905acv;
mergedparameters.curvaturebase.dorco=parameterslight.curvaturebase.dorco5905acv;
mergedparameters.curvaturebase.dorcoir8a=basicparameters.curvaturebase.dorcoir8a;
mergedparameters.curvaturebase.dir8a=basicparameters.curvaturebase.dir8a;

%% 1E quantification ACV, orco, ir8a and controls 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(basicsatlasloc,mergedparameters,{'upwind','curvatureoff'},{'basic'},' ','region');


%% Fig 1D timecourses

%orcoir8a chrimson activation
matchedtimecourses(ORatlasloc,{'orcoir8a'},'activation',' ');

%ACV activation of orco flies (have to do the paired one) 


%% S1A timecourse and paired data
[indslight,indsodour]=matchedtimecourses2conds(orcoacvatlasloc,'orco5905acvChrimson','resblankalwayson10s','res10salwaysonblank',0);
%make the baseline subtracted paired plots
%figure; 
plotpaired_orcoactivation(parametersodour.upwind.dorco5905acv(indsodour)-parametersodour.upwindbase.dorco5905acv(indsodour),parameterslight.upwind.dorco5905acv(indslight)-parameterslight.upwindbase.dorco5905acv(indslight),1,'upwind velocity (mm/s)')
[h,p]=signrank(parametersodour.upwind.dorco5905acv(indsodour)-parametersodour.upwindbase.dorco5905acv(indsodour),parameterslight.upwind.dorco5905acv(indslight)-parameterslight.upwindbase.dorco5905acv(indslight));
figure;
plotpaired_orcoactivation(parametersodour.curvatureoff.dorco5905acv(indsodour)-parametersodour.curvaturebase.dorco5905acv(indsodour),parameterslight.curvatureoff.dorco5905acv(indslight)-parameterslight.curvaturebase.dorco5905acv(indslight),1,'curvature (deg/mm)')

[h,p]=signrank(parametersodour.upwind.dorco5905acv(indsodour)-parametersodour.upwindbase.dorco5905acv(indsodour),parameterslight.upwind.dorco5905acv(indslight)-parameterslight.upwindbase.dorco5905acv(indslight))
[h,p]=signrank(parametersodour.curvatureoff.dorco5905acv(indsodour)-parametersodour.curvaturebase.dorco5905acv(indsodour),parameterslight.curvatureoff.dorco5905acv(indslight)-parameterslight.curvaturebase.dorco5905acv(indslight))


clear indslight indsodour parameterslight parametersodour
%% Make subplot S1D) single OR data
%generate single OR parameters
parametersOR=extract(ORatlasloc,'resblankalwayson10s'); %this takes forever? 
%plot single OR parameters 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ORatlasloc,parametersOR,{'upwind','curvatureoff'},{'single OR'},' ','region');

%% make Fig 1F(timecouse) and 1G (genotype comparisons)

%generate timecourses for orco,ir8a silenced vs control
comparematchedtimecourses(tntatlasloc,{'control5905','orcoir8a'},' ','silencing');

%generate parameters 
TNTparameters=extract(tntatlasloc,'res10salwaysonalwaysoff');

[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,TNTparameters,{'upwind','curvatureoff'},{'OR coreceptor'},' ','region')


%% Make Supplemental Figure 1 

%% Figure S1B - empty-gal4 and empty split activation
comparematchedtimecourses(ctrlatlasloc,{'empty','emptysplit'},' ','activation');

%% Figure S1C timecourse
matchedtimecourses(ORatlasloc,{'orcoir8a'},'windoff',' ');
%S1C individual fly data
windoffparameters=extract(ORatlasloc,'resblankalwaysoff10s');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ORatlasloc,windoffparameters,{'upwind','curvatureoff'},{'orcoir8a'},' ','driver');


%% Figure S1E timecourse (orco silencing)

comparematchedtimecourses(tntatlasloc,{'control5905','orco'},' ','silencing');



windatlas='/Users/andrew/Documents/Nagel/Andrew Behaviour/windatlas.xlsx';
exampletrajectorieslist='/Users/andrew/Documents/Nagel/Andrew Behaviour/exampletrajectories.xlsx';

end

