function trajectories_paper(atlaspath,trajectorypath,savefigs)

%load the file with all the genotype locations
atlas=readtable(atlaspath);
%clean up the sheet
atlas=rmmissing(atlas);
%change to categorical variables for easier handling
atlas.genotype=categorical(atlas.genotype);
atlas.anatomy=categorical(atlas.anatomy);

%load the file with the list of trajectories we wish to plot for the
%lines of interest

%Use preselected trajectories 
trajs=readtable(trajectorypath);

trajs.Line=categorical(trajs.Line);

%For the number of genotypes listed in the sheet
for k=1:numel(trajs.Line)
    index=find(atlas.genotype==trajs.Line(k));%get the index that the datafile for the trajectory exists at
    if ~isempty(index)
        %load the data from file and access the interior structure
        filename=atlas.datafilename(index);
        genotypedata=load(filename{:});
        fn=fieldnames(genotypedata);
        resdata=genotypedata.(fn{1});
        
        %Make a figure for each genotype -
        f=figure;
        set(gca, 'Position', [1 124 1 154]);
        geno=cellstr(trajs.Line(k));
        geno=geno{:};
        hold on;
        try
        subplot(151)
        plottrackspretty(resdata,trajs.fly1(k),trajs.trial1(k));
        subplot(152)
        plottrackspretty(resdata,trajs.fly2(k),trajs.trial2(k));
        subplot(153)
        plottrackspretty(resdata,trajs.fly3(k),trajs.trial3(k));
        catch
            disp('oops! Something went wrong trying to plot the trajectories. Are the sheet paths and fly numbers correct?');
        end
        
        
        %Add the genotype name and set figure properties 
        title(cellstr(trajs.Line(k)));
        set(findall(gca, '-property', 'FontSize'), 'FontSize', 16)
        set(gca, 'FontName', 'Helvetica');
        %Save the Figure as an .eps file (set renderer to painters if you
        %want to edit in illustrator) 
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