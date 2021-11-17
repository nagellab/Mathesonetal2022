function alldat=selectrespcolumns(headpath)

%start by using a manual picker
%eventually just change to something automatic

cd('extracted2');
filelist=dir;
alldat={};


for k=1:numel(filelist)
    dataname=filelist(k).name;
    %cd(headpath);
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);%load the individual fluordata
        for jj=1:size(fluordata.one{1},1) %for each ROI
            plotfluordirections_picker(avgfluor,redtemps,ROIs,Xpix,Ypix,FrameRate,jj);
            
            
            x=input('press s to save this as the chosen ROI, n to go next, p to go to previous q for quit','s');
            
            if strcmp(x,'s')%SAVE
                alldat.(fileexpnum)(jj)=1;
                close all;
                
            elseif strcmp(x,'n')%skip this particular experiment
                alldat.(fileexpnum)(jj)=0;
                close all;
            else
                disp('invalid input please select again');
            end
        end
        %close all
    else
        %otherwise load the previously held example
    end
    
    
end
end


