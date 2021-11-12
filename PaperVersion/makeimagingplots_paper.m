function makeimagingplots_paper(headpath,tuningfilename,savemode,examples,fileexpnum)

%select a tuning file. Make the timecourses, tuning curves, and ROI
%figures. Save them. Also select examples for particular experiments or
%ROIs to look at averages

%examples is a flag if you want to run it
%fileexpnum is only relevant if you are. If you aren't doesn't matter -
%just ignore
close all; %make sure nothing else is open when you start 
load(tuningfilename);
tuningname=strsplit(tuningfilename,'.');

cd(headpath);

if savemode
    if ~exist('imagingfigures_extranew','dir')
        mkdir('imagingfigures_extranew');
    end
end


crossgenotuning(chosenfluor,chosenred,chosenROIs,chosentemps,chosenFrameRate); %this will generate 3 figures
if savemode
    cd('imagingfigures_extra');
    savefig(figure(1),['ROIplacement_',tuningname{1}]);
    print(figure(1),['ROIplacement_',tuningname{1}],'-dpdf','-painters');
    savefig(figure(2),['longtuningcurve_',tuningname{1}]);
    print(figure(2),['longtuningcurve_',tuningname{1}],'-dpdf','-painters');
    savefig(figure(3),['shorttuningcurve_',tuningname{1}]);
    print(figure(3),['shorttuningcurve_',tuningname{1}],'-dpdf','-painters');
    savefig(figure(4),['Difftuningcurve_',tuningname{1}]);
    print(figure(4),['Difftuningcurve_',tuningname{1}],'-dpdf','-painters');
    cd(headpath);
    %close all;
end
crossgenotimecourse(chosenfluor,chosenROIs,chosentemps,chosenFrameRate);
if savemode
    cd('imagingfigures_extra');
    savefig(figure(2),['crossflytimecourse_', tuningname{1}]);
    print(figure(2),['crossflytimecourse_', tuningname{1}],'-dpdf','-painters');
    cd(headpath);
end
%close all;

if examples
    alltrialstimecourse(headpath,fileexpnum,2,0,0,1)
    if savemode
        cd('imagingfigures_extra')
        savefig(figure(1),['exampletimecourse_',tuningname{1}, fileexpnum]);
        print(figure(1),['exampletimecourse_',tuningname{1}, fileexpnum],'-dpdf','-painters');
        %do I want the other ones
    end
end
%close all;
cd(headpath);
        
        
end
    

    
    


