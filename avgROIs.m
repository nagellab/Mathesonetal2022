function [avgfluor,stdfluor]= avgROIs(fluordata)
%I think the first frame should basically always be skipped?
avgfluor={};
stdfluor={};

for k=1:5 %for each of the five directions
    fn=fieldnames(fluordata);
    [ROInum,triallength]=size(fluordata.(fn{1}){1});
   
    dirROIs=[];
    for kk=1:ROInum% for each ROI
        
         multitrialROI=[];%collect all the data from the same ROI across trials so you can take the average 
        for p=1:numel(fluordata.(fn{k}))%for each trial that was run for the given direction
            singletrial=fluordata.(fn{k})(p);
            nocellsingletrial=singletrial{:};%i am bad at matlab and want it to just be a matrix again
            oneROItimecourse=nocellsingletrial(kk,:);
            try
            multitrialROI(p,:)=oneROItimecourse;
            catch
                disp('oh baby');
            end
        end
       dirROIs(kk,:)=mean(multitrialROI);%should also probably save the standard deviation as well right
       dirROIsstd(kk,:)=std(multitrialROI);
    end
    avgfluor.(fn{k})=dirROIs;
    stdfluor.(fn{k})=dirROIsstd;
end
end
