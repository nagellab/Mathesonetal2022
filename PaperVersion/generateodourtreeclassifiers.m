
%put this in the upload data/imagaging data folder
function[tables]=generateodourtreeclassifiers()

files=dir;
filenames={files.name};

for k=1:numel(filenames)

    currfile=filenames{k};
    if contains(currfile,'.mat')
        if contains(currfile,'._')
            currfile=currfile(3:end);
        end
        load(currfile);
        %load in chosenfluor etc

        %if genotype from old thor

        %if genotype from new thor
        if (contains(currfile,'MB082C') || contains(currfile, 'MB077B')  || contains(currfile,'12D12'))
            %window1=[0.5 5]; %for baseline
            window1=[10 20];
            window2=[20 30];
        else
            %window1=[0.5 5]; %for baseline
            window1=[5 15];
            window2=[15 25];
        end
        fn=fieldnames(chosenfluor);
        [genotableodour]=tabulateforodourclassifier(chosenfluor,chosenFrameRate,window1,window2);
        fieldname=strcat('d',currfile(1:end-4));
        %if contains(fieldname,'._')
        %    fieldname=fieldname(3:end);
        %end
        tables.(fieldname)=genotableodour;

    end

end


end