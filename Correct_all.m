function Correct_all(headpath,fileexpnum)
%give this function the path of the folder you want to start in as headpath
%then give it the starter or the regex before the numbering starts
%iterates through all files and does the motion corretion using
%ADP_Motion_Correction3

cd(headpath);
filelist=dir;
for k=1:numel(filelist)
    dataname=filelist(k).name;
    if (contains(dataname,fileexpnum)&& ~contains(dataname,'corr'))%don't recorrect files if they are already there. WILL overwrite previously corrected files though
        corrfolder=strcat(dataname,'_corr');
        if startsWith(corrfolder,'._')
            corrfolder=corrfolder(3:end);
        end
        try
        ADP_Motion_Correction3(dataname,corrfolder)
        catch
            disp([corrfolder ' crashed for correction']);
        end
    end
end
    





