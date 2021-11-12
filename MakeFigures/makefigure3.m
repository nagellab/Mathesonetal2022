
function makefigure3
%% 

%the LH and MB transtango images are: 
%LH1396_transtango_Brain3_10_11_19.czi
%MB052B TransTango 10_11_19 Brain1.czi

%65C03 image is only one
%13B10ADvt041421DBChrimson_brain1_6_20_19.czi 
%12D12 is only one 



%21D07 chat flp gaba brain 2 3_24_21.czi
%% Define constants 
FSBatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/FSBinputs.xlsx';
FSBatlaslocfull='/Users/andrew/Documents/Nagel/Andrew Behaviour/Fig3new.xlsx';
FSBatlaslocshort='/Users/andrew/Documents/Nagel/Andrew Behaviour/shortFSB.xlsx';
FB5ABatlas='/Users/andrew/Documents/Nagel/Andrew Behaviour/FB5ABactivation.xlsx';
%extract parameters for the table figure 
FSBparameters=extract(FSBatlaslocfull,'resblankalwayson10s');

FSBparameters=extract(FSBatlaslocshort,'resblankalwayson10s');

FB5ABparameters=extract(FB5ABatlas,'resblankalwaysonhigh'); % have to fix this 

%% make behavioural trajectories

trajectories(FSBatlaslocshort,'/Users/andrew/Documents/Nagel/Andrew Behaviour/exampletrajectories.xlsx',' ')
%calculate and plot the inputs
%can close all - not necessary to actually look at but need these for
%making the table 
[siglinesupall,siglinesdownall,magnitudesall,pvalsall]=plotparameters_FSB(FSBatlaslocfull,FSBparameters,{'all'},{'dFSB','dFSBsplit','vFSB','vFSBsplit','ltan','lFSB','mixed','LAL','PEN','PFN','FSIP','Ring','Compass','AB','blank'},' ','region');
[siglinesupFB5AB,siglinesdownFB5AB,magnitudesFB5AB,pvalsFB5AB]=plotparameters_FSB(FB5ABatlas,FB5ABparameters,{'all'},{'dFSB'},' ','region');

%need to resolve the handling of FB5AB - includes supplemental table 
makesummarytable(FSBatlaslocfull,siglinesupall,siglinesdownall,pvalsall,FSBparameters);
makesummarytable(FB5ABatlas,siglinesupFB5AB,siglinesdownFB5AB,pvalsFB5AB,FB5ABparameters);

% generate FB5AB figures remember to use 10s for extracted upwind 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,FSBparameters,{'upwind','curvatureoff','placepref'},{'FB5AB'},' ','driver');

%generate 65C03 figures
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,FSBparameters,{'upwind','curvatureoff'},{'65C03'},' ','driver');

%generate vFSB figures 

[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,FSBparameters,{'upwind','curvatureoff'},{'vFSB'},' ','region');

%generate 12D12 figures

[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,FSBparameters,{'upwind','curvatureoff'},{'12D12'},' ','driver');

%% generate actual timecourses
drivers={'vt062617'};
matchedtimecourses(FSBatlaslocfull,drivers,'activation',' '); %generates too many - reduce t

%actual would be

drivers={'65C03','13B10ADvt041421DB','12D12','FB5AB','vt062617'};
drivers={'12D12'}
matchedtimecourses(FSBatlaslocfull,drivers,'activation',' ');


%% make TNT (and kir?) paired plot

tntatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/TNTatlas_newcategories.xlsx';
TNTparameters=extract(tntatlasloc,'res10salwaysonalwaysoff');
[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,TNTparameters,{'upwind','curvatureoff'},{'FSB'},' ','region')








