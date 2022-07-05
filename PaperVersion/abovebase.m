function [genowindwindows, genoodourwindows] = abovebase(numstds)

files=dir;
filenames={files.name};
genowindows={};
genoodourwindows={};
for k=1:numel(filenames)%k is for files jj is for experiments

    currfile=filenames{k};
    if contains(currfile,'.mat')
        if contains(currfile,'._')
            currfile=currfile(3:end);
        end
        load(currfile);

        %if nothing gets loaded end the loop
        %calculate the % of odour above baseline
        if (contains(currfile,'MB082C') || contains(currfile, 'MB077B')  || contains(currfile,'12D12'))
            %window1=[0.5 5]; %for baseline
            window1=[10 20];
            window2=[20 30];
        else
            %window1=[0.5 5]; %for baseline %something is wrong here
            window1=[5 15];
            window2=[15 25];
        end



        data=chosenfluor;
        Fr=chosenFrameRate;
        fn=fieldnames(data);
        %do I need to figure this out on a fly by fly basis? probably not
        %but I will need to take the mean of means


        %figure out which period to look at
        %lets just do it on a fly by fly basis honestly that is easier?
        windwindows=[];
        odourwindows=[];
        for jj=1:numel(fn)
            fly=chosenfluor.(fn{jj});
            basesamp1=1;
            basesamp2=5*Fr.(fn{jj});
            odoursamp1=window2(1)*Fr.(fn{jj});
            odoursamp2=window2(2)*Fr.(fn{jj});
            curroneodour=fly.one(:,odoursamp1:odoursamp2);
            currtwoodour=fly.two(:,odoursamp1:odoursamp2);
            currthreeodour=fly.three(:,odoursamp1:odoursamp2);
            currfourodour=fly.four(:,odoursamp1:odoursamp2);
            currfiveodour=fly.five(:,odoursamp1:odoursamp2);

            curronebase=fly.one(:,basesamp1:basesamp2);
            currtwobase=fly.two(:,basesamp1:basesamp2);
            currthreebase=fly.three(:,basesamp1:basesamp2);
            currfourbase=fly.four(:,basesamp1:basesamp2);
            currfivebase=fly.five(:,basesamp1:basesamp2);

            averageodourresp=mean([mean(curroneodour',2),mean(currtwoodour',2),mean(currthreeodour',2),mean(currfourodour',2),mean(currfiveodour',2)],2);
            averagebaseresp=mean([mean(curronebase',2),mean(currtwobase',2),mean(currthreebase',2),mean(currfourbase',2),mean(currfivebase',2)],2);
            windowthresh=mean(averagebaseresp)+numstds*std(averagebaseresp);

            [inds,~]=find(averageodourresp>windowthresh);
            diffinds=diff(inds);
            %calculate the differences
            [jumpinds,~]=find(diffinds>1);%any where they change more than one sample
            if isempty(jumpinds)
                if isempty(inds)
                    %then this is a trial where none is above baseline
                    falling=5*Fr.(fn{jj});
                else
                    %then this is a trial where it decreases 1 below
                    %threshold and then stops - should be the number of
                    %elements I believe
                    falling=numel(inds);
                end
            else
                try
                    falling = jumpinds(1); %first time it dips below
                catch
                    disp('still a problem');
                end
            end

            odourwindow=[odoursamp1 odoursamp1+falling];
            windwindow=[window1(1)*Fr.(fn{jj}) window1(1)*Fr.(fn{jj})+falling];
            windwindows(jj,:)=windwindow;
            odourwindows(jj,:)=odourwindow;
        end
        geno=strcat('d',currfile(1:end-4));
        genowindwindows.(geno)=windwindows;
        genoodourwindows.(geno)=odourwindows;
    end

end




end