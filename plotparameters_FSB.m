function [siglinesup,siglinesdown,magnitudes,pvals]=plotparameters_FSB(atlaspath,parameterdata,parameters,anatomy,savefigs,mode)
%take in the path to a spreadsheet containing genotype locations
%take in parameterdata from extract function
%enter antomy as a cell array of strings that you wish to access
%enter parameters as the ones you wish to plot
%mode lets you insert 'anatomy' as either a brain region ('region' by
%default) or a driver line 'driver'

%for the FSB screen make them all with different coded regions - make sure
%it makes sense? give different colours to each type - have them spread
%over two lines so we can actually see them? otherwise very difficult to
%see. Use the jitter plot still? I don't want to go to a bar but I guess I
%could.

%within each catergory have it sorted by magnitude -> set a different
%colour for those
%set the axis label full vertical?
%need to make more colours
colours=[ 136/255, 46/255, 114/255;
    136/255, 46/255, 114/255;
    25/255, 101/255, 176/255;
    25/255, 101/255, 176/255;
    82/255,137/255,199/255;
    82/255,137/255,199/255;
    123/255,175/255,222/255;
    78/255,178/255,101/255;
    202/255,224/255,171/255;
    247/255,240/255,86/255;
    244/255,167/255,54/255;
    232/255,96/255,28/255;
    220/255,5/255,12/255;
    114/255,25/255,14/255;
    119/255,119/255,119/255];

%paul toll categories, hopefully these stick 9 10 12 14 15 17 18 21 24 26 28




atlas=readtable(atlaspath);
atlas=rmmissing(atlas);%get read of anything missing a value (ie any genotype listed that doesn't have an associated path)
%atlas=table2struct(atlas); maybe don't make it a struct and just work with
%it as a table?

atlas.genotype=categorical(atlas.genotype);
atlas.anatomy=categorical(atlas.anatomy); %convert these to categorical variables to use == operator with instead of havomg to strcmp or match

%fn=fieldnames(parameterdata);%get the parameterdata fieldnames, going
%to have to know if it is on/off etc and add the base to that
%could use the contains to generate it or just have a lookup table (find
%base)
%going to have to go through all the parameters first and then pick the
%genotypes based on the hierarchy of the structures.


%by default make it so that it does all genotypes and all parameters

allgenotypes={'single OR', 'OR coreceptor','PN','LN','LHON','MBON','dFSB','vFSB','FSB','cFSB','FbSIP','LAL','PFN','AB'};
allparameters={'pmove','upwind','upwindoff','groundspeed','groundspeedoff','angv','angvoff','angvon','curvature','curvatureoff','curvatureon','placepref'};%

%set the parameters to all if using this shortcut to save typing
if strcmp(parameters{1},'all')
    %still want to split figures by parameter
    parameters=allparameters;
end
if strcmp(anatomy{1},'all')
    %case where you want each plot to include every genotype
    anatomy=allgenotypes;
end
%all of these start blank to be added to
siglinesup={};
siglinesdown={};
magnitudes={};
pvals={};

for k=1:numel(parameters)%iterate through all parameters
    %indices=find(contains({atlas.anatomy},anatomy{k}));% the actual important line
    %get just the genotypes of a given anatomical type
    
    figs={};
    filenames={};
    for j=1:numel(anatomy)%iterate through every anatomical class
        if strcmp(mode,'region')
            indices=find(atlas.anatomy==anatomy{j});
        elseif strcmp(mode,'driver')
            indices=find(atlas.genotype==anatomy{j});
        else
            disp('mode must either be region or driver and enter region name or driveline in anatomy as a string');
        end
        [figs{j},siglinesup,siglinesdown,magnitudes,pvals]=compareplot_singlemetricnew(parameterdata,parameters{k},indices,siglinesup,siglinesdown,magnitudes,pvals,mode,colours(j,:));
        %close all;
        filenames{j}=[parameters{k} '_' anatomy{j}];
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
        %ax.YLim=[minlim maxlim];
        ax.YLim=[-15 15];
        %save all figures
        if strcmp(savefigs,'savefigs')
            savefig(f,filenames{p});
            print(f,filenames{p},'-depsc');
        end
    end
    
    
    
    
    
    
end
%close all;
end



