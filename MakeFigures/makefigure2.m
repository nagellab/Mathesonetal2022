function makefigure2(savefigs)

%makes figures for Figure2 and S2

%% define constants and data locations
actatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2Timecourses.xlsx';
actatlasmainloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2main.xlsx';
actatlassingleloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2single.xlsx';
actatlassingleloclh='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2singleLH.xlsx';
tntatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2TNT.xlsx';

trajectoryloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2Trajectories.xlsx';
drivers={'lh1396','MB052B','MB077B','MB112C','MB434B','MB082C'};
fulldriverlist='/Users/andrew/Documents/Nagel/Andrew Behaviour/refinedlines.xlsx';



%% plot example trajectories for LH and MB lines in Fig 2.
%generate example trajectory  (A B C D) -LEFT

trajectories(actatlasloc,trajectoryloc,' ');

%% plot timecourses for these as well (same axis and axis labels) for Fig S2
%generate timecourses for LH/MB lines (A-D)

matchedtimecourses(actatlasloc,drivers,'activation',' '); 


%% Make fly-by-fly plots for various LH/MB lines (Fig 2 A-D RIGHT)

parametersmain=extract(actatlasmainloc,'resblankalwayson10s');

[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(actatlasmainloc,parametersmain,{'upwind','curvature','curvatureoff'},{'LHMB'},' ','region');

%% Make fly-by-fly plots for additional LH and MB lines (Fig S2B)
parameterssinglemb=extract(actatlassingleloc,'resblankalwayson10s');
[siglinesupmb,siglinesdownmb,magnitudesmb,pvalsmb]=plotparameters_FSB(actatlassingleloc,parameterssinglemb,{'upwind','curvature','curvatureoff'},{'MBON'},' ','region');

parameterssinglelh=extract(actatlassingleloclh,'resblankalwayson10s');
[siglinesuplh,siglinesdownlh,magnitudeslh,pvalslh]=plotparameters_FSB(actatlassingleloclh,parameterssinglelh,{'upwind','curvature','curvatureoff'},{'LHMB'},' ','region');



%% make silencingplots Fig S2C
TNTparameters=extract(tntatlasloc,'res10salwaysonalwaysoff');
[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,TNTparameters,{'upwind','curvature','curvatureoff'},{'LHMB'},' ','region')



%% Make imaging plots Fig 2E

makeimagingplots(pwd,'lh1396all.mat',0,0,'');
makeimagingplots(pwd,'MB052Bfullnew.mat',0,0,'');
%change the window that is being used between these for plotting
makeimagingplots(pwd,'reanalyze.mat',0,0,'');
makeimagingplots(pwd,'MB077Breanalyze.mat',0,0,'');


%% Calculate directional indices Fig 2F

%directionalratio from current data - first calculate and then plot 


%% Make anenometer plot Fig S2D 



%% example imaging plots (Fig S2E)

%make lh1396 single example 
 
alltrialstimecourse(pwd,'lh1396_012220_f1e2',2,0,1,0);

%MB052B single example 
alltrialstimecourse(pwd,'MB052B_apr2621_f1e1',2,0,1,0); % I think 

%MB077B single example
alltrialstimecourse_newthor(pwd,'MB077B_jul2021_f4e5',2,0,1,0);

%MB082C single example
alltrialstimecourse_newthor(pwd,'MB082C_jul0721_f1e3',2,0,1,0);



%% Make Fig 2G) Ephys data

load('ephysdataMBON.mat');
MBONplotting(physdata,filtdata,0);
%need to save the data from this somewhere/how
%reduce this to just plotting and doing the stats of this function