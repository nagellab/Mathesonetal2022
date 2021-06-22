function [siglinesup,siglinesdown,magnitudes]=plotparameters_TNT(atlaspath,parameterdata,parameters,anatomy,savefigs,mode)
%take in the path to a spreadsheet containing genotype locations
%take in parameterdata from extract function
%enter antomy as a cell array of strings that you wish to access
%enter parameters as the ones you wish to plot
%mode lets you insert 'anatomy' as either a brain region ('region' by
%default) or a driver line 'driver'


atlas=readtable(atlaspath);
atlas=rmmissing(atlas);%get read of anything missing a value (ie any genotype listed that doesn't have an associated path)


atlas.genotype=categorical(atlas.genotype);
atlas.anatomy=categorical(atlas.anatomy); %convert these to categorical variables to use == operator with instead of havomg to strcmp or match

%fn=fieldnames(parameterdata);%get the parameterdata fieldnames, going
%to have to know if it is on/off etc and add the base to that
%could use the contains to generate it or just have a lookup table (find
%base)
%going to have to go through all the parameters first and then pick the
%genotypes based on the hierarchy of the structures.


%by default make it so that it does all genotypes and all parameters

allgenotypes={'ctrl','single OR','orco','ir8a', 'OR coreceptor','FSB','HO','search'};
allparameters={'pmove','upwind','upwindoff','groundspeed','groundspeedoff','angv','angvoff','angvon','curvature','curvatureoff','curvatureon'};%

%set the parameters to all if using this shortcut to save typing
if strcmp(parameters{1},'all')
    %still want to split figures by parameter
    parameters=allparameters;
end
if strcmp(anatomy{1},'all')
    %case where you want each plot to include every genotype
    anatomy=allgenotypes;
end
%change this to difference from control - make a comparison
siglinesup={};
siglinesdown={};
magnitudes={};

for k=1:numel(parameters)%iterate through all parameters
    
    
    figs={};
    filenames={};
    for j=1:numel(anatomy)%iterate through every anatomical class
        if strcmp(mode,'region')
        indices=find(atlas.anatomy==anatomy{j});
        elseif strcmp(mode,'driver')
            indices=find(atlas.genotype==anatomy{j});
        else
            disp('mode must either be region or drive and enter region name or driveline in anatomy as a string');
        end
        indices=[1;indices];
        try
        [figs{j},siglinesup,siglinesdown,magnitudes]=compareplot_tnt(parameterdata,parameters{k},indices,siglinesup,siglinesdown,magnitudes,mode);
        catch
            disp(' bleh');
        end
        filenames{j}=[parameters{k} '_' anatomy{j}]
    end
    %scale all the figures, of the same anatomy the same
    yls={};
    for p=1:numel(figs)
        f=figs{p};
        ax=f.get('CurrentAxes');
        yls{p}=ax.YLim;
    end
    minlim=cellfun(@min,yls);
    minlim=min(minlim);
    maxlim=cellfun(@max,yls);
    maxlim=max(maxlim);
    for p=1:numel(figs)
        f=figs{p};
        ax=f.get('CurrentAxes');
        ax.YLim=[minlim maxlim];
        %save all figures
        if strcmp(savefigs,'savefigs')
            savefig(f,filenames{p});
            print(f,filenames{p},'-depsc');
        end
    end
    
    
    
    
    
    
end
%close all;
end



