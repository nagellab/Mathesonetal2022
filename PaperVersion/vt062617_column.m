



colours=[[186/225,141/255,180/255];[25/255,101/255,176/255];[78/255,178/255,101/255];[247/255,203/255,69/255];[220/255,5/255,12/255]];
%get data for every column
%save is as direction?

filelist=dir;

col1=[];
col2=[];
col3=[];
col4=[];
col5=[];
col6=[];
col7=[];
col8=[];
counter=1;

for k=1:numel(filelist)
    dataname=filelist(k).name;

    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);

        load(dataname);

        cols=2:9;
        onetc=avgfluor.one(cols,:);
        twotc=avgfluor.two(cols,:);
        threetc=avgfluor.three(cols,:);
        fourtc=avgfluor.four(cols,:);
        fivetc=avgfluor.five(cols,:);

        col1.one(counter,:)=onetc(1,:);
        col1.two(counter,:)=twotc(1,:);
        col1.three(counter,:)=threetc(1,:);
        col1.four(counter,:)=fourtc(1,:);
        col1.five(counter,:)=fivetc(1,:);

        col2.one(counter,:)=onetc(2,:);
        col2.two(counter,:)=twotc(2,:);
        col2.three(counter,:)=threetc(2,:);
        col2.four(counter,:)=fourtc(2,:);
        col2.five(counter,:)=fivetc(2,:);


        col3.one(counter,:)=onetc(3,:);
        col3.two(counter,:)=twotc(3,:);
        col3.three(counter,:)=threetc(3,:);
        col3.four(counter,:)=fourtc(3,:);
        col3.five(counter,:)=fivetc(3,:);


        col4.one(counter,:)=onetc(4,:);
        col4.two(counter,:)=twotc(4,:);
        col4.three(counter,:)=threetc(4,:);
        col4.four(counter,:)=fourtc(4,:);
        col4.five(counter,:)=fivetc(4,:);


        col5.one(counter,:)=onetc(5,:);
        col5.two(counter,:)=twotc(5,:);
        col5.three(counter,:)=threetc(5,:);
        col5.four(counter,:)=fourtc(5,:);
        col5.five(counter,:)=fivetc(5,:);


        col6.one(counter,:)=onetc(6,:);
        col6.two(counter,:)=twotc(6,:);
        col6.three(counter,:)=threetc(6,:);
        col6.four(counter,:)=fourtc(6,:);
        col6.five(counter,:)=fivetc(6,:);


        col7.one(counter,:)=onetc(7,:);
        col7.two(counter,:)=twotc(7,:);
        col7.three(counter,:)=threetc(7,:);
        col7.four(counter,:)=fourtc(7,:);
        col7.five(counter,:)=fivetc(7,:);


        col8.one(counter,:)=onetc(8,:);
        col8.two(counter,:)=twotc(8,:);
        col8.three(counter,:)=threetc(8,:);
        col8.four(counter,:)=fourtc(8,:);
        col8.five(counter,:)=fivetc(8,:);
        
        counter=counter+1;
    end
end


%find the column directions that are >2stds above 
directions=fieldnames(col1);
tvec=linspace(1,236,236)/5;
fugh=figure; hold on;
for k=1:5

    base1=mean(col1.(directions{k})(:,3:25),2);
    base2=mean(col2.(directions{k})(:,3:25),2);
    base3=mean(col3.(directions{k})(:,3:25),2);
    base4=mean(col4.(directions{k})(:,3:25),2);
    base5=mean(col5.(directions{k})(:,3:25),2);
    base6=mean(col6.(directions{k})(:,3:25),2);
    base7=mean(col7.(directions{k})(:,3:25),2);
    base8=mean(col8.(directions{k})(:,3:25),2);

    base1std=std(col1.(directions{k})(:,3:25)')';
    base2std=std(col2.(directions{k})(:,3:25)')';
    base3std=std(col3.(directions{k})(:,3:25)')';
    base4std=std(col4.(directions{k})(:,3:25)')';
    base5std=std(col5.(directions{k})(:,3:25)')';
    base6std=std(col6.(directions{k})(:,3:25)')';
    base7std=std(col7.(directions{k})(:,3:25)')';
    base8std=std(col8.(directions{k})(:,3:25)')';

    wind1=mean(col1.(directions{k})(:,25:50),2);
    wind2=mean(col2.(directions{k})(:,25:50),2);
    wind3=mean(col3.(directions{k})(:,25:50),2);
    wind4=mean(col4.(directions{k})(:,25:50),2);
    wind5=mean(col5.(directions{k})(:,25:50),2);
    wind6=mean(col6.(directions{k})(:,25:50),2);
    wind7=mean(col7.(directions{k})(:,25:50),2);
    wind8=mean(col8.(directions{k})(:,25:50),2);

    odour1=mean(col1.(directions{k})(:,75:100),2);
    odour2=mean(col2.(directions{k})(:,75:100),2);
    odour3=mean(col3.(directions{k})(:,75:100),2);
    odour4=mean(col4.(directions{k})(:,75:100),2);
    odour5=mean(col5.(directions{k})(:,75:100),2);
    odour6=mean(col6.(directions{k})(:,75:100),2);
    odour7=mean(col7.(directions{k})(:,75:100),2);
    odour8=mean(col8.(directions{k})(:,75:100),2);

    odouroff1=mean(col1.(directions{k})(:,125:150),2);
    odouroff2=mean(col2.(directions{k})(:,125:150),2);
    odouroff3=mean(col3.(directions{k})(:,125:150),2);
    odouroff4=mean(col4.(directions{k})(:,125:150),2);
    odouroff5=mean(col5.(directions{k})(:,125:150),2);
    odouroff6=mean(col6.(directions{k})(:,125:150),2);
    odouroff7=mean(col7.(directions{k})(:,125:150),2);
    odouroff8=mean(col8.(directions{k})(:,125:150),2);

    windoff1=mean(col1.(directions{k})(:,175:200),2);
    windoff2=mean(col2.(directions{k})(:,175:200),2);
    windoff3=mean(col3.(directions{k})(:,175:200),2);
    windoff4=mean(col4.(directions{k})(:,175:200),2);
    windoff5=mean(col5.(directions{k})(:,175:200),2);
    windoff6=mean(col6.(directions{k})(:,175:200),2);
    windoff7=mean(col7.(directions{k})(:,175:200),2);
    windoff8=mean(col8.(directions{k})(:,175:200),2);


    %does a column show a response 

    factor=2;
    %this isn't going to work like this - going to have to do a find 
    windinds=find(wind1>(factor*base1std)+base1);
    odourinds=find(odour1>(factor*base1std)+base1);
    odouroffinds=find(odouroff1>(factor*base1std)+base1);
    windoffinds=find(windoff1>(factor*base1std)+base1);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,1);
        plot((tvec(70:100)),(col1.(directions{k})(allinds,70:100)),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    windinds=find(wind2>(factor*base2std)+base2);
    odourinds=find(odour2>(factor*base2std)+base2);
    odouroffinds=find(odouroff2>(factor*base2std)+base2);
    windoffinds=find(windoff2>(factor*base2std)+base2);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,2);
        plot((tvec(70:100)),(col2.(directions{k})(allinds,70:100)),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    windinds=find(wind3>(factor*base3std)+base3);
    odourinds=find(odour3>(factor*base3std)+base3);
    odouroffinds=find(odouroff3>(factor*base3std)+base3);
    windoffinds=find(windoff3>(factor*base3std)+base3);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,3);
        plot((tvec(70:100)),col3.(directions{k})(allinds,70:100),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    windinds=find(wind4>(factor*base4std)+base4);
    odourinds=find(odour4>(factor*base4std)+base4);
    odouroffinds=find(odouroff4>(factor*base4std)+base4);
    windoffinds=find(windoff4>(factor*base4std)+base4);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,4);
        plot((tvec(70:100)),col4.(directions{k})(allinds,70:100),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    windinds=find(wind5>(factor*base5std)+base5);
    odourinds=find(odour5>(factor*base5std)+base5);
    odouroffinds=find(odouroff5>(factor*base5std)+base5);
    windoffinds=find(windoff5>(factor*base5std)+base5);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,5);
        plot((tvec(70:100)),col5.(directions{k})(allinds,70:100),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    windinds=find(wind6>(factor*base6std)+base6);
    odourinds=find(odour6>(factor*base6std)+base6);
    odouroffinds=find(odouroff6>(factor*base6std)+base6);
    windoffinds=find(windoff6>(factor*base6std)+base6);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,6);
        plot((tvec(70:100)),col6.(directions{k})(allinds,70:100),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    windinds=find(wind7>(factor*base7std)+base7);
    odourinds=find(odour7>(factor*base7std)+base7);
    odouroffinds=find(odouroff7>(factor*base7std)+base7);
    windoffinds=find(windoff7>(factor*base7std)+base7);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,7);
        plot((tvec(70:100)),col7.(directions{k})(allinds,70:100),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    windinds=find(wind8>(factor*base8std)+base8);
    odourinds=find(odour8>(factor*base8std)+base8);
    odouroffinds=find(odouroff8>(factor*base8std)+base8);
    windoffinds=find(windoff8>(factor*base8std)+base8);
    allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);

    if ~isempty(allinds)
        figure(fugh);
        hold on;
        subplot(1,8,8);
        plot((tvec(70:100)),col8.(directions{k})(allinds,70:100),'color',colours(k,:));
        ylim([0.9 1.5]);
    end

    

 
end






% filelist=dir;
% 
% col1=[];
% col2=[];
% col3=[];
% col4=[];
% col5=[];
% col6=[];
% col7=[];
% col8=[];
% counter=1;
% 
% for k=1:numel(filelist)
%     dataname=filelist(k).name;
% 
%     if contains(dataname,'_analysis2')
%         fileexpnum=dataname(1:end-14);
% 
%         load(dataname);
% 
%         cols=2:9;
%         onetc=avgfluor.one(cols,:);
%         twotc=avgfluor.two(cols,:);
%         threetc=avgfluor.three(cols,:);
%         fourtc=avgfluor.four(cols,:);
%         fivetc=avgfluor.five(cols,:);
% 
%         col1.one(counter,:)=onetc(1,:);
%         col1.two(counter,:)=twotc(1,:);
%         col1.three(counter,:)=threetc(1,:);
%         col1.four(counter,:)=fourtc(1,:);
%         col1.five(counter,:)=fivetc(1,:);
% 
%         col2.one(counter,:)=onetc(2,:);
%         col2.two(counter,:)=twotc(2,:);
%         col2.three(counter,:)=threetc(2,:);
%         col2.four(counter,:)=fourtc(2,:);
%         col2.five(counter,:)=fivetc(2,:);
% 
% 
%         col3.one(counter,:)=onetc(3,:);
%         col3.two(counter,:)=twotc(3,:);
%         col3.three(counter,:)=threetc(3,:);
%         col3.four(counter,:)=fourtc(3,:);
%         col3.five(counter,:)=fivetc(3,:);
% 
% 
%         col4.one(counter,:)=onetc(4,:);
%         col4.two(counter,:)=twotc(4,:);
%         col4.three(counter,:)=threetc(4,:);
%         col4.four(counter,:)=fourtc(4,:);
%         col4.five(counter,:)=fivetc(4,:);
% 
% 
%         col5.one(counter,:)=onetc(5,:);
%         col5.two(counter,:)=twotc(5,:);
%         col5.three(counter,:)=threetc(5,:);
%         col5.four(counter,:)=fourtc(5,:);
%         col5.five(counter,:)=fivetc(5,:);
% 
% 
%         col6.one(counter,:)=onetc(6,:);
%         col6.two(counter,:)=twotc(6,:);
%         col6.three(counter,:)=threetc(6,:);
%         col6.four(counter,:)=fourtc(6,:);
%         col6.five(counter,:)=fivetc(6,:);
% 
% 
%         col7.one(counter,:)=onetc(7,:);
%         col7.two(counter,:)=twotc(7,:);
%         col7.three(counter,:)=threetc(7,:);
%         col7.four(counter,:)=fourtc(7,:);
%         col7.five(counter,:)=fivetc(7,:);
% 
% 
%         col8.one(counter,:)=onetc(8,:);
%         col8.two(counter,:)=twotc(8,:);
%         col8.three(counter,:)=threetc(8,:);
%         col8.four(counter,:)=fourtc(8,:);
%         col8.five(counter,:)=fivetc(8,:);
%         
%         counter=counter+1;
%     end
% end
% 
% 
% %find the column directions that are >2stds above 
% directions=fieldnames(col1);
% tvec=linspace(1,236,236)/5;
% fugh=figure; hold on;
% for k=1:5
% 
%     base1=mean(col1.(directions{k})(:,3:25),2);
%     base2=mean(col2.(directions{k})(:,3:25),2);
%     base3=mean(col3.(directions{k})(:,3:25),2);
%     base4=mean(col4.(directions{k})(:,3:25),2);
%     base5=mean(col5.(directions{k})(:,3:25),2);
%     base6=mean(col6.(directions{k})(:,3:25),2);
%     base7=mean(col7.(directions{k})(:,3:25),2);
%     base8=mean(col8.(directions{k})(:,3:25),2);
% 
%     base1std=std(col1.(directions{k})(:,3:25)')';
%     base2std=std(col2.(directions{k})(:,3:25)')';
%     base3std=std(col3.(directions{k})(:,3:25)')';
%     base4std=std(col4.(directions{k})(:,3:25)')';
%     base5std=std(col5.(directions{k})(:,3:25)')';
%     base6std=std(col6.(directions{k})(:,3:25)')';
%     base7std=std(col7.(directions{k})(:,3:25)')';
%     base8std=std(col8.(directions{k})(:,3:25)')';
% 
%     wind1=mean(col1.(directions{k})(:,25:50),2);
%     wind2=mean(col2.(directions{k})(:,25:50),2);
%     wind3=mean(col3.(directions{k})(:,25:50),2);
%     wind4=mean(col4.(directions{k})(:,25:50),2);
%     wind5=mean(col5.(directions{k})(:,25:50),2);
%     wind6=mean(col6.(directions{k})(:,25:50),2);
%     wind7=mean(col7.(directions{k})(:,25:50),2);
%     wind8=mean(col8.(directions{k})(:,25:50),2);
% 
%     odour1=mean(col1.(directions{k})(:,75:100),2);
%     odour2=mean(col2.(directions{k})(:,75:100),2);
%     odour3=mean(col3.(directions{k})(:,75:100),2);
%     odour4=mean(col4.(directions{k})(:,75:100),2);
%     odour5=mean(col5.(directions{k})(:,75:100),2);
%     odour6=mean(col6.(directions{k})(:,75:100),2);
%     odour7=mean(col7.(directions{k})(:,75:100),2);
%     odour8=mean(col8.(directions{k})(:,75:100),2);
% 
%     odouroff1=mean(col1.(directions{k})(:,125:150),2);
%     odouroff2=mean(col2.(directions{k})(:,125:150),2);
%     odouroff3=mean(col3.(directions{k})(:,125:150),2);
%     odouroff4=mean(col4.(directions{k})(:,125:150),2);
%     odouroff5=mean(col5.(directions{k})(:,125:150),2);
%     odouroff6=mean(col6.(directions{k})(:,125:150),2);
%     odouroff7=mean(col7.(directions{k})(:,125:150),2);
%     odouroff8=mean(col8.(directions{k})(:,125:150),2);
% 
%     windoff1=mean(col1.(directions{k})(:,175:200),2);
%     windoff2=mean(col2.(directions{k})(:,175:200),2);
%     windoff3=mean(col3.(directions{k})(:,175:200),2);
%     windoff4=mean(col4.(directions{k})(:,175:200),2);
%     windoff5=mean(col5.(directions{k})(:,175:200),2);
%     windoff6=mean(col6.(directions{k})(:,175:200),2);
%     windoff7=mean(col7.(directions{k})(:,175:200),2);
%     windoff8=mean(col8.(directions{k})(:,175:200),2);
% 
% 
%     %does a column show a response 
% 
%     factor=2;
%     %this isn't going to work like this - going to have to do a find 
%     windinds=find(wind1>(factor*base1std)+base1);
%     odourinds=find(odour1>(factor*base1std)+base1);
%     odouroffinds=find(odouroff1>(factor*base1std)+base1);
%     windoffinds=find(windoff1>(factor*base1std)+base1);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         %figure(fugh);
%         %hold on;
%         %subplot(1,8,1);
%         %plot((tvec),(col1.(directions{k})(allinds,:)),'color',colours(k));
%         %ylim([0.9 1.5]);
%     end
% 
%     windinds=find(wind2>(factor*base2std)+base2);
%     odourinds=find(odour2>(factor*base2std)+base2);
%     odouroffinds=find(odouroff2>(factor*base2std)+base2);
%     windoffinds=find(windoff2>(factor*base2std)+base2);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         figure(fugh);
%         hold on;
%         subplot(1,8,2);
%         plot((tvec),(col2.(directions{k})(allinds,70:100)),'color',colours(k));
%         ylim([0.9 1.5]);
%     end
% 
%     windinds=find(wind3>(factor*base3std)+base3);
%     odourinds=find(odour3>(factor*base3std)+base3);
%     odouroffinds=find(odouroff3>(factor*base3std)+base3);
%     windoffinds=find(windoff3>(factor*base3std)+base3);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         figure(fugh);
%         hold on;
%         subplot(1,8,3);
%         plot(tvec,col3.(directions{k})(allinds,70:100),'color',colours(k));
%         ylim([0.9 1.5]);
%     end
% 
%     windinds=find(wind4>(factor*base4std)+base4);
%     odourinds=find(odour4>(factor*base4std)+base4);
%     odouroffinds=find(odouroff4>(factor*base4std)+base4);
%     windoffinds=find(windoff4>(factor*base4std)+base4);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         figure(fugh);
%         hold on;
%         subplot(1,8,4);
%         plot(tvec,col4.(directions{k})(allinds,70:100),'color',colours(k));
%         ylim([0.9 1.5]);
%     end
% 
%     windinds=find(wind5>(factor*base5std)+base5);
%     odourinds=find(odour5>(factor*base5std)+base5);
%     odouroffinds=find(odouroff5>(factor*base5std)+base5);
%     windoffinds=find(windoff5>(factor*base5std)+base5);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         figure(fugh);
%         hold on;
%         subplot(1,8,5);
%         plot(tvec,col5.(directions{k})(allinds,70:100),'color',colours(k));
%         ylim([0.9 1.5]);
%     end
% 
%     windinds=find(wind6>(factor*base6std)+base6);
%     odourinds=find(odour6>(factor*base6std)+base6);
%     odouroffinds=find(odouroff6>(factor*base6std)+base6);
%     windoffinds=find(windoff6>(factor*base6std)+base6);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         figure(fugh);
%         hold on;
%         subplot(1,8,6);
%         plot(tvec,col6.(directions{k})(allinds,70:100),'color',colours(k));
%         ylim([0.9 1.5]);
%     end
% 
%     windinds=find(wind7>(factor*base7std)+base7);
%     odourinds=find(odour7>(factor*base7std)+base7);
%     odouroffinds=find(odouroff7>(factor*base7std)+base7);
%     windoffinds=find(windoff7>(factor*base7std)+base7);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         figure(fugh);
%         hold on;
%         subplot(1,8,7);
%         plot(tvec,col7.(directions{k})(allinds,70:100),'color',colours(k));
%         ylim([0.9 1.5]);
%     end
% 
%     windinds=find(wind8>(factor*base8std)+base8);
%     odourinds=find(odour8>(factor*base8std)+base8);
%     odouroffinds=find(odouroff8>(factor*base8std)+base8);
%     windoffinds=find(windoff8>(factor*base8std)+base8);
%     allinds=unique([windinds; odourinds; odouroffinds; windoffinds]);
% 
%     if ~isempty(allinds)
%         figure(fugh);
%         hold on;
%         subplot(1,8,8);
%         plot(tvec,col8.(directions{k})(allinds,70:100),'color',colours(k));
%         ylim([0.9 1.5]);
%     end
% 
%     
% 
%  
% end




 