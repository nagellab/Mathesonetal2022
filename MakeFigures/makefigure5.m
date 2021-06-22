%% function to make all the subplots for figure 4 (Imaging data)
function makefigure5(savefigs)


%plot A) is a diagram not included here
%cd to the 2 photon imaging folder
%% make subfigure B/C/D

cd('lh1396');
%somehow have to get it to save the ROI image
alltrialstimecourse(pwd,' ',1,0,0,0);
makeimagingplots(pwd,'lh1396new.mat',1,0,' ');
cd('..');
%% Make subfigure E/F/G
cd('MB052B');
alltrialstimecourse(pwd,' ',1,0,0,0);
makeimagingplots(pwd,'MB052Bnew.mat',1,0,'');
cd('..');
%% Make subfigure H/I/J
cd('65C03');
alltrialstimecourse(pwd,' ',2,0,0,0);
makeimagingplots(pwd,'65C03_analysis2.mat',1,0,' ');%have to turn off the plotting of someof these
cd('..');
%% Make subfigure K/L/M
cd('13B10ADvt041421DB');
alltrialstimecourse(pwd,' ',2,0,0,0);
makeimagingplots(pwd,'vFSBN_analysis2.mat',1,0,' ');
cd('..');

%% Make subfigure N -> Q

%need to do some adjustments here so it saves both - and matches axes ->
%maybe edit the mutli one to match. 

%% make subplot R

%% make dynamic range plot(s)


end