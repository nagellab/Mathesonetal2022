clear;
%% load all modules
%setenv('TZ','America/New_York')
%addpath(genpath(pwd))
%addpath(genpath('/gpfs/data/basulab/SR/Scripts/MATLAB/Phoenix')) %path to CNMF 
%addpath(genpath('/gpfs/data/basulab/SR/Scripts/MATLAB/Phoenix/CNMF')) %path to CNMF
%addpath(genpath('/gpfs/data/basulab/SR/Scripts/MATLAB/cvx'))
%% load files 
% Folder with stack images of diferent sessions
foldername='Z:\Andrew\2-photon imaging\vt019532\vt019532_f3e5_024corr'; %path to image folder
cd(foldername);
listfiles = dir('*.tif'); %will look for all the tif files
% !!! Files are listed in alphabetical order !!!
for i= 1:length(listfiles)
files{i}=fullfile(foldername, listfiles(i).name);
end
% Import ROI
FOV = [192,288]; % Image resolution (change with image)
d1=FOV(1);
d2=FOV(2);
ROI_file='RoiSet.zip'; %path to ROI file (.zip)
% Need ReadImageJROI.m script
[a,ROI] = ReadImageJROI(ROI_file,[d1,d2]);%need to reformat a using poly2mask
% Create Structure
input.foldername=foldername;
input.image=files;
input.list=listfiles;
input.ROI.file=ROI;
input.ROI.a=a;
input.param.FOV=FOV;

%% Set parameters soma %do I want this?
K = 1;                                           % number of components to be found
tau = 4;                                          % std of gaussian kernel (size of neuron)
p = 2;                                            % order of autoregressive system (p = 0 no dynamics, p=1 just decay, p = 2, both rise and decay)
merge_thr = 0.8;                                  % merging threshold
options = CNMFSetParms(...
                       'd1',d1,'d2',d2,...                        % dimensions of datasets
                       'search_method','dilate','dist',3,...       % search locations when updating spatial components
                       'deconv_method','constrained_foopsi',...    % activity deconvolution method
                       'method','dual',...                         %hopeless prayer AM
                       'temporal_iter',2,...                       % number of block-coordinate descent steps
                       'fudge_factor',0.98,...                     % bias correction for AR coefficients
                       'merge_thr',merge_thr,...                    % merging threshold
                       'gSig',tau...
                       );
% Create Structure                
input.param.options=options;
input.param.tau=tau;
input.param.p=p;
input.param.merge_thr=merge_thr;
                  
%% CNMF
input.refine=0; %refine components 
%Session to process
%session=1; 
%OR
%all session
session=1:size(files,2);

for i=1:length(session)
[output]= CNMF_noparpool(input, session(i)); 
end





