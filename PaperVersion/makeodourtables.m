function [odourtables]=makeodourtables(tables)

genotypes=fieldnames(tables);

for k=1:numel(genotypes)

    flyID=[tables.(genotypes{k}).wind.Var2;tables.(genotypes{k}).odour.Var2];
    odour=categorical([zeros(numel(tables.(genotypes{k}).wind.Var2),1);ones(numel(tables.(genotypes{k}).odour.Var2),1)]);
    totalresp=[tables.(genotypes{k}).wind.totaldata;tables.(genotypes{k}).odour.totaldata];
    %need to actually re-generate from scratch to take new z-score
    odourtables.(genotypes{k})=table(odour,flyID,totalresp);
end

