function realmat=makesummarytable(atlaspath,siglinesup,siglinesdown,pvals,FSBparameters)

%take these and convert to a matrix 
%going to need a list of all of the genotypes

%right now this doesn't actually require the FSBparameters - but we could
%just add that in - sort on the upwind diff for each category? 
atlas=readtable(atlaspath);
atlas=rmmissing(atlas);

atlas.genotype=categorical(atlas.genotype);
atlas.anatomy=categorical(atlas.anatomy);

parameters=fieldnames(pvals);
%change order of parameters 
parameters{1}='upwind';
parameters{2}='pmove';
categories=unique(atlas.anatomy);
order=[9,10,15,16,12,11,13,3,6,4,5,7,2,1,8];
categories=categories(order);

%need a count of the number of genotypes in the category for this to work 
%all values divided by the bonferroni correction 
%colour code the fonts to match the neuron type??
%give it a value system 
%-3:strong decrease p<0.001
%-2:moderate decrease p<0.01
%-1: sig decease p<0.05
% 0: no change p>0.05
% 1: sig increase p<0.05
% 2: moderate increase p<0.01
% 3: strong increase p<0.001



 

immat={};
realmat=[];
labels=[];
%realmat will be a matrix of 3 rows, each column a genotype

 %going to be numel(param) by numel(parameters matrix)
for k=1:numel(parameters)
    counter=0;
    % add a blank in 
    for j=1:numel(categories)
        %get every genotype of the category -> 
        indices=find(atlas.anatomy==categories(j));
        genolist=atlas.genotype(indices);
        numgeno=numel(indices);
        
        %now sort the genotype list based on upwind velocity so things stay
        %in order 
        
        %pseudocode 
        %for each category, go through and sort them by change in upwind
        %velocity 
        %put the list of genotypes in that order 
        %going to need to GET the parameter (have to go through the list
        %and make the list of access names 
        
        diffs=[];
        for sorter=1:numel(genolist)
            pname=strcat('d',cellstr(genolist(sorter)));
            diff=nanmean(FSBparameters.upwind.(pname{:})-FSBparameters.upwindbase.(pname{:}));
            diffs(sorter)=diff;  
        end
        [~,sortedinds]=sort(diffs);
        sortedinds=fliplr(sortedinds);
        
        try
            genolist=genolist(sortedinds);
        catch
            disp('error sorting in the summary table');
        end
            
        
        
        for p=1:numel(genolist)%
            %check if for the given parameter the line is significantly up
            %or down 
            counter=counter+1;
            
            current=genolist(p);
            labels=[labels,cellstr(current)];
            pname=strcat('d',cellstr(current));
            try
            currpval=pvals.(parameters{k}).(pname{:});%if it can't find - fucking 71A02 - just delete it? 
            catch
                disp('genotype excluded');
                %counter=counter-1;%like it never happened
            end

            if sum(strcmp(siglinesup.(parameters{k}),pname))%is this one of the increase -> problem with the contains function - the split is hitting it - has to be strcmp or find
                %if yes check the p-value to assign the increase number
                %counter is 
                %change numgeno if 
                if (categories(j)=='dFSB'||categories(j)=='dFSBsplit')
                    numgeno=22;
                elseif (categories(j)=='vFSB'||categories(j)=='vFSBsplit')
                    numgeno=18;
                end
                
                if currpval<(0.001/numgeno)
                    realmat(k,counter)=3;
                elseif currpval<(0.01/numgeno)
                    realmat(k,counter)=2;
                elseif currpval<(0.05/numgeno)
                    realmat(k,counter)=1;
                else 
                    realmat(k,counter)=0;
                    disp('error - pval doesnt line up increase');
                end
             %have to check to make sure it even HAS the parameter. 
            elseif ~sum(contains(fieldnames(siglinesdown),parameters{k}))%the case the parameter does not exist
               realmat(k,counter)=0;
            elseif sum(strcmp(siglinesdown.(parameters{k}),pname))
                %if yes check the p-value to assign the decrease number
                if currpval<0.001/numgeno
                    realmat(k,counter)=-3;
                elseif currpval<0.01/numgeno
                    realmat(k,counter)=-2;
                elseif currpval<0.05/numgeno
                    realmat(k,counter)=-1;
                else %well this should never happen
                    disp('error pval doesnt line up decrease');
                end
            else
                %the number is 0
                realmat(k,counter)=0;
            end
        end
    end
end



map=[33/255,102/255,172/255;
    103/255,169/255,207/255;
    209/255,229/255,240/255;
    1,1,1;
    253/255,219/255,199/255;
    239/255,138/255,98/255;
    178/255,24/255,43/255];




categorycolours=[ 136/255, 46/255, 114/255;
25/255, 101/255, 176/255;
82/255,137/255,199/255;
123/255,175/255,222/255;
78/255,178/255,101/255;
202/255,224/255,171/255;
%247/255,240/255,86/255;
244/255,167/255,54/255;
232/255,96/255,28/255;
220/255,5/255,12/255;
114/255,25/255,14/255;
119/255,119/255,119/255];


figure; 
hold on;
pcolor([realmat,zeros(size(realmat,1),1);zeros(1,size(realmat,2)+1)]);

colormap(map);
xticks(linspace(1,counter,counter))
xticklabels(labels);
xtickangle(90);
yticks([1 2 3 4 5 6 7 8 9 10 11]);
yticklabels(parameters);
%grid on;
axis image
axis ij
set(gca, 'FontName', 'Helvetica')


end
                
            
            
            
            
            
            
            
        