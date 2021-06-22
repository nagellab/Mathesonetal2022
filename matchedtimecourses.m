function matchedtimecourses(atlaspath,drivers,activationtype,savefigs)
%take in the path to datafile locations and a list of drivers
%plot the timecourses of the drivers
%set all y-axes the same
%savefigs: a flag to decide if you want to save all the figures

%want to make a version of this where it does both chrimson and odour

atlas=readtable(atlaspath);
atlas=rmmissing(atlas);

atlas.genotype=categorical(atlas.genotype);
atlas.anatomy=categorical(atlas.anatomy);

pmovefigs={};
upwindfigs={};
groundspeedfigs={};
angularvelocityfigs={};
curvaturefigs={};
placepreffigs={};
close all;%close all the figures so you can use the figure index to know which is which
for k=1:numel(drivers)
    index=find(atlas.genotype==drivers{k});
    filename=atlas.datafilename(index);
    try
        genotypedata=load(filename{:});
    catch
        disp(' what ');
    end
    fn=fieldnames(genotypedata);
    genotypedata=genotypedata.(fn{1});%struct of all variables - should be only one so get it
    if strcmp('activation',activationtype)
        resfields=fieldnames(genotypedata);
        if(sum(contains(resfields,'resblankalwayson10s')))
            resdata=genotypedata.resblankalwayson10s;
        else
            resdata=genotypedata.resblankalwaysonhigh;
        end
    elseif (strcmp('windoff',activationtype))
        resdata=genotypedata.resblankalwaysoff10s;
    else
        resdata=genotypedata.res10salwaysonblank;
    end
    plotcomparevels_pretty(resdata,{'pmove','upwindvelocity','groundspeed','angularvelocity','curvature','placepref'});
    fignum=6*(k-1);%calculate the number the given figure will be
    pmovefigs{k}=figure(fignum+1);
    upwindfigs{k}=figure(fignum+2);
    groundspeedfigs{k}=figure(fignum+3);
    angularvelocityfigs{k}=figure(fignum+4);
    curvaturefigs{k}=figure(fignum+5);
    placepreffigs{k}=figure(fignum+6);
end

%set the y-axis the same for all
pmoveyls={};
upwindyls={};
groundspeedyls={};
angularvelocityyls={};
curvatureyls={};
placeprefyls={};

for p=1:numel(drivers)
    fpm=pmovefigs{p};
    fuv=upwindfigs{p};
    fgs=groundspeedfigs{p};
    fav=angularvelocityfigs{p};
    fc=curvaturefigs{p};
    fyp=placepreffigs{p};
    
    
    axpm=fpm.get('CurrentAxes');
    axuv=fuv.get('CurrentAxes');
    axgs=fgs.get('CurrentAxes');
    axav=fav.get('CurrentAxes');
    axc=fc.get('CurrentAxes');
    axy=fyp.get('CurrentAxes');
    
    pmoveyls{p}=axpm.YLim;
    upwindyls{p}=axuv.YLim;
    groundspeedyls{p}=axgs.YLim;
    angularvelocityyls{p}=axav.YLim;
    curvatureyls{p}=axc.YLim;
    placeprefyls{p}=axy.YLim;
    
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
miny=cellfun(@min,placeprefyls);
miny=min(miny);

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
maxy=cellfun(@max,placeprefyls);
maxy=max(maxy);

for p=1:numel(drivers)
    fpm=pmovefigs{p};
    fuv=upwindfigs{p};
    fgs=groundspeedfigs{p};
    fav=angularvelocityfigs{p};
    fc=curvaturefigs{p};
    fy=placepreffigs{p};
    
    axpm=fpm.get('CurrentAxes');
    axuv=fuv.get('CurrentAxes');
    axgs=fgs.get('CurrentAxes');
    axav=fav.get('CurrentAxes');
    axc=fc.get('CurrentAxes');
    axy=fy.get('CurrentAxes');
    
    axpm.YLim=[minpm,maxpm];
    axuv.YLim=[minuv,maxuv];
    axgs.YLim=[mings,maxgs];
    axav.YLim=[minav,maxav];
    axc.YLim=[minc,maxc];
    axy.YLim=[miny,maxy];
    
    close(fpm);
    close(fgs);
    close(fav);
    close(fy);
    
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
        savefig(fy,['ypos_' drivers{p}]);
        %print(fc,['curvature_' drivers{p}],'-dtiffn','-painters');
        print(fy,['ypos_' drivers{p}],'-depsc','-painters');
    end
end
if strcmp(savefigs,'savefigs')
    close all;
end

end