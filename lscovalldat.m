function lscovalldat(alldat)

rhos={};
pvals={};

colours=colormap(hsv(numel(alldat)));
%colormap(gray(101));
f=figure; hold on;
for k=1:numel(alldat)
    
    eightcols=linspace(1,8,numel(alldat{k}.mavgx));
    x1=eightcols';%make to column format for lscov
    y=alldat{k}.ang';
    X=[ones(size(x1)) x1];
    a=X\y;
    %[b,se_b,mse]=lscov(X,y)
    %[bw,se_bw,msew]=lscov(X,y,alldat{k}.mag');
    %[r,m,b]=regression(alldat{k}.mavgx,alldat{k}.ang);
    %[r,m,b]=regression(eightcols,alldat{k}.ang);
    %l=true;
    gscolinds=round(100*alldat{k}.nmag,0)+1;
    %if bw(2)>0
        %scatter(alldat{k}.mavgx,alldat{k}.ang);
        plot(eightcols,alldat{k}.ang,'Color',[0.5 0.5 0.5],'Linewidth',2);
        scatter(eightcols,alldat{k}.ang,[],gscolinds,'filled','MarkerEdgeColor','k');
        %plot([alldat{k}.mavgx(1) alldat{k}.mavgx(end)],[m*alldat{k}.mavgx(1)+b m*alldat{k}.mavgx(end)+b])
        %plot([1 8],[b(2)*1+b(1) b(2)*8+b(1)],'Color',colours(k,:));
        %plot([1 8],[bw(2)*1+bw(1) bw(2)*8+bw(1)],'Color','k');
        %[rho pval]=corr(eightcols',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        %[rho pval]=corr(alldat{k}.mavgx',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        %rhos{k}=rho;
        %pvals{k}=pval;
    %else
        %[r,m,b]=regression(fliplr(alldat{k}.mavgx),alldat{k}.ang);
        %x1=flipud(eightcols');
        %X=[ones(size(x1)) x1];
        %[b,se_b,mse]=lscov(X,y)
        %[bw,se_bw,msew]=lscov(X,y,alldat{k}.mag');
        %[r,m,b]=regression(fliplr(eightcols),alldat{k}.ang);
        %scatter(fliplr(alldat{k}.mavgx),alldat{k}.ang);
        %scatter(fliplr(eightcols),alldat{k}.ang,[],gscolinds,'filled','MarkerEdgeColor','k');
        %plot([alldat{k}.mavgx(1) alldat{k}.mavgx(end)],[m*alldat{k}.mavgx(1)+b m*alldat{k}.mavgx(end)+b])
        %plot([1 8],[bw(2)*1+bw(1) bw(2)*8+bw(1)],'Color','k');
        %[rho pval]=corr(eightcols',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        %[rho pval]=corr(alldat{k}.mavgx',alldat{k}.ang','Type','Spearman');%have to transpose both sets of data otherwise has nothing to compare with 
        
        %rhos{k}=rho;
        %pvals{k}=pval;
    %end
    xlim([0 9]);
    ylim([-90 90]);
    %print(f,['fly_2_', num2str(k)],'-dpdf','-painters');
end
angs=[];
dynamicrange=[];
for k=1:numel(alldat)
    angs(k,:)=alldat{k}.ang;
    dynamicrange(k)=(max(alldat{k}.ang+90))/min(alldat{k}.ang+90);
end

plot(eightcols,nanmean(angs),'color','k','Linewidth',3);
xlabel('Column Number');
ylabel('Average Angle');
figure; hold on;
plot(ones(1,numel(dynamicrange)),dynamicrange,'o');
plot(1,mean(dynamicrange),'o','color','k');


end 