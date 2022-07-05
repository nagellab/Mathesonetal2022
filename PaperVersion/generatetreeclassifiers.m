
%put this in the upload data/imagaging data folder
function[tables]=generatetreeclassifiers()
mode=0;
files=dir;
filenames={files.name};

for k=1:numel(filenames)

    currfile=filenames{k};
    if contains(currfile,'.mat')
        if contains(currfile,'._')
            currfile=currfile(3:end);
        end
        load(currfile);
        if (contains(currfile,'MB082C') || contains(currfile, 'MB077B') || contains(currfile,'12D12'))
            window1=[10 15];
            window2=[20 25];
            window3=[40 45];
        else
            window1=[5 10];
            window2=[15 20];
            window3=[35 40];
        end
        %load in chosenfluor etc
        if mode==0
            [~,genosidetablewind]=tabulateforclassifier(chosenfluor,chosenFrameRate,window1);
            [~,genosidetableodour]=tabulateforclassifier(chosenfluor,chosenFrameRate,window2);
            %[~,genosidetablewindoff]=tabulateforclassifier(chosenfluor,chosenFrameRate,window3);
            fieldname=strcat('d',currfile(1:end-4));
        else %when you want all 5 directions 
            [genosidetablewind,~]=tabulateforclassifier(chosenfluor,chosenFrameRate,[5 10]);
            [genosidetableodour,~]=tabulateforclassifier(chosenfluor,chosenFrameRate,[15 20]);
            [genosidetablewindoff,~]=tabulateforclassifier(chosenfluor,chosenFrameRate,[35 40]);
            fieldname=strcat('d',currfile(1:end-4));
        end
        %if contains(fieldname,'._')
        %    fieldname=fieldname(3:end);
        %end
        tables.(fieldname).wind=genosidetablewind;
        %tables.(fieldname).odour=genosidetableodour;
        %tables.(fieldname).windoff=genosidetablewindoff;
    end

end


end