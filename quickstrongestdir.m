function dat=quickstrongestdir(headpath,fileexpnum)
%use this one when the data has been analyzed before and saved. 
cd('extracted2')
savefilename=strcat(fileexpnum,'_analysis2');
load(savefilename);
cd(headpath);
%0 for popvec,1 for maxvec
dat=plotstrongestdir_save(avgdiff,redtemps,ROIs,Xpix,Ypix,FrameRate,0);
end