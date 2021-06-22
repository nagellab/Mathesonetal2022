function [avgfluor,stdfluor]=averagedirections(fluordata)
fn=fieldnames(fluordata);
for k=1:5
    if isnan(fluordata.(fn{k}))
        avgfluor.(fn{k})=NaN;
        stdfluor.(fn{k})=NaN;
    else
        avgfluor.(fn{k})=nanmean(fluordata.(fn{k}));
        stdfluor.(fn{k})=nanstd(fluordata.(fn{k}));
    end
end
end

%you need to redo the across genotype timecourses tomorrow.
%and check how many trials are actually being thrown out
