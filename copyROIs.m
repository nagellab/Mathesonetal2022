function copyROIs(headpath,fileexpnum)%change back to regular if you want to use regular

%function to copy the handdrawn ROIs to all other directories. 
%might need to add error checking. Can update hand drawn ones individually
%if there needs to be shifts


[ROIfile,ROIpath]=uigetfile('*.*'); %user picks ROI file from it's location (depends what trial you drew the ROIs from
ROIfilename=strcat(ROIpath,'RoiSet2.zip');%add the RoiSet to the path to make it the name of the file. This is the default name of the ROI set
cd(headpath);
filelist=dir;
for k=1:numel(filelist)
    dataname=filelist(k).name;
    if (contains(dataname,fileexpnum)&& contains(dataname,'corr')&&~contains(ROIpath,dataname))%put the ROI file only in the directories that have been motion corrected
%cannot copy onto itself.
        copyfile(ROIfilename,dataname)
    end
end


