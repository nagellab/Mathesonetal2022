function [bincenters, circularhists,meanhist]= avg_thetahist(resdata,window,binwidth)

%resdata=preparedata(resdata,window,0.3,0);%make sure data is filtered 
%turning off here to use in find same flies 2 conds 
numflies=length(resdata);
%bins will always be the same 
%circular hists
circularhists=[];
binnum=360/binwidth;
bincenters=binwidth/2:binwidth:360-binwidth/2;
%make circular by extending end to plot
%bincenters=deg2rad([bincenters, bincenters(1)]);
Fr=50;%50hz framerate 
for k=1:numflies
    fly=resdata(k);%get each fly
    theta=fly.thetafilt(window(1)*Fr:window(2)*Fr,:); %all trials of one fly 
    %theta=wrapToPi(deg2rad(theta));%convert to deg and wrap correctly 
    orienthist_plot=histcounts(theta,binnum,'Normalization','probability');
    orienthist=histcounts(theta,binnum,'Normalization','probability');
    circularhists(k,:)=orienthist;
end

meanhist=mean(circularhists);

end 