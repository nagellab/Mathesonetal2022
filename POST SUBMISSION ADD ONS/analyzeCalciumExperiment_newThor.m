function analyzeCalciumExperiment_newThor(headpath,fileexpnum,imskip,expskip,correction,fluor,copy,savemode)
%give this function the experimental path you want to start in
%and the filename and experiment number (ie vt019532_f3e4)
%correction if the motion correction needs to be done, fluor if the dff
%hasn't been extracted yet.

%CURRENTLY SET TO USE ROISET2 -> IF YOU WANT ORIGINALS WILL HAVE TO MAKE
%CHANGES IN dff2 and COPYROIS 
%SAVE IN SEPARATE EXTRACTED FOLDER!!! 
%MAKE PLOTS IN SEPARATE FOLDER NOT TO OVERWRITE q
%HOPEFULLY THIS HARDDRIVE HAS ENOUGH SPACE 
if correction
    Correct_all(headpath,fileexpnum); %motionq correct all data
end

%analyze the data for each
[Xpix,Ypix,FrameRate]=findkeyparams_newThor();
FrameRate=str2double(FrameRate);
if fluor
    copy=0; %Andrew you are doing this to save yourself the pain of overwriting hand moved ones
    if copy
        disp('Please select the master ROIset');
        copyROIs(headpath,fileexpnum);%copy the ROIdataset to all folders necessary
    end
    cd(headpath);
    filelist=dir;
    for k=1:numel(filelist)%should do something if it should skip a trial? why hasn't this been a problem before 
        dataname=filelist(k).name;
        if (contains(dataname,fileexpnum)&& contains(dataname,'corr'))
            %should pass the full path here I guess?
            fullpath=strcat(headpath,'/');
            fullpath=strcat(fullpath,dataname);
            try
                dff2(fullpath,Ypix,Xpix);%do the analysis and save extracted values
            catch
                disp(['well we had to skip ' fileexpnum]);
            end
            cd(headpath);%pop back up to the top so you can go down to the next trial
        end
    end
end

[fluordata,fluordata_red,fluordata_diff,ROIs,redtemps]=pooldirections(headpath,fileexpnum,imskip,expskip,1,FrameRate);
%ROIs=reshape(ROIs,[Ypix,Xpix]);%make it an easy 3-D matrix so each plane is a ROI image
ROIs=full(ROIs);
%meanBaseGreen=
%avggreen=mean(CinGreen(:,1:5*framerate),2);
%divGreen=CinGreen./avggreen

%[dgG,drR,diffRG]=RGdiff(fluordata,fluordata_red)
try
[avgfluor,stdfluor]=avgROIs(fluordata);
catch
    disp('debug')
end
[avgred,stdred]=avgROIs(fluordata_red);%get the red averages? -> probably want to convert to deltaF/F for each first
[avgdiff,stddiff]=avgROIs(fluordata_diff);
plotfluordirections(avgdiff,redtemps,ROIs,Xpix,Ypix,FrameRate);
%make a version of this that takes them all and then plots them together
if savemode
    if ~exist('extracted2','dir')
        mkdir('extracted2');
    end
    cd ('extracted2');
    savefilename=strcat(fileexpnum,'_analysis2');
    save(savefilename,'fluordata','fluordata_red','fluordata_diff','ROIs','redtemps','avgfluor','stdfluor','avgred','stdred','avgdiff','stddiff','Xpix','Ypix','FrameRate');
    cd(headpath);
end





end
