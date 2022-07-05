function[allangs]= polar2vec(bins,orientations,meanorientations)

b=bins.base_odour;
%all will be identical to b

%going to work in radians

b=deg2rad(b);

conds=fieldnames(orientations);

for k=1:numel(conds)

    data_x=orientations.(conds{k}).*cos(b);
    data_y=orientations.(conds{k}).*sin(b);
    
    vecs_x=nansum(data_x,2);
    vecs_y=nansum(data_y,2);

    data_meanx=meanorientations.(conds{k}).*cos(b);
    data_meany=meanorientations.(conds{k}).*sin(b);

    vec_mx=nansum(data_meanx);
    vec_my=nansum(data_meany);

   
    vecs_mag=sqrt(vecs_x.^2 +vecs_y.^2);
    vecs_ang=atan(vecs_y./vecs_x);
    mean_mag=sqrt(vec_mx^2+vec_my^2);
    mean_ang=atan(vec_my/vec_mx);
    inds=find(vecs_x<0);
    vecs_ang(inds)=vecs_ang(inds)+pi;
    if vec_mx<0
        mean_ang=mean_ang+pi;
    end
    avgvec_x=mean(vecs_x);
    avgvec_y=mean(vecs_y);
    [thet, magrad]=cart2pol(avgvec_x,avgvec_y);
    
    figure; 
    for j=1:numel(vecs_ang)
        %figure; 
        %polarplot(b,orientations.(conds{k})(j,:));
        %hold on;
        %polarplot([0 vecs_ang(j)],[0 vecs_mag(j)],'color','g');%[0.5 0.5 0.5]);
        quiver(0,0,vecs_mag(j)*cos(vecs_ang(j)),vecs_mag(j)*sin(vecs_ang(j)),0,'k');
        hold on;
    end
    %polarplot([0 mean_ang],[0 mean_mag],'color','k','LineWidth',2);
    xlim([-1 1]);
    ylim([-1 1]);
    axis square
    title(conds{k});
   allangs.(conds{k})=vecs_ang;
end


end

