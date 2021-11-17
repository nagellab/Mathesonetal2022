function checkfits(headpath,fileexpnum,imskip,expskip)

cd(headpath);
filelist=dir;
[Xpix,Ypix,FrameRate]=findkeyparams();
disp('select the mat file from the experiment from this computers C drive');
[matexpfile,matexppath]=uigetfile('*.*');
cd(matexppath);
load(matexpfile);
cd(headpath)

%add some errorchecking for indices you want to remove or something
[sortednames,data]=cleantrials(data,fileexpnum,filelist,imskip,expskip);


for k=1:numel(sortednames)
    %should extract the data and put it in structs
    cd(sortednames{k})
    %load whatever data is saved and has been extracted
    try
        %load('MC_VidROI.mat');
        load('MC_Parameters.mat');
        load('MC_Videocdf.mat');
        CinGreen=Cin;
        %ROIs=reshape(Ain,FOV);
        load('MC_Video_Redcdf.mat');%load in the red channel
        CinRed=Cin;
        figure;
        imagesc(template_red);hold on;
        [numROIs,triallength]=size(CinGreen);
        for p=1:numROIs
            B=bwboundaries(reshape(full(Ain(:,p)),FOV));
            for n=1:length(B)
                boundary=B{n};
                plot(boundary(:,2),boundary(:,1),'w','Linewidth',2);
            end
        end
        
    catch
        disp('fuck');
    end
    cd(headpath);
end
end

