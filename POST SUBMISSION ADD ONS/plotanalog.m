function meanresp=plotanalog(expnum)
    filename=strcat(expnum,'.mat');
    load(filename); %load data 
    
    %for directions 
    figure; hold on;
    directions=[data.winddir];
    meanresp=[];
    for k=1:5
        inds=find(directions==k);
        directionalresp=[];
        for p=1:numel(inds)
            singletrialanalog=data(inds(p)).analog(1:3085);
            directionalresp(p,:)=singletrialanalog;
        end
        meanresp(k,:)=mean(directionalresp);
        plot(meanresp(k,:));
    end
end
        
        
       
        


