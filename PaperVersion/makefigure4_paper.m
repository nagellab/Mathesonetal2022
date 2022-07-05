function makefigure4_paper

%% define constants
FSBatlaslocshort='./datalocs/Cxgenotypes.xlsx';
trajectoryloc='./datalocs/Figure4exampletraj.xlsx';

%% Make imaging plots 
cd('./Imagingdata/');

makeimagingplots_paper(pwd,'21D07.mat',0,0,'');
makeimagingplots_paper(pwd,'65C03.mat',0,0,'');
makeimagingplots_papernewthor(pwd,'12D12.mat',0,0,'');
makeimagingplots_paper(pwd,'vFB.mat',0,0,'');
cd ..

%% Make Example trajectories Figure 4C left

trajectories_paper(FSBatlaslocshort,trajectoryloc,' ');


%% Make genotype summary plots 4C right
load('./CleanBehaviourdata/extractedparameters/CXparameters/CXparameters.mat');

% generate FB5AB figures remember to use 10s for extracted upwind 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,parameters,{'upwind','curvatureoff',},{'FB5AB'},' ','driver');

%generate 65C03 figures
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,parameters,{'upwind','curvatureoff'},{'65C03'},' ','driver');

%generate vFSB figures 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,parameters,{'upwind','curvatureoff'},{'vFSB'},' ','region');

%generate 12D12 figures
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,parameters,{'upwind','curvatureoff'},{'12D12'},' ','driver');

clear parameters
%% classifiers for 4D and S4E/F
cd('./classification');
load('directionclassificationdata.mat');

%make the direction classifier plot - shuffling is random each iteration of
%run
err=treeerror(tables);
err=mergeerror(err);
shufferrall=shufflederrorall(tables);
shufferrall=mergeerror(shufferrall);
plottreeerorvsshuff(err,shufferrall);
clear all
load('odourclassificationdata.mat')
odourerr=treeodourerror(odourtables);
odourerr=mergeerror(odourerr);
shufferrodour=shufflederrorallodour(odourtables);
shufferrodour=mergeerror(shufferrodour);
pvalsodour=plotodourtreeerror(odourerr,shufferrodour);
odourbaseerr=treeodourerror(odourbasetables);
odourbaseerr=mergeerror(odourbaseerr);
shufferrodourbase=shufflederrorallodour(odourbasetables);
shufferrodourbase=mergeerror(shufferrodourbase);
pvalsodourbase=plotodourtreeerror(odourbaseerr,shufferrodourbase);
clear all
cd ..
 



%% Decay plot 4E

decayscript_paper

cd ..

clear dirratio* decay* 
%% Behavioural activation timecourses Figure S4A

drivers={'65C03','13B10ADvt041421DB','12D12','FB5AB'};
matchedtimecourses(FSBatlaslocshort,drivers,'activation',' ');


%% Behavioural silencing TNT and GTACR Figure S4C

%TNT silencing
load('./CleanBehaviourdata/extractedparameters/TNTparameters/TNTparameters.mat');
[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,parameters,{'upwind','curvatureoff'},{'FSB'},' ','region')
clear parameters sigupTNT sigdownTNT magnitudeTNT





end