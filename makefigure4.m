function makefigure4(savefigs)

%% define constants


actatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/Fig4Timecourses.xlsx';
trajectoryloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/exampletrajectories.xlsx';
drivers={'19G02ADvt062617DB','vt024634ADvt062617DB'};

%% plot behavioural trajectories 
trajectories(actatlasloc,trajectoryloc,' ');

%% plot timecourses

matchedtimecourses(actatlasloc,drivers,'activation',' ');
HdeltaCparameters=extract(actatlasloc,'resblankalwayson10s');
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(actatlasloc,HdeltaCparameters,{'upwind','curvature'},{'cFSB'},' ','region');
%% plot calcium imaging examples
%yeah should hardcode this so I can find it again 

%choose column 7 
alltrialstimecourse(pwd,'vt062617_021120_f3e4',2,0,1,0);
ylim([0.9 1.25]);
%ok what is a good second example - choose column 8
alltrialstimecourse(pwd,'vt062617_031120_f6e6',2,0,1,0);

%supplemental choose biggest column
alltrialstimecourse(pwd,'vt062617_021320_f1e1',2,0,1,0);


end