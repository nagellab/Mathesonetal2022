%% function to make all the subplots for figure 5 and S5, h?C cells 
function makefigure5_paper(savefigs)

%% define constants

actatlasloc='./datalocs/hdeltac.xlsx';
trajectoryloc='./datalocs/Figure5exampletraj.xlsx';
drivers={'19G02ADvt062617DB','vt024634ADvt062617DB'};

%% mean plots for individual vt062617 column examples
% ROI (example column) is hardcoded in, run one at a time to preserve
% colourmaps
cd Imagingdata/
alltrialstimecourse_hdc(pwd,'vt062617_021120_f3e4',8);
ylim([0.9 1.25]);

alltrialstimecourse_hdc(pwd,'vt062617_031120_f6e6',9);

cd ..

%% Generate all columns by direction Figure 5F/Generate all columns wind and odour timecourse Figure 5G/ Generate column centered analysis Figure 5H, generate max aligned columns in 5I

cd Imagingdata

processvt062617_paper
maxalignedvt062617

cd ..

%% plot calcium imaging example for supplement (Figure S5B)
%supplemental choose biggest column (col2) 
cd Imagingdata
alltrialstimecourse_hdc(pwd,'vt062617_021320_f1e1',3);
ylim([0.9 1.25])
column_histogram_hdc %fig s5c 
cd ..
end