%% Make figure 4 -> FSB figure 
%% generate paired plots
%%generate the screen figure for upwind, curvature during, and curvature at
%%offset 
%requires different sorting so that all FB genotypes included together (not
%split to inputs and columnar)

%% constants 
FSBatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/FSBinputs.xlsx';
FSBtrajectorie=;
drivers={'FB5AB','65C03','13B10ADvt041421DB'};
%figure out something with sorting
%% generate A B C





FSBparameters=extract(FSBatlasloc,'resblankalwayson10s'); %get all the screen data for activation (10s) during wind (alwayson) no odour

[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters(FSBatlasloc,FSBparameters,{'upwind','curvature','curvatureoff'},{'FSB'},' ','region');


%% make the trajectories 
trajectories(FSBatlasloc,'/Users/andrew/Documents/Nagel/Andrew Behaviour/FSBtrajectories.xlsx',' ')

%% generate the timecourses
matchedtimecourses(FSBatlasloc,drivers,'activation',' ');


%% generate imaging results 


%cd to 21D07 directory 
alltrialstimecourse(pwd,'21D07_082020_f2e2',2,0,1,0);
makeimagingplots(pwd,'21D07new.mat',0,0,'');
