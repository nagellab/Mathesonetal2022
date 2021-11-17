function ax=plotcolouredROIs(ax,ROIs,templates,facecolours,tempnum)

[~,numROIs]=size(ROIs);
[Ypix,Xpix]=size(templates{1});

axes(ax);
hold on;
imagesc(templates{tempnum});
colormap('gray');

for k=1:numROIs
    
    currROI=reshape(ROIs(:,k),[Ypix,Xpix]);
    B=bwboundaries(currROI);
    for n=1:length(B)
        boundary=B{n};
        patch(boundary(:,2),boundary(:,1),facecolours(k,:),'FaceAlpha',0.2,'Edgealpha',0);
    end
    xlim([0 Xpix]);
    ylim([0 Ypix]);
    %axis equal
    daspect([1 1 1]);
    
    
end
end