
function makefigure3
%% 

%the LH and MB transtango images are: 
%LH1396_transtango_Brain3_10_11_19.czi
%MB052B TransTango 10_11_19 Brain1.czi

%65C03 image is only one
%13B10ADvt041421DBChrimson_brain1_6_20_19.czi 



%21D07 chat flp gaba brain 2 3_24_21.czi
%% atlas locations
FSBatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/FSBinputs.xlsx';
FSBatlaslocfull='/Users/andrew/Documents/Nagel/Andrew Behaviour/Fig3new.xlsx';
FSBatlaslocshort='/Users/andrew/Documents/Nagel/Andrew Behaviour/shortFSB.xlsx';

%extract paramters 
FSBparameters=extract(FSBatlaslocfull,'resblankalwayson10s');

FSBparameters=extract(FSBatlaslocshort,'resblankalwayson10s');



%% make behavioural trajectories

trajectories(FSBatlaslocshort,'/Users/andrew/Documents/Nagel/Andrew Behaviour/exampletrajectories.xlsx',' ')
%calculate and plot the inputs
[siglinesupall,siglinesdownall,magnitudesall,pvalsall]=plotparameters_FSB(FSBatlaslocfull,FSBparameters,{'all'},{'dFSB','dFSBsplit','vFSB','vFSBsplit','ltan','lFSB','mixed','LAL','PEN','PFN','FSIP','Ring','Compass','AB','blank'},' ','region');

makesummarytable(FSBatlaslocfull,siglinesupall,siglinesdownall,pvalsall,FSBparameters);
% generate FB5AB figures remember to use 10s for extracted upwind 
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,FSBparameters,{'upwind','curvatureoff','placepref'},{'FB5AB'},' ','driver');

%generate 65C03 figures
[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,FSBparameters,{'upwind','curvatureoff'},{'65C03'},' ','driver');

%generate vFSB figures 

[siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(FSBatlaslocshort,FSBparameters,{'upwind','curvatureoff'},{'vFSB'},' ','region');




%% generate actual timecourses
drivers={'vt062617'};
matchedtimecourses(FSBatlaslocfull,drivers,'activation',' '); %generates too many - reduce t

%actual would be

drivers={'65C03','13B10ADvt041421DB','FB5AB','vt062617'};
matchedtimecourses(FSBatlaslocfull,drivers,'activation',' ');


%% make TNT (and kir?) paired plot

tntatlasloc='/Users/andrew/Documents/Nagel/Andrew Behaviour/TNTatlas_newcategories.xlsx';
TNTparameters=extract(tntatlasloc,'res10salwaysonalwaysoff');
[sigupTNT,sigdownTNT,magnitudeTNT]=plotparameters_TNT(tntatlasloc,TNTparameters,{'upwind','curvatureoff'},{'FSB'},' ','region')








