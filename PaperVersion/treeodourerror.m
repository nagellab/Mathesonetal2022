function [err]=treeodourerror(odourtables)


genotypes=fieldnames(odourtables);

for k=1:numel(genotypes)

    genotab=odourtables.(genotypes{k});
    maxsplits=4;
    odourtree=fitctree(genotab,"Var1",'CrossVal','on','MaxNumSplits',maxsplits);
    odourerr=kfoldLoss(odourtree,'Mode','individual');
    err.(genotypes{k})=odourerr;
    %do I need to re-zscore this? I think that might be the problem 
end
end

