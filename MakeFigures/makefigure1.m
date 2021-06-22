function makefigure1(savefigs)

%some of this will have to be from illustrator - not having matlab read in
%a vector image. 

%starting with B -> Make the two sets of example trajectories


%load orcochrimson data 
%make the overlayed trajectory plot 

%make baseline subtracted paired plots 

%make single OR paired plots (paired or just difference from baseline?)

%load OR coreceptor TNT data and control - make 3 timecourses

%plot the jitter plots for each 
%basically all of these will need to be resized in some way 
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

%exampletrajectories needs to be made smaller and add the text for the
%labels
%might need to be changed so it doesn't do all at once and you can just
%call a line
%or just make an excel sheet that just the lines you care about for figure1

%usuallyhandmade the multiplot one -> change it so that a function does it

%% Make subplot B) Orco-ACV trajectories
trajectories('/Users/andrew/Documents/Nagel/Andrew Behaviour/refinedlines.xlsx','/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure1exampletraj.xlsx',' ')
%lets not worry about size right now - let's just generate all the figures
%and then we can resize them later 
%% Make subplot C) and D) Orco ACV timecourses and paired plots
% probably made these very much by hand before

%extract the data for orco vs acv in the same flies
[parameterslight,parametersodour]=orcoacvextract(orcoacvatlasloc,'resblankalwayson10s','res10salwaysonblank');
[ctrlparameters]=extract(ctrlatlasloc,'resblankalwayson10s');
[basicparameters]=extract(basicsatlasloc,'resblankalwayson10s');
%plot the matched timecourses (inside set the parameters - right now will
%do all)
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ctrlatlasloc,ctrlparameters,{'upwind','curvatureoff'},{'basic'},' ','region');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(orcoacvatlasloc,parametersodour,{'upwind','curvatureoff'},{'OR coreceptor'},' ','region');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(orcoacvatlasloc,parameterslight,{'upwind','curvatureoff'},{'OR coreceptor'},' ','region');

%merge the parameters (annoying)
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


[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(basicsatlasloc,mergedparameters,{'upwind','curvatureoff'},{'basic'},' ','region');


%should I do it for all flies or paired flies explicitly? 



%for these use the prepare data with 0 on both 

[indslight,indsodour]=matchedtimecourses2conds(orcoacvatlasloc,'orco5905acvChrimson',0);
%make the baseline subtracted paired plots
figure; %looks like there is one weird additional fly? was I doing edge filtering before? Should be doing edge for odour? 
plotpaired_orcoactivation(parametersodour.upwind.dorco5905acv(indsodour)-parametersodour.upwindbase.dorco5905acv(indsodour),parameterslight.upwind.dorco5905acv(indslight)-parameterslight.upwindbase.dorco5905acv(indslight),1,'upwind velocity (mm/s)')
[h,p]=signrank(parametersodour.upwind.dorco5905acv(indsodour)-parametersodour.upwindbase.dorco5905acv(indsodour),parameterslight.upwind.dorco5905acv(indslight)-parameterslight.upwindbase.dorco5905acv(indslight));
figure;
plotpaired_orcoactivation(parametersodour.curvatureoff.dorco5905acv(indsodour)-parametersodour.curvaturebase.dorco5905acv(indsodour),parameterslight.curvatureoff.dorco5905acv(indslight)-parameterslight.curvaturebase.dorco5905acv(indslight),1,'curvature (deg/mm)')

% gotta work this out- something about alignment/filtering 
[h,p]=signrank(parametersodour.upwind.dorco5905acv(indsodour)-parametersodour.upwindbase.dorco5905acv(indsodour),parameterslight.upwind.dorco5905acv(indslight)-parameterslight.upwindbase.dorco5905acv(indslight))
[h,p]=signrank(parametersodour.curvatureoff.dorco5905acv(indsodour)-parametersodour.curvaturebase.dorco5905acv(indsodour),parameterslight.curvatureoff.dorco5905acv(indslight)-parameterslight.curvaturebase.dorco5905acv(indslight))





%have to fix colours on this - clearly I just illustratored it before
clear indslight indsodour parameterslight parametersodour
%% Make subplot E) single OR data

parametersOR=extract(ORatlasloc,'resblankalwayson10s'); %this takes forever? 
%check if the variable already exists and load it
%can probably extract this before and then just have it load into the
%workspace rather than have it reextract each time.
%maybe just make one that has the single ORs so I don't have to deal with
%this
%Do this now with the single metric plot, get rid of the baseline vs 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ORatlasloc,parametersOR,{'upwind','curvatureoff'},{'single OR'},' ','region');





%eventually going to have to change this to make relative paths because my
%stupid ass made it all hardcoded 


%% Make Subplot F orco-ir8a double activation and ir8a alone activation 

%plot the timecourses
comparematchedtimecourses(ORatlasloc,coreceptorgenotypes,' ','activation');
comparematchedtimecourses(basicsatlasloc,coreceptorgenotypes,' ','activation');

%plot the paired quantification
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ORatlasloc,parameters,{'upwind','curvatureoff'},{'coreceptor'},' ','region');


%% make subplot G and H

%generate timecourses
comparematchedtimecourses(tntatlasloc,tntgenotypes,' ','silencing'); %makes an extra plot of the control data - delete it
%generate jitterplot
%extracttntparameters
TNTparameters=extract(tntatlasloc,'res10salwaysonalwaysoff');

[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,TNTparameters,{'upwind','curvatureoff'},{'OR coreceptor'},' ','region')
%ideally I would like to change the order these show up in? 
%why didn't I make this do the fucking t tests
% do them here I guess? 

%% Make Supplemental Figure 1 
matchedtimecourses(ORatlasloc,{'orcoir8a'},'windoff',' ');
windoffparameters=extract(ORatlasloc,'resblankalwaysoff10s');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(ORatlasloc,windoffparameters,{'upwind','curvatureoff'},{'orcoir8a'},' ','driver');
windatlas='/Users/andrew/Documents/Nagel/Andrew Behaviour/windatlas.xlsx';
exampletrajectorieslist='/Users/andrew/Documents/Nagel/Andrew Behaviour/exampletrajectories.xlsx';

end

