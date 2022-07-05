function maxalignedvt062617
% allcols=[];
% 
% onemaxes=[];
% twomaxes=[];
% threemaxes=[];
% fourmaxes=[];
% fivemaxes=[];
% flymaxes=[];
% maxdirs=[];
% 
% cmap=parula(17);
% counter=1;
% figure; hold on;
% for k=1:numel(filelist)
%     dataname=filelist(k).name;
% 
%   
%     if contains(dataname,'_analysis2')
%         fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
%         
%         load(dataname);
%         columnmaxes=[];
%         columndata=[];
%         maxcols=[];
%         for jj=2:9
%             onemean=mean(avgfluor.one(jj,75:100));
%             twomean=mean(avgfluor.two(jj,75:100));
%             threemean=mean(avgfluor.three(jj,75:100));
%             fourmean=mean(avgfluor.four(jj,75:100));
%             fivemean=mean(avgfluor.five(jj,75:100));
%             %need to save what other data goes with the max one
%             [colmax,maxind]=max([onemean, twomean,threemean,fourmean,fivemean]);
%             maxcols(jj-1)=maxind;
%             if maxind==1
%                 columnmaxes(jj-1)=colmax;
%                 columndata(jj-1,:)=avgfluor.one(jj,:);
%             elseif maxind==2
%                 columnmaxes(jj-1)=colmax;
%                 columndata(jj-1,:)=avgfluor.two(jj,:);
%             elseif maxind==3
%                 columnmaxes(jj-1)=colmax;
%                 columndata(jj-1,:)=avgfluor.three(jj,:);
%             elseif maxind==4
%                 columnmaxes(jj-1)=colmax;
%                 columndata(jj-1,:)=avgfluor.four(jj,:);
%             else
%                 columnmaxes(jj-1)=colmax;
%                 columndata(jj-1,:)=avgfluor.five(jj,:);
%             end
%         end
%         directions=fieldnames(avgfluor);
%         %now figure out which column had the biggest response
%         [flymax,flyind]=max(columnmaxes);
%         flymaxes(k-2,:)=columndata(flyind,:);
%         maxdirs(k-2)=maxcols(flyind);
%         currmaxdir=maxcols(flyind);
%         subplot(1,9,5);
%         hold on; %plot the max in the middle
%         plot(avgfluor.(directions{currmaxdir})(flyind,:),'color',cmap(counter,:));
%         if currmaxdir==1
%             subplot(1,9,6);
%             hold on;
%             plot(avgfluor.two(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,7);
%             hold on;
%             plot(avgfluor.three(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,8);
%             hold on;
%             plot(avgfluor.four(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,9);
%             hold on;
%             plot(avgfluor.two(flyind,:),'color',cmap(counter,:));
%         end
%         if currmaxdir==2
%             subplot(1,9,4);
%             hold on;
%             plot(avgfluor.one(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,6);
%             hold on;
%             plot(avgfluor.three(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,7);
%             hold on;
%             plot(avgfluor.four(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,8);
%             hold on;
%             plot(avgfluor.five(flyind,:),'color',cmap(counter,:));
%         end
%         if currmaxdir==3
%             subplot(1,9,3);
%             hold on;
%             plot(avgfluor.one(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,4);
%             hold on;
%             plot(avgfluor.two(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,6);
%             hold on;
%             plot(avgfluor.four(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,7);
%             hold on;
%             plot(avgfluor.five(flyind,:),'color',cmap(counter,:));
%         end
%         if currmaxdir==4
%             subplot(1,9,2);
%             hold on;
%             plot(avgfluor.one(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,3);
%             hold on;
%             plot(avgfluor.two(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,4);
%             hold on;
%             plot(avgfluor.three(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,6);
%             hold on;
%             plot(avgfluor.five(flyind,:),'color',cmap(counter,:));
%         end
%         if currmaxdir==5
%             subplot(1,9,1);
%             hold on;
%             plot(avgfluor.one(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,2);
%             hold on;
%             plot(avgfluor.two(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,3);
%             hold on;
%             plot(avgfluor.three(flyind,:),'color',cmap(counter,:));
%             subplot(1,9,4);
%             hold on;
%             plot(avgfluor.four(flyind,:),'color',cmap(counter,:));
%         end
%         for qq=1:9
%             subplot(1,9,qq);
%             ylim([0.9, 1.3]);
%         end
% 
%         counter=counter+1;
% 
%         
%         
%     end
%     
% end
% 
% 
% 






%% 


allcols=[];

onemaxes=[];
twomaxes=[];
threemaxes=[];
fourmaxes=[];
fivemaxes=[];
flymaxes=[];
maxdirs=[];
filelist=dir;
%cmap=parula(17);
% cmap=[209,187,215; 
%     186,141,180;
%     170,111,158;
%     153,79,136;
%     136,46,114;
%     25,101,176;
%     82,137,199;
%     123, 175, 222;
%     78,178,101;
%     144,201,135;
%     202,224,171;
%     246, 193,65;
%     241, 147, 45;
%     232,96,28;
%     220,5,12;
%     165, 23,14;
%     114,25,14]/255;

% 
% cmap=[
%     221,216,239;
%     195,168,209;
%     167,120,180;
%     140,78,153;
%     96,89,169;
%     78,121,197;
%     78,150,188;
%     89,165,169;
%     105,177,144;
%     140,188,104;
%     190,188,72;
%     221,170,60;
%     231,140,53;
%     228,99,45;
%     218,34,34;
%     149,33,27;
%     82,26,19]/255;
%cmap=winter(17);

cmap=[245,243,193;
    234,240,181;
    221,236,191;
    208,231,202;
    194,227,210;
    168,216,220;
    141,203,228;
    123,188,231;
    126,178,228;
    136,165,221;
    147,152,210;
    155,138,196;
    157,125,178;
    144,99,136;
    128,87,112;
    104,73,87;
    70,53,58]/255;
counter=1;
figure; hold on;
for k=1:numel(filelist)
    dataname=filelist(k).name;

  
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        
        load(dataname);
        columnmaxes=[];
        columndata=[];
        maxcols=[];
        for jj=2:9
            onemean=mean(avgfluor.one(jj,75:100));
            twomean=mean(avgfluor.two(jj,75:100));
            threemean=mean(avgfluor.three(jj,75:100));
            fourmean=mean(avgfluor.four(jj,75:100));
            fivemean=mean(avgfluor.five(jj,75:100));
            %need to save what other data goes with the max one
            [colmax,maxind]=max([onemean,twomean,threemean,fourmean,fivemean]);
            maxcols(jj-1)=maxind;
            if maxind==1
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.one(jj,:);
            elseif maxind==2
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.two(jj,:);
            elseif maxind==3
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.three(jj,:);
            elseif maxind==4
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.four(jj,:);
            else
                columnmaxes(jj-1)=colmax;
                columndata(jj-1,:)=avgfluor.five(jj,:);
            end
        end
        directions=fieldnames(avgfluor);
        %now figure out which column had the biggest response
        [flymax,flyind]=max(columnmaxes);
        flymaxes(k-2,:)=columndata(flyind,:);
        maxdirs(k-2)=maxcols(flyind);
        currmaxdir=maxcols(flyind);
        flyind=flyind+1; %account for fact average is the first column
        subplot(4,9,5);
        hold on; %plot the max in the middle
        plot(avgfluor.(directions{currmaxdir})(flyind,70:100),'color',cmap(counter,:));
        subplot(4,9,5+9)
        hold on;
        plot(avgfluor.(directions{currmaxdir})(flyind,20:50),'color',cmap(counter,:));
        subplot(4,9,5+18)
        hold on;
        plot(avgfluor.(directions{currmaxdir})(flyind,120:150),'color',cmap(counter,:));
        subplot(4,9,5+27)
        hold on;
        plot(avgfluor.(directions{currmaxdir})(flyind,170:200),'color',cmap(counter,:));
        if currmaxdir==1
            subplot(4,9,6);
            hold on;
            plot(avgfluor.two(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,7);
            hold on;
            plot(avgfluor.three(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,8);
            hold on;
            plot(avgfluor.four(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,9);
            hold on;
            plot(avgfluor.two(flyind,70:100),'color',cmap(counter,:));

            subplot(4,9,6+9);
            hold on;
            plot(avgfluor.two(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,7+9);
            hold on;
            plot(avgfluor.three(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,8+9);
            hold on;
            plot(avgfluor.four(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,9+9);
            hold on;
            plot(avgfluor.two(flyind,20:50),'color',cmap(counter,:));

            subplot(4,9,6+18);
            hold on;
            plot(avgfluor.two(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,7+18);
            hold on;
            plot(avgfluor.three(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,8+18);
            hold on;
            plot(avgfluor.four(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,9+18);
            hold on;
            plot(avgfluor.two(flyind,120:150),'color',cmap(counter,:));

            subplot(4,9,6+27);
            hold on;
            plot(avgfluor.two(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,7+27);
            hold on;
            plot(avgfluor.three(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,8+27);
            hold on;
            plot(avgfluor.four(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,9+27);
            hold on;
            plot(avgfluor.two(flyind,170:200),'color',cmap(counter,:));
        end
        if currmaxdir==2
            subplot(4,9,4);
            hold on;
            plot(avgfluor.one(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,6);
            hold on;
            plot(avgfluor.three(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,7);
            hold on;
            plot(avgfluor.four(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,8);
            hold on;
            plot(avgfluor.five(flyind,70:100),'color',cmap(counter,:));

            subplot(4,9,4+9);
            hold on;
            plot(avgfluor.one(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,6+9);
            hold on;
            plot(avgfluor.three(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,7+9);
            hold on;
            plot(avgfluor.four(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,8+9);
            hold on;
            plot(avgfluor.five(flyind,20:150),'color',cmap(counter,:));

            subplot(4,9,4+18);
            hold on;
            plot(avgfluor.one(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,6+18);
            hold on;
            plot(avgfluor.three(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,7+18);
            hold on;
            plot(avgfluor.four(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,8+18);
            hold on;
            plot(avgfluor.five(flyind,120:150),'color',cmap(counter,:));

            subplot(4,9,4+27);
            hold on;
            plot(avgfluor.one(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,6+27);
            hold on;
            plot(avgfluor.three(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,7+27);
            hold on;
            plot(avgfluor.four(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,8+27);
            hold on;
            plot(avgfluor.five(flyind,170:200),'color',cmap(counter,:));


        end
        if currmaxdir==3
            subplot(4,9,3);
            hold on;
            plot(avgfluor.one(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,4);
            hold on;
            plot(avgfluor.two(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,6);
            hold on;
            plot(avgfluor.four(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,7);
            hold on;
            plot(avgfluor.five(flyind,70:100),'color',cmap(counter,:));

            subplot(4,9,3+9);
            hold on;
            plot(avgfluor.one(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,4+9);
            hold on;
            plot(avgfluor.two(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,6+9);
            hold on;
            plot(avgfluor.four(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,7+9);
            hold on;
            plot(avgfluor.five(flyind,20:50),'color',cmap(counter,:));

            subplot(4,9,3+18);
            hold on;
            plot(avgfluor.one(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,4+18);
            hold on;
            plot(avgfluor.two(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,6+18);
            hold on;
            plot(avgfluor.four(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,7+18);
            hold on;
            plot(avgfluor.five(flyind,120:150),'color',cmap(counter,:));

            subplot(4,9,3+27);
            hold on;
            plot(avgfluor.one(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,4+27);
            hold on;
            plot(avgfluor.two(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,6+27);
            hold on;
            plot(avgfluor.four(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,7+27);
            hold on;
            plot(avgfluor.five(flyind,170:200),'color',cmap(counter,:));



        end
        if currmaxdir==4
            subplot(4,9,2);
            hold on;
            plot(avgfluor.one(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,3);
            hold on;
            plot(avgfluor.two(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,4);
            hold on;
            plot(avgfluor.three(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,6);
            hold on;
            plot(avgfluor.five(flyind,70:100),'color',cmap(counter,:));

            subplot(4,9,2+9);
            hold on;
            plot(avgfluor.one(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,3+9);
            hold on;
            plot(avgfluor.two(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,4+9);
            hold on;
            plot(avgfluor.three(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,6+9);
            hold on;
            plot(avgfluor.five(flyind,20:50),'color',cmap(counter,:));


            subplot(4,9,2+18);
            hold on;
            plot(avgfluor.one(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,3+18);
            hold on;
            plot(avgfluor.two(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,4+18);
            hold on;
            plot(avgfluor.three(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,6+18);
            hold on;
            plot(avgfluor.five(flyind,120:150),'color',cmap(counter,:));

            subplot(4,9,2+27);
            hold on;
            plot(avgfluor.one(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,3+27);
            hold on;
            plot(avgfluor.two(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,4+27);
            hold on;
            plot(avgfluor.three(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,6+27);
            hold on;
            plot(avgfluor.five(flyind,170:200),'color',cmap(counter,:));

        end
        if currmaxdir==5
            subplot(4,9,1);
            hold on;
            plot(avgfluor.one(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,2);
            hold on;
            plot(avgfluor.two(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,3);
            hold on;
            plot(avgfluor.three(flyind,70:100),'color',cmap(counter,:));
            subplot(4,9,4);
            hold on;
            plot(avgfluor.four(flyind,70:100),'color',cmap(counter,:));

            subplot(4,9,1+9);
            hold on;
            plot(avgfluor.one(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,2+9);
            hold on;
            plot(avgfluor.two(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,3+9);
            hold on;
            plot(avgfluor.three(flyind,20:50),'color',cmap(counter,:));
            subplot(4,9,4+9);
            hold on;
            plot(avgfluor.four(flyind,20:50),'color',cmap(counter,:));

            subplot(4,9,1+18);
            hold on;
            plot(avgfluor.one(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,2+18);
            hold on;
            plot(avgfluor.two(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,3+18);
            hold on;
            plot(avgfluor.three(flyind,120:150),'color',cmap(counter,:));
            subplot(4,9,4+18);
            hold on;
            plot(avgfluor.four(flyind,120:150),'color',cmap(counter,:));

            subplot(4,9,1+27);
            hold on;
            plot(avgfluor.one(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,2+27);
            hold on;
            plot(avgfluor.two(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,3+27);
            hold on;
            plot(avgfluor.three(flyind,170:200),'color',cmap(counter,:));
            subplot(4,9,4+27);
            hold on;
            plot(avgfluor.four(flyind,170:200),'color',cmap(counter,:));

        end
        for qq=1:36
            subplot(4,9,qq);
            ylim([0.80, 1.45]);
        end

        counter=counter+1;

        
        
    end
    
end
end



