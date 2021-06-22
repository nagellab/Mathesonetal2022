function [indslight,indsodour]= matchedtimecourses2conds(atlaspath,drivers,savefigs)
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
%here drivers is just a string - don't really need a for loop
%index=find(atlas.genotype==drivers);
filename=atlas.datafilename(1);
try
    genotypedata=load(filename{:});
catch
    disp(' error loadingdata in matchedtimecourses2conds ');
end
fn=fieldnames(genotypedata);
genotypedata=genotypedata.(fn{1});%struct of all variables - should be only one so get it
%prepare the data
resdatalight=preparedata(genotypedata.resblankalwayson10s,[30 35],0.25,0);
resdataodour=preparedata(genotypedata.res10salwaysonblank,[30 35],0.25,0);

[indslight,indsodour]=plotcomparevels_multipretty(resdatalight,resdataodour,{'pmove','upwindvelocity','groundspeed','angularvelocity','curvature','placepref'});
%fignum=6*(k-1);%calculate the number the given figure will be
pmovefigs=figure(1);
upwindfigs=figure(2);
groundspeedfigs=figure(3);
angularvelocityfigs=figure(4);
curvaturefigs=figure(5);
placepreffigs=figure(6);


%save the figures
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

if strcmp(savefigs,'savefigs')
    close all;
end

end