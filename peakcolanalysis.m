function [curve]=peakcolanalysis


filelist=dir;

allmaxes=[];
allbases=[];
allstds=[];
factor=5;
f=figure; hold on;
counter=0;
for k=1:numel(filelist)% for each fly
    dataname=filelist(k).name;
    
    if contains(dataname,'_analysis2')
        
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);
        if size(avgfluor.one,1)==8
            cols=1:8;
        else
            cols=2:9;% some only have 8
        end
        try
            
            onebase=nanmean(avgfluor.one(cols,3:25),2);
            twobase=nanmean(avgfluor.two(cols,3:25),2);
            threebase=nanmean(avgfluor.three(cols,3:25),2);
            fourbase=nanmean(avgfluor.four(cols,3:25),2);
            fivebase=nanmean(avgfluor.five(cols,3:25),2);
            allbases=[onebase,twobase,threebase,fourbase,fivebase];
            
            onestd=nanstd(avgfluor.one(cols,3:25)')';
            twostd=nanstd(avgfluor.two(cols,3:25)')';
            threestd=nanstd(avgfluor.three(cols,3:25)')';
            fourstd=nanstd(avgfluor.four(cols,3:25)')';
            fivestd=nanstd(avgfluor.five(cols,3:25)')';
            allstds=[onestd,twostd,threestd,fourstd,fivestd];
            
            
            onemean=nanmean(avgfluor.one(cols,75:100),2);
            twomean=nanmean(avgfluor.two(cols,75:100),2);
            threemean=nanmean(avgfluor.three(cols,75:100),2);
            fourmean=nanmean(avgfluor.four(cols,75:100),2);
            fivemean=nanmean(avgfluor.five(cols,75:100),2);
            allmeans=[onemean,twomean,threemean,fourmean,fivemean];
            
            [overallmax,overallmaxind]=max([max(onemean),max(twomean),max(threemean),max(fourmean),max(fivemean)]);
            %normalize
            %find the max direction
            flymax=allmeans(:,overallmaxind);
            flystd=allstds(:,overallmaxind);
            flybase=allbases(:,overallmaxind);
            for yy=numel(flymax)
                if flymax(yy)<(factor*flystd(yy)+flybase(yy))
                    %flymax(yy)=NaN;
                end
            end
            %subtract the min
            %flymax=flymax-min(flymax);
            %flymax=flymax-flybase;
            flymax=flymax/max(flymax);
        catch
            disp('no');
        end
        
        %circshift flymax so the peak is at 4
        
        [~,maxi]=max(flymax);
        
        flymax=circshift(flymax,4-maxi);
        
        
        
        
        hold on; plot(cols-1,flymax);
        %w = waitforbuttonpress
        xx=input('press s to save this as the chosen ROI, n to go next, p to go to previous q for quit','s');
        if strcmp(xx,'s')
            counter=counter+1;
            allmaxes(counter,:)=flymax;
            
        end
        figure(f);
        
        %find the column with the max response
        
    end
end
plot(cols-1,mean(allmaxes),'k','linewidth',2);


figure; hold on; imagesc(allmaxes)
colormap(gray)
plot(cols-1,sum(allmaxes),'g','linewidth',2);

curve=nanmean(allmaxes);
end