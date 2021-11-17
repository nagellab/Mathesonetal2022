function alldat=columnvangle(headpath)
cd('extracted2');
filelist=dir;
alldat={};
goodfilenum=1;
for k=1:numel(filelist)
    dataname=filelist(k).name;
    cd(headpath);
    if contains(dataname,'_analysis2')
        fileexpnum=dataname(1:end-14);%remove _analysis.mat from it to feed into next code and get the two
        dat=quickstrongestdir(headpath,fileexpnum);
        if ~isempty(dat)
            %sort the data
            [~,sortord]=sort(dat.avgx);
            dat.avgx=dat.avgx(sortord);
            dat.ang=dat.ang(sortord);
            dat.mag=dat.mag(sortord);
            minx=min(dat.avgx);
            dat.mavgx=dat.avgx-minx;
            maxmag=max(dat.mag);
            dat.nmag=dat.mag/maxmag;
            
            
            
            alldat{goodfilenum}=dat;
            goodfilenum=goodfilenum+1;%make sure this has the right name to increment
        end
    else
        disp('are you ok with this');
    end
end
try
figure; hold on;
for k=1:goodfilenum-1
    scatter(alldat{k}.avgx(1),alldat{k}.ang(end));
end
catch
    disp('o h ack');
end
    
    





end