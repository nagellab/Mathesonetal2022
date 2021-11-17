
function makefigure3_paper
%% the LH and MB transtango images are: 
%LH1396_transtango_Brain3_10_11_19.czi
%MB052B TransTango 10_11_19 Brain1.czi
%% Define constants
FSBatlaslocfull='./datalocs/Cxgenotypes.xlsx';

%% generate summary tables for Fig 3 and S3

load('./CleanBehaviourdata/extractedparameters/CXparameters/CXparameters.mat');
[siglinesupall,siglinesdownall,magnitudesall,pvalsall]=plotparameters_FSB(FSBatlaslocfull,parameters,{'all'},{'dFSB','dFSBsplit','vFSB','vFSBsplit','ltan','lFSB','mixed','LAL','PEN','PFN','FSIP','Ring','Compass','AB','blank'},' ','region');
close all;
makesummarytable(FSBatlaslocfull,siglinesupall,siglinesdownall,pvalsall,parameters);

%% generate y dispersion 

ydispersion_paper

end
