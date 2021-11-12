function comparematchedtimecourses_paper(atlaspath,drivers,savefigs,type)
%take in the path to datafile locations and a list of drivers
%plot the timecourses of the drivers
%set all y-axes the same
%savefigs: a flag to decide if you want to save all the figures 

atlas=readtable(atlaspath);
atlas=rmmissing(atlas);

atlas.genotype=categorical(atlas.genotype);
atlas.anatomy=categorical(atlas.anatomy);

pmovefigs={};
upwindfigs={};
groundspeedfigs={};
angularvelocityfigs={};
curvaturefigs={};
close all;%close all the figures so you can use the figure index to know which is which
for k=1:numel(drivers)
    index=find(atlas.genotype==drivers{k});
    ctrlind=find(atlas.genotype==drivers{1});
    filename=atlas.datafilename(index);
    ctrlfile=atlas.datafilename(ctrlind);
    try
    genotypedata=load(filename{:});
    catch
        disp('cant load data in comparematchedtimecourses');
    end
    ctrldata=load(ctrlfile{:});
    fn=fieldnames(genotypedata);
    genotypedata=genotypedata.(fn{1});%struct of all variables - should be only one so get it
    ctrlfn=fieldnames(ctrldata);
    ctrldata=ctrldata.(ctrlfn{1});

    plotcomparevels_multpretty({'pmove','upwindvelocity','groundspeed','angularvelocity','curvature'},type,ctrldata,genotypedata);
    fignum=5*(k-1);%calculate the number the given figure will be
    pmovefigs{k}=figure(fignum+1);
    upwindfigs{k}=figure(fignum+2);
    groundspeedfigs{k}=figure(fignum+3);
    angularvelocityfigs{k}=figure(fignum+4);
    curvaturefigs{k}=figure(fignum+5);
end

%set the y-axis the same for all
pmoveyls={}; 
upwindyls={};
groundspeedyls={};
angularvelocityyls={};
curvatureyls={};

for p=1:numel(drivers)
    fpm=pmovefigs{p};
    fuv=upwindfigs{p};
    fgs=groundspeedfigs{p};
    fav=angularvelocityfigs{p};
    fc=curvaturefigs{p};
    
    axpm=fpm.get('CurrentAxes');
    axuv=fuv.get('CurrentAxes');
    axgs=fgs.get('CurrentAxes');
    axav=fav.get('CurrentAxes');
    axc=fc.get('CurrentAxes');
    
    pmoveyls{p}=axpm.YLim;
    upwindyls{p}=axuv.YLim;
    groundspeedyls{p}=axgs.YLim;
    angularvelocityyls{p}=axav.YLim;
    curvatureyls{p}=axc.YLim;
    
end

minpm=cellfun(@min,pmoveyls);
minpm=min(minpm);
mings=cellfun(@min,groundspeedyls);
mings=min(mings);
minuv=cellfun(@min,upwindyls);
minuv=min(minuv);
minav=cellfun(@min,angularvelocityyls);
minav=min(minav);
minc=cellfun(@min,curvatureyls);
minc=min(minc);

maxpm=cellfun(@max,pmoveyls);
maxpm=max(maxpm);
maxgs=cellfun(@max,groundspeedyls);
maxgs=max(maxgs);
maxuv=cellfun(@max,upwindyls);
maxuv=max(maxuv);
maxav=cellfun(@max,angularvelocityyls);
maxav=max(maxav);
maxc=cellfun(@max,curvatureyls);
maxc=max(maxc);

for p=1:numel(drivers)
    fpm=pmovefigs{p};
    fuv=upwindfigs{p};
    fgs=groundspeedfigs{p};
    fav=angularvelocityfigs{p};
    fc=curvaturefigs{p};
    
    axpm=fpm.get('CurrentAxes');
    axuv=fuv.get('CurrentAxes');
    axgs=fgs.get('CurrentAxes');
    axav=fav.get('CurrentAxes');
    axc=fc.get('CurrentAxes');
    
    axpm.YLim=[minpm,maxpm];
    axuv.YLim=[minuv,maxuv];
    axgs.YLim=[mings,maxgs];
    axav.YLim=[minav,maxav];
    axc.YLim=[minc,maxc];
    
    if strcmp(savefigs,'savefigs')
        savefig(fpm,['pmove_' drivers{p}]);
        %print(fpm,['pmove_' drivers{p}],'-dtiffn','-painters');
        print(fpm,['pmove_' drivers{p}],'-depsc','-painters');
        savefig(fuv,['upwind_' drivers{p}]);
        %print(fuv,['upwind_' drivers{p}],'-dtiffn','-painters');
        print(fuv,['upwind_' drivers{p}],'-depsc','-painters');
        savefig(fgs,['groundspeed_' drivers{p}]);
        %print(fgs,['groundspeed_' drivers{p}],'-dtiffn','-painters');
        print(fgs,['groundspeed_' drivers{p}],'-depsc','-painters');
        savefig(fav,['angularvelocity_' drivers{p}]);
        %print(fav,['angularvelocity_' drivers{p}],'-dtiffn','-painters');
        print(fav,['angularvelocity_' drivers{p}],'-depsc','-painters');
        savefig(fc,['curvature_' drivers{p}]);
        %print(fc,['curvature_' drivers{p}],'-dtiffn','-painters');
        print(fc,['curvature_' drivers{p}],'-depsc','-painters');
    end
end
if strcmp(savefigs,'savefigs')
    close all;
end
    
end