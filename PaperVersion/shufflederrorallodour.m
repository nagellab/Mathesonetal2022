function [shufferr]=shufflederrorallodour(tables)

genotypes=fieldnames(tables);

for k=1:numel(genotypes)
    geno=tables.(genotypes{k});
    genoerr=[];
    %now that labels are shuffled re-calculate the error
    %make the tree
    maxsplits=4;
    for p=1:50
        shufftab=geno;
        shufftab.Var1=shufftab.Var1(randperm(length(shufftab.Var1)));
        try
            treeshuff=fitctree(shufftab,"Var1");%,'MaxNumSplits',maxsplits);
            %treeshuff=fitctree(shufftab.totaldata,shufftab.Var1,'MaxNumSplits',maxsplits);
        catch
            treeshuff=fitctree(shufftab.Var3,shufftab.Var1);%,'MaxNumSplits',maxsplits);
        end
        treeshuff=crossval(treeshuff,'kfold',10);
        currerr(:,p)=kfoldLoss(treeshuff,'Mode','individual');
    end
    genoerr=mean(currerr,2);
    shufferr.(genotypes{k})=genoerr;
end

end

