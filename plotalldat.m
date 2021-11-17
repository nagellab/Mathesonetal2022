function [rhos,pvals]=plotalldat(alldat)

rhos={};
pvals={};

colours=colormap(hsv(numel(alldat)));
for k=1:numel(alldat)
    figure; hold on;
    eightcols=linspace(1,8,numel(alldat{k}.mavgx));
    %[r,m,b]=regression(alldat{k}.mavgx,alldat{k}.ang);
    [r,m,b]=regression(eightcols,alldat{k}.ang);
    %l=true;
    if m>0
        %scatter(alldat{k}.mavgx,alldat{k}.ang);
        scatter(eightcols,alldat{k}.ang,'MarkerEdgeColor',colours(k,:));
        %plot([alldat{k}.mavgx(1) alldat{k}.mavgx(end)],[m*alldat{k}.mavgx(1)+b m*alldat{k}.mavgx(end)+b])
        plot([1 8],[m*1+b m*8+b],'Color',colours(k,:));
        [rho pval]=corr(eightcols',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        %[rho pval]=corr(alldat{k}.mavgx',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        rhos{k}=rho;
        pvals{k}=pval;
    else
        %[r,m,b]=regression(fliplr(alldat{k}.mavgx),alldat{k}.ang);
        [r,m,b]=regression(fliplr(eightcols),alldat{k}.ang);
        %scatter(fliplr(alldat{k}.mavgx),alldat{k}.ang);
        scatter(fliplr(eightcols),alldat{k}.ang,'MarkerEdgeColor',colours(k,:));
        %plot([alldat{k}.mavgx(1) alldat{k}.mavgx(end)],[m*alldat{k}.mavgx(1)+b m*alldat{k}.mavgx(end)+b])
        plot([1 8],[m*1+b m*8+b],'Color',colours(k,:));
        [rho pval]=corr(eightcols',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        %[rho pval]=corr(alldat{k}.mavgx',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        
        rhos{k}=rho;
        pvals{k}=pval;
    end
    xlim([0 9]);
end
end 