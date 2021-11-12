%% function to make all the subplots for figure 5 and S5, h?C cells 
function makefigure5(savefigs)

%% define constants


actatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Fig4Timecourses.xlsx';
trajectoryloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/exampletrajectories.xlsx';
drivers={'19G02ADvt062617DB','vt024634ADvt062617DB'};

%% mean plots for individual vt062617 column examples
%will have to hardcode the ROI# in 
%choose column 7 
alltrialstimecourse(pwd,'vt062617_021120_f3e4',2,0,1,0);
ylim([0.9 1.25]);
%ok what is a good second example - choose column 8
alltrialstimecourse(pwd,'vt062617_031120_f6e6',2,0,1,0);

%% Generate all columns by direction Figure 5F

%%  Generate all columns wind and odour timecourse Figure 5G

%% Generate column centered analysis Figure 5H

% HA the terrible script 


%% plot behavioural trajectories for splits in 5I
trajectories(actatlasloc,trajectoryloc,' ');

%% plot timecourses and paired plots Figure 5I, S5C

matchedtimecourses(actatlasloc,drivers,'activation',' ');
HdeltaCparameters=extract(actatlasloc,'resblankalwayson10s');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(actatlasloc,HdeltaCparameters,{'upwind','curvature'},{'cFSB'},' ','region');
%% plot calcium imaging example for supplement (Figure S5A)
%supplemental choose biggest column
alltrialstimecourse(pwd,'vt062617_021320_f1e1',2,0,1,0);

%make paired for all columns wind vs odour 




end