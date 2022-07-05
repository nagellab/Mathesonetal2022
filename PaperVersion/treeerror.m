function [err,trees]=treeerror(tables)


genotypes=fieldnames(tables);

for k=1:numel(genotypes)

    genotables=tables.(genotypes{k});
    %split the tables
    windtab=genotables.wind;
    odourtab=genotables.odour;
    windofftab=genotables.windoff;
    %generate and train the classification trees
    maxsplits=4;
    %windtree=fitctree(windtab,"Var1",'CrossVal','on','MaxNumSplits',maxsplits);
    %odourtree=fitctree(odourtab,"Var1",'CrossVal','on','MaxNumSplits',maxsplits);
    %windofftree=fitctree(windofftab,"Var1",'CrossVal','on','MaxNumSplits',maxsplits);
    try
        %windtree=fitctree(windtab.totaldata,windtab.Var1,'CrossVal','on','MaxNumSplits',maxsplits);
        %odourtree=fitctree(odourtab.totaldata,odourtab.Var1,'CrossVal','on','MaxNumSplits',maxsplits);
        %windofftree=fitctree(windofftab.totaldata,windofftab.Var1,'CrossVal','on','MaxNumSplits',maxsplits);
        windtree=fitctree(windtab,"Var1",'CrossVal','on','MaxNumSplits',maxsplits);
        odourtree=fitctree(odourtab,"Var1",'CrossVal','on','MaxNumSplits',maxsplits);
        windofftree=fitctree(windofftab,"Var1",'CrossVal','on','MaxNumSplits',maxsplits);
    catch
        windtree=fitctree(windtab.Var3,windtab.Var1,'CrossVal','on','MaxNumSplits',maxsplits);
        odourtree=fitctree(odourtab.Var3,odourtab.Var1,'CrossVal','on','MaxNumSplits',maxsplits);
        windofftree=fitctree(windofftab.Var3,windofftab.Var1,'CrossVal','on','MaxNumSplits',maxsplits);
    end
    %windtree=fitcecoc(windtab,"Var1",'CrossVal','on');
    %odourtree=fitcecoc(odourtab,"Var1",'CrossVal','on');
    %windofftree=fitcecoc(windofftab,"Var1",'CrossVal','on');
    % calculate the kfoldLoss

    winderr=kfoldLoss(windtree,'Mode','individual');
    odourerr=kfoldLoss(odourtree,'Mode','individual');
    windofferr=kfoldLoss(windofftree,'Mode','individual');
    trees.(genotypes{k}).wind=windtree;
    trees.(genotypes{k}).odour=odourtree;
    trees.(genotypes{k}).windoff=windofftree;
    err.(genotypes{k})=[winderr,odourerr,windofferr];
end
end

