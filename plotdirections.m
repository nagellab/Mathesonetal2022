function plotfluordirections(avgfluor)
%plot the data averaged for each ROI
%show the ROI?
fn=fieldnames(avgfluor);
[numROIs,triallength]=size(avgfluor.(fn(1)));

fig=figure;
hold on;
for k=1:numROIs
    for p=1:numel(fn)
        plot(avgfluor.(fn{p})(k,:));
    end
    kwait=waitforbuttonpress;
    clf(fig);
    

end
end