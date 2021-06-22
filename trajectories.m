function trajectories(atlaspath,trajectorypath,savefigs)
%load the file with all the genotype locations
atlas=readtable(atlaspath);
atlas=rmmissing(atlas);
atlas.genotype=categorical(atlas.genotype);
atlas.anatomy=categorical(atlas.anatomy);

%load the excelfile with the list of trajectories we wish to plot for the
%lines of interest

trajs=readtable(trajectorypath);
%trajs=rmmissing(trajs);%will remove all extra trials
trajs.Line=categorical(trajs.Line);


for k=1:numel(trajs.Line)
    index=find(atlas.genotype==trajs.Line(k));%get the index that the datafile for the trajectory exists at
    if ~isempty(index)
        filename=atlas.datafilename(index);
        genotypedata=load(filename{:});
        fn=fieldnames(genotypedata);
        genotypedata=genotypedata.(fn{1});
        if (trajs.type(k)==0)
            resdata=genotypedata.resblankalwayson10s;
        elseif (trajs.type(k)==1)
            resdata=genotypedata.res10salwaysonblank;
        elseif (trajs.type(k)==2)
            resdata=genotypedata.resblank30swind;
        else
            resdata=genotypedata.resblankalwaysonhigh;
        end
        
        f=figure;
        set(gca, 'Position', [1 124 1 154]);
        geno=cellstr(trajs.Line(k));
        geno=geno{:};
        hold on;
        subplot(151)
        plottrackspretty(resdata,trajs.fly1(k),trajs.trial1(k));
        subplot(152)
        plottrackspretty(resdata,trajs.fly2(k),trajs.trial2(k));
        subplot(153)
        plottrackspretty(resdata,trajs.fly3(k),trajs.trial3(k));
        % subplot(154)
        % plottrackspretty(resdata,trajs.fly4(k),trajs.trial4(k));
        % subplot(155)
        % plottrackspretty(resdata,trajs.fly5(k),trajs.trial5(k));
        
        
        
        title(cellstr(trajs.Line(k)));
        %title(ax,'FontWeight','normal');
        set(findall(gca, '-property', 'FontSize'), 'FontSize', 16)
        set(gca, 'FontName', 'Helvetica');
        if strcmp(savefigs,'savefigs')
            savefilename=strcat([geno '_exampletrajectories']);
            savefig(f,savefilename);
            print(f,savefilename,'-depsc');
            close all;
        end
    else
        disp(['The genotype could not be found ' trajs.Line(k)]);
    end
    
    
    
end