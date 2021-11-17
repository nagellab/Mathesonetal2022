function quickcheckfits(headpath,fileexpnum)

cd('extracted2')
savefilename=strcat(fileexpnum,'_analysis2');
load(savefilename);
cd(headpath);

%add some errorchecking for indices you want to remove or something
%[sortednames,data]=cleantrials(data,fileexpnum,filelist,imskip,expskip);

filelist=dir;
filenames={filelist(:).name};
matchedexpinds=contains(filenames,fileexpnum);
matchedexpnames=filenames(matchedexpinds);
correxpinds=contains(matchedexpnames,'corr');
correxpnames=matchedexpnames(correxpinds);


for k=1:numel(correxpnames)
    %should extract the data and put it in structs
    cd(correxpnames{k})
    %load whatever data is saved and has been extracted
    try
        %load('MC_VidROI.mat');
        load('MC_Parameters.mat');
        load('MC_Videocdf2.mat');
        CinGreen=Cin;
        %ROIs=reshape(Ain,FOV);
        load('MC_Video_Redcdf2.mat');%load in the red channel
        CinRed=Cin;
        figure;
        [numROIs,triallength]=size(CinGreen);
        facecolours=colormap(hsv(numROIs));
        imagesc(template_red);hold on;
        colormap('gray');
        
        for p=1:numROIs
            B=bwboundaries(reshape(full(Ain(:,p)),[Ypix,Xpix]));
            for n=1:length(B)
                boundary=B{n};
                plot(boundary(:,2),boundary(:,1),'w','Linewidth',2);
                %patch(boundary(:,2),boundary(:,1),facecolours(p,:),'FaceAlpha',0.2,'Edgealpha',0);
            end
        end
        daspect([1 1 1]);
        title(correxpnames{k});
        
    catch
        disp('fuck');
    end
    cd(headpath);
end
end

