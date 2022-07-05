%% make the orientation plots 

%find the same inds for each genotype and make polar plots, perform paired
%statistics 

%% first prepare the data

%orco,ir8a - GTACR
load("orcoir8a_odour.mat")
orco_odour=preparedata(Rorcoir8a,[30 35],0,0);
load("orcoir8a_inactivation.mat")
orco_light=preparedata(Rorcoir8a,[30 35],0,0);

%FB5AB (21D07- GTACR)
load("21D07_odour.mat")
FB5AB_odour=preparedata(R21D07,[30 35],0,0);
load("21D07_inactivation.mat")
FB5AB_light=preparedata(R21D07,[30 35],0,0);

%hdeltac (vt062617 GTACR)
load("vt062617_odour.mat")
hdc_odour=preparedata(Rvt062617,[30 35],0,0);
load('vt062617_inactivation.mat')
hdc_light=preparedata(Rvt062617,[30 35],0,0);
%% plot polar histograms 
%these are the ones shown with 10deg bins for presentation purposes 
[bins_o,orientations_o,meanorientations_o]=plot_avgorientations(orco_odour,orco_light,10);
[bins_f,orientations_f,meanorientations_f]=plot_avgorientations(FB5AB_odour,FB5AB_light,10);
[bins_h,orientations_h,meanorientations_h]=plot_avgorientations(hdc_odour,hdc_light,10);


%% run the statistics on odour early and late 
%use one degree bins for analysis
[bins_o,orientations_o,meanorientations_o]=plot_avgorientations(orco_odour,orco_light,1);
[bins_f,orientations_f,meanorientations_f]=plot_avgorientations(FB5AB_odour,FB5AB_light,1);
[bins_h,orientations_h,meanorientations_h]=plot_avgorientations(hdc_odour,hdc_light,1);



p_orco=orient_stats(bins_o,orientations_o);
p_FB5AB=orient_stats(bins_f,orientations_f);
p_hdc=orient_stats(bins_h,orientations_h);

