function [chosenfluor,chosenred,chosenROIs,chosentemps,chosenFrameRate,chosenIndex]=compare_tuning(headpath,savemode)

%give the headpath (genotype) go to the extracted folder
%bring up the different ROIs for each
%let the user select which ROI they want to use as the one to compare for
%THAT fly
%take the dff for those - and the image template and ROI circle and save to
%an array

%if the flag bilateral is on - select 2 different ROIs (IE Left and right
%side of the fan to compare directionality)



cd(headpath)
cd('extracted2')

filelist=dir('*.mat'); %get the list of file names


%save this in such a way that we know which experiments are included
%have 3 fields - the fluorescence and the image and the ROI
%should I include the other fluoresence parameters as well? maybe.
%for each list the 3 fields. Then have a tag for each exp.
%tuningdata={};
chosenfluor={};%and this is going to have 5 directions
chosenred={};
chosentemps={};
chosenROIs={};
chosenFrameRate={};
chosenIndex={};

%would be good if it could also save the index of the file too



for k=1:numel(filelist)%for each of the extracted files load the data.
    load(filelist(k).name);
    disp(filelist(k).name);
    fn=fieldnames(fluordata);%shouldn't matter which one I use since they're all the same size
    [numROIs,~]=size(fluordata.(fn{1}){1});
    
    loop=true;
    currROI=1;%begin with the first ROI
    %ind=1;%ind is the experiment that is being incremented when saved (won't necessarily match k)
    while(loop)%keep looping until you get the right keypress\
        %just use the average here because that's what you're going to use
        %to pick
        plotfluordirections_picker(avgfluor,redtemps,ROIs,Xpix,Ypix,FrameRate,currROI);
        x=input('press s to save this as the chosen ROI, n to go next, p to go to previous q for quit','s');
        
        if strcmp(x,'s')%SAVE
            name=split(filelist(k).name,'.');
            name=strcat('exp',name);
            % this is going to need to change how it's saved - now take all
            % 'one' is direction and {#} is the trial number
            try %could probably salvage this to just take 4 if there are only 4? should do that after
                
                %directions={'one','two','three','four','five'};
                %for q=1:numel(directions)
                %    trialnum=numel(fluordata.(directions{q}));
                %    for t=1:trialnum
                %might need to initialize first? maybe I should check
                %if the extraction is actually working properly first
                %before getting too far into this
                %        chosenfluor.(name{1}).(directions{q})=[chosenfluor.(name{1}).(directions{q});fluordata.(directions){q}{trialnum}(currROI,:)];
                %end
                chosenfluor.(name{1}).one=[fluordata.('one'){1}(currROI,:);fluordata.('one'){2}(currROI,:);fluordata.('one'){3}(currROI,:);fluordata.('one'){4}(currROI,:);fluordata.('one'){5}(currROI,:)];
                chosenfluor.(name{1}).two=[fluordata.('two'){1}(currROI,:);fluordata.('two'){2}(currROI,:);fluordata.('two'){3}(currROI,:);fluordata.('two'){4}(currROI,:);fluordata.('two'){5}(currROI,:)];
                chosenfluor.(name{1}).three=[fluordata.('three'){1}(currROI,:);fluordata.('three'){2}(currROI,:);fluordata.('three'){3}(currROI,:);fluordata.('three'){4}(currROI,:);fluordata.('three'){5}(currROI,:)];
                try
                    chosenfluor.(name{1}).four=[fluordata.('four'){1}(currROI,:);fluordata.('four'){2}(currROI,:);fluordata.('four'){3}(currROI,:);fluordata.('four'){4}(currROI,:);fluordata.('four'){5}(currROI,:)];
                catch
                    chosenfluor.(name{1}).four=[fluordata.('four'){1}(currROI,:);fluordata.('four'){2}(currROI,:);fluordata.('four'){3}(currROI,:);fluordata.('four'){4}(currROI,:)];
                end
                chosenfluor.(name{1}).five=[fluordata.('five'){1}(currROI,:);fluordata.('five'){2}(currROI,:);fluordata.('five'){3}(currROI,:);fluordata.('five'){4}(currROI,:);fluordata.('five'){5}(currROI,:)];
                chosenred.(name{1}).one=[fluordata_red.('one'){1}(currROI,:);fluordata_red.('one'){2}(currROI,:);fluordata_red.('one'){3}(currROI,:);fluordata_red.('one'){4}(currROI,:);fluordata_red.('one'){5}(currROI,:)];
                chosenred.(name{1}).two=[fluordata_red.('two'){1}(currROI,:);fluordata_red.('two'){2}(currROI,:);fluordata_red.('two'){3}(currROI,:);fluordata_red.('two'){4}(currROI,:);fluordata_red.('two'){5}(currROI,:)];
                chosenred.(name{1}).three=[fluordata_red.('three'){1}(currROI,:);fluordata_red.('three'){2}(currROI,:);fluordata_red.('three'){3}(currROI,:);fluordata_red.('three'){4}(currROI,:);fluordata_red.('three'){5}(currROI,:)];
                try
                    chosenred.(name{1}).four=[fluordata_red.('four'){1}(currROI,:);fluordata_red.('four'){2}(currROI,:);fluordata_red.('four'){3}(currROI,:);fluordata_red.('four'){4}(currROI,:);fluordata_red.('four'){5}(currROI,:)];
                catch
                    chosenred.(name{1}).four=[fluordata_red.('four'){1}(currROI,:);fluordata_red.('four'){2}(currROI,:);fluordata_red.('four'){3}(currROI,:);fluordata_red.('four'){4}(currROI,:)];
                    
                end
                chosenred.(name{1}).five=[fluordata_red.('five'){1}(currROI,:);fluordata_red.('five'){2}(currROI,:);fluordata_red.('five'){3}(currROI,:);fluordata_red.('five'){4}(currROI,:);fluordata_red.('five'){5}(currROI,:)];
            catch
                disp('no');
            end
            chosentemps.(name{1})=redtemps{1};
            chosenROIs.(name{1})=reshape(ROIs(:,currROI),[Ypix,Xpix]);
            chosenFrameRate.(name{1})=FrameRate;%need the framerate to take the mean, especially if they aren't exactly the same
            chosenIndex.(name{1})=currROI;%save the ROI so maybe later I can just do update instead of reloading all
            %ind=ind+1;
            loop=false;%also need to save the structure
            %save that here
        elseif strcmp(x,'n')%NEXT
            currROI=currROI+1;
            if currROI>numROIs
                currROI=1;%go back to the beginning for going over the top
            end
        elseif strcmp(x,'p')%Previous
            currROI=currROI-1;
            if currROI==0%gone backwards from 0
                currROI=numROIs;
            end
        elseif strcmp(x,'q')%skip this particular experiment
            loop=false;
        else
            disp('invalid input please select again');
        end
        close all; %reset the figures for the next ROI
    end
    %check if a tuning directory exists - if not make it - and save the
    %data there
    
    
    
end
if savemode
    cd(headpath)
    if ~exist('tuning2','dir')
        mkdir('tuning2');
    end
    cd ('tuning2');
    savefilename=input('enter the genotype name, then press enter','s');
    save(savefilename,'chosenfluor','chosenred','chosenROIs','chosentemps','chosenFrameRate','chosenIndex');
    cd(headpath);
end
end






