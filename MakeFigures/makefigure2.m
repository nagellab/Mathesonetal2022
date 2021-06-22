function makefigure2(savefigs)

%wont be loading neuron cartoons 
%% define constants
actatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2Timecourses.xlsx';
actatlasmainloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2main.xlsx';
actatlassingleloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2single.xlsx';
tntatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2TNT.xlsx';

trajectoryloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Figure2Trajectories.xlsx';
drivers={'lh1396','MB052B','MB077B','MB112C','MB434B','MB082C'};
fulldriverlist='/Users/andrew/Documents/Nagel/Andrew Behaviour/refinedlines.xlsx';



%% plot example trajectories for LH and MB lines 
%generate example timecourses (A B C D G H)

trajectories(actatlasloc,trajectoryloc,' ');

%% plot timecourses for these as well (same axis and axis labels)

matchedtimecourses(actatlasloc,drivers,'activation',' '); %generates too many - reduce t

%decide where '10s light' goes -> on every on only on some

%% Make paired plots across lines (even those that aren't showing timecourses


parametersmain=extract(actatlasmainloc,'resblankalwayson10s');

%[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_new(fulldriverlist,parameters,{'upwind','curvatureoff'},{'LHON','MBON'},' ','region');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(actatlasmainloc,parametersmain,{'upwind','curvature','curvatureoff'},{'LHMB'},' ','region');

parameterssingle=extract(actatlassingleloc,'resblankalwayson10s');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(actatlassingleloc,parameterssingle,{'upwind','curvature','curvatureoff'},{'MBON'},' ','region');



%% make silencingplots I
TNTparameters=extract(tntatlasloc,'res10salwaysonalwaysoff');
[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,TNTparameters,{'upwind','curvature','curvatureoff'},{'LHMB'},' ','region')



%% Make imaging plots

%make lh1396 single example 
%the LH
alltrialstimecourse(pwd,'lh1396_012220_f1e2',2,0,1,0);

%10s imaging window for make calcium imaging for BOTH 


%% Make L) Ephys data

[physdata,filtdata]=MBONphysanalysis(1)


end