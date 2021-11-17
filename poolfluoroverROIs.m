function [base,wind1,odour,wind2]=poolfluoroverROIs(base,wind1,odour,wind2,avgfluorperiod,k)
fn=fieldnames(avgfluorperiod);%gets the field params - base,wind1,odour,wind2,
directions=fieldnames(avgfluorperiod.(fn{1}));%one two three four five


for p=1:numel(directions)
    base.(directions{p})(k,:)=avgfluorperiod.base.(directions{p});
    wind1.(directions{p})(k,:)=avgfluorperiod.wind1.(directions{p});
    odour.(directions{p})(k,:)=avgfluorperiod.odour.(directions{p});
    wind2.(directions{p})(k,:)=avgfluorperiod.wind2.(directions{p});
end
end
    