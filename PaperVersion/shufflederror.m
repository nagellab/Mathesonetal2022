function [shufferr]=shufflederror(tables)

PFNtab=tables.dPFNa.wind;
%the PFNa tables are all for wind onset 
shufftab=PFNtab;
shufftab.Var1=shufftab.Var1(randperm(length(shufftab.Var1)));
%shuffle the labels on side directions 

%now that labels are shuffled re-calculate the error
%make the tree
treeshuff=fitctree(shufftab,"Var1");
treeshuff=crossval(treeshuff,'kfold',10000);
shufferr=kfoldLoss(treeshuff,'Mode','individual');

end

