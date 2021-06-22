function[fluordata,fluordata_red,fluordata_diff,ROIs,redtemps]= pooldirections(headpath,fileexpnum,imskip,expskip,deltamode,FrameRate)
% point towards wherever the experiment data for matlab
%control is and then pool across experiments for all ROIs
%then will be able to average across individual ROIs for multiple trials of
%the same type and compare across directions

%make structs

onedata={};
twodata={};
threedata={};
fourdata={};
fivedata={};

onedata_red={};
twodata_red={};
threedata_red={};
fourdata_red={};
fivedata_red={};

onedata_diff={};
twodata_diff={};
threedata_diff={};
fourdata_diff={};
fivedata_diff={};
redtemps={};
 

cd(headpath);
filelist=dir;

disp('select the mat file from the experiment from this computers C drive');
[matexpfile,matexppath]=uigetfile('*.*');
cd(matexppath);
load(matexpfile);%load the file (data) into the workspace
%would be good to display the date the imaging was recorded on so this
%isn't so complicated
%need to choose the WCwaveform
cd(headpath)

%add some errorchecking for indices you want to remove or something
[sortednames,data]=cleantrials(data,fileexpnum,filelist,imskip,expskip);

ind=1;
for k=1:numel(sortednames)
    %should extract the data and put it in structs
    cd(sortednames{k})
    %load whatever data is saved and has been extracted
    try
        %load('MC_VidROI.mat');
        load('MC_Parameters.mat');
        load('MC_Videocdf2.mat');
        CinGreen=Cin;
        ROIs=Ain;
        load('MC_Video_Redcdf2.mat');%load in the red channel 
        CinRed=Cin;
        
        redtemps{k}=template_red;
        if deltamode
            [CinGreen,CinRed]=takeDelta(CinGreen,CinRed,FrameRate);
            Cdiff=CinGreen-CinRed;
        end
        
        
        
    catch
        disp('error in pooldirections 1');
    end
    cd(headpath);
    try
        switch data(ind).winddir %pull the wind direction and add to specific vector
            case 1
                onedata=[onedata,CinGreen];
                onedata_red=[onedata_red,CinRed];
                if deltamode
                    onedata_diff=[onedata_diff,Cdiff];
                end
                    
            case 2
                twodata=[twodata,CinGreen];
                twodata_red=[twodata_red,CinRed];
                 if deltamode
                    twodata_diff=[twodata_diff,Cdiff];
                end
            case 3
                threedata=[threedata,CinGreen];
                threedata_red=[threedata_red,CinRed];
                 if deltamode
                    threedata_diff=[threedata_diff,Cdiff];
                end
            case 4
                fourdata=[fourdata,CinGreen];
                fourdata_red=[fourdata_red,CinRed];
                 if deltamode
                    fourdata_diff=[fourdata_diff,Cdiff];
                end
            case 5
                fivedata=[fivedata,CinGreen];
                fivedata_red=[fivedata_red,CinRed];
                 if deltamode
                    fivedata_diff=[fivedata_diff,Cdiff];
                end
            otherwise
                disp('error in pool directions 2');
        end
    catch
        disp('error in pool directions 3') 
    end
    ind=ind+1;
    
end

fluordata.one=onedata;
fluordata.two=twodata;
fluordata.three=threedata;
fluordata.four=fourdata;
fluordata.five=fivedata;

fluordata_red.one=onedata_red;
fluordata_red.two=twodata_red;
fluordata_red.three=threedata_red;
fluordata_red.four=fourdata_red;
fluordata_red.five=fivedata_red;

fluordata_diff.one=onedata_diff;
fluordata_diff.two=twodata_diff;
fluordata_diff.three=threedata_diff;
fluordata_diff.four=fourdata_diff;
fluordata_diff.five=fivedata_diff;

ROIs=Ain;

end