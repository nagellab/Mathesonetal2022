function quickCalciumExperiment(headpath,fileexpnum)
%use this one when the data has been analyzed before and saved. 

%going to have to build something in to use set 1 or set2
cd('extracted2')
savefilename=strcat(fileexpnum,'_analysis2');
load(savefilename);
cd(headpath);
plotfluordirections(avgdiff,redtemps,ROIs,Xpix,Ypix,FrameRate);
end