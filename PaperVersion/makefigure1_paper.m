function makefigure1_paper(savefigs)
%% Generate figure 1 and figure S1
%% Figure Constants 

actatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/refinedlines.xlsx';
orcoacvatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure1Timecourses.xlsx';
ctrlatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/basics.xlsx';
basicsatlasloc='./datalocs/Basics_paper.xlsx';
ORatlasloc='./datalocs/singleORs_paper.xlsx';
tntatlasloc='./datalocs/TNTatlas.xlsx';
exampletrajectorieslist='./datalocs/Figure1exampletraj.xlsx';

coreceptorgenotypes={'orcoir8a','empty'};
tntgenotypes={'control5905','orcoir8a','orco','ir8a'};
emptygenotype={'emptygal4','emptysplit'};


%% Make subplot 1C) Orco,ir8a-ACV trajectories
trajectories_paper('./datalocs/Basics_paper.xlsx','./datalocs/Figure1exampletraj.xlsx',' ')

%% Make subplot 1D) Orco ACV timecourses 

%load the extracted data from the right locations. 

%plot the matched timecourses (inside set the parameters - right now will
%do all)
matchedtimecourses_paper(basicsatlasloc,{'orcoir8a'},'activation',' ');

%do the same for ACV but only the matched timecourses - So not just the
%paired parameters but the whole paired data - might need to manually save 
%that will mess up the plotting though so will need to figure it out 


%% 1E quantification ACV, orco, ir8a and controls 

load('./CleanBehaviourdata/extractedparameters/ORparameters/OrcoACVParameters.mat');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(basicsatlasloc,parameters,{'upwind','curvatureoff'},{'basic'},' ','region');

clear parameters

%% make Fig 1F(timecouse) and 1G (genotype comparisons)

%generate timecourses for orco,ir8a silenced vs control
comparematchedtimecourses_paper(tntatlasloc,{'control5905','orcoir8a'},' ','silencing');
%load TNT-silencing parameters 

load('./CleanBehaviourdata/extractedparameters/TNTparameters/TNTparameters.mat');

[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,parameters,{'upwind','curvatureoff'},{'OR coreceptor'},' ','region')

clear parameters;

%% S1A timecourse and paired data %fix this
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
%load single OR data
load('./CleanBehaviourdata/extractedparameters/ORparameters/ORparameters.mat');
%plot single OR parameters 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ORatlasloc,parameters,{'upwind','curvatureoff'},{'single OR'},' ','region');

clear parameters;
%% Make Supplemental Figure 1 

%% Figure S1B - empty-gal4 and empty split activation
comparematchedtimecourses(ctrlatlasloc,{'empty','emptysplit'},' ','activation');

%% Figure S1C timecourse
matchedtimecourses_paper(ORatlasloc,{'orcoir8a'},'windoff',' ');
%S1C individual fly data
load('./CleanBehaviourdata/extractedparameters/windoff/Windoffparameters.mat');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ORatlasloc,parameters,{'upwind','curvatureoff'},{'orcoir8a'},' ','driver');


%% Figure S1E timecourse (orco silencing)

comparematchedtimecourses_paper(tntatlasloc,{'control5905','orco'},' ','silencing');


end

