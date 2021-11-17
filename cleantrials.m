function[sortednames,data]=cleantrials(data,fileexpnum,filelist,imskip,expskip)
%this function returns the mapping between imaging and experimental trials

%normall this would be that imaging trials are one behind exp trials
%because one has 0 indexing and the other starts with 1

%sometimes the case that you will need to skip some other trials because of
%human error when running

filenames={filelist(:).name};
matchedexpinds=contains(filenames,fileexpnum);
matchedexpnames=filenames(matchedexpinds);
correxpinds=contains(matchedexpnames,'corr');
correxpnames=matchedexpnames(correxpinds); %final list _001_corr at start and _corr at end after 24 or highest num
sortednames={};
%pull the numbers from the file


%sort them
%put the one missing on at the front
%delete whatever ones might need to be skipped
trialorder=[];
sortorder=[];
if isempty(imskip)%make it easier
    imskip=0;
end
ind=1;


for k=1:numel(correxpnames)%for every imaging file there is 
    breakstring=strsplit(correxpnames{k},'_');%
    trialnum=sum(str2num(breakstring{4}));%pull the trial number 
    try
        %look for the imskiptrial 
        if sum(ismember(imskip,trialnum+1))<1%if you do find it then move on, if 0 will never find it? No will skip the first one if you do this.
            trialorder(ind)=trialnum+1; %add one because the lowest will be 0
            sortednames{ind}=correxpnames{k};
            ind=ind+1;
            disp('did it');
        end
        sortorder(k)=trialnum+1;
    catch
        disp('fuck');
    end
end
[~,rankingtrials]=sort(trialorder);
sortednames=sortednames(rankingtrials); %number 6 is getting deleted rather than 7 

try
    
    exptrials=linspace(1,numel(data),numel(data));%make it the size of data that you have
    exptrials(expskip)=[];%delete the ones that shouldn't be there
    %is this really deleting the right ones
    datacopy=data(exptrials);%reduce down to the correct trials
    %sortednames=correxpnames(exptrials);%sortednames is fine doesn't need to be updated again
catch
    disp('ugh')
end
data=datacopy;

end







