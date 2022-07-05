function p=orient_stats(bins,orientations)

fi=find(bins.light>80);
bi=find(bins.light<100);

idx=intersect(fi,bi);%get the right bins

p_odour=sum(orientations.odour(:,idx),2);
p_light=sum(orientations.light(:,idx),2);

p_odour2=sum(orientations.odour2(:,idx),2);
p_light2=sum(orientations.light2(:,idx),2);

%use the paired test
%run it with 1deg bins and take 80-100 for it 
[he,pe]=ttest2(p_odour,p_light);
[hl,pl]=ttest2(p_odour2,p_light2);


p.early=pe;
p.late=pl;

end