function makefigure4_paper

%% define constants
FSBatlaslocshort='./datalocs/Cxgenotypes.xlsx';
trajectoryloc='./datalocs/Figure4exampletraj.xlsx';

%% Make imaging plots 
cd('./Imagingdata/');

makeimagingplots_paper(pwd,'21D07.mat',0,0,'');
makeimagingplots_paper(pwd,'65C03.mat',0,0,'');
makeimagingplots_paper(pwd,'12D12.mat',0,0,'');
makeimagingplots_paper(pwd,'vFB.mat',0,0,'');


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
%% directionality index 4D
 cd Imagingdata/
 
 dirratioscript_paper


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
%Gtacr silencing
%load gtacr data and make plots while returning p-values

load('./CleanBehaviourdata/extractedparameters/GTACRparameters/lightonparameters.mat');
load('./CleanBehaviourdata/extractedparameters/GTACRparameters/lightoffparameters.mat');

pvals=plotgtacr(parameterslight,parametersodour);

clear parameterslight parametersodour pvals
%% imaging examples Figure S4D

%will have to figure out what these are

end