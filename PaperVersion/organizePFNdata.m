%% 



%% convert PFNa data 

%FRmeanW is the wind response 
%FRsemW is the wind sem 

%13 is the one going the opposite way
keepsflies=[1,2,3,4,6,7,8,9,10,11,12];
keepsdirs=[2,3,4,5,6];
%remove the one from the other side
FRmeanWAM=FRmeanW(keepsdirs,keepsflies);
FRsemWAM=FRsemW(keepsdirs,keepsflies);


%arrange into same type of matrix as dprime analysis takes 

flyIDs=[1:1:11];
flyIDs=repelem(flyIDs,5);
dirs={'one','two','three','four','five'};
sides={'left','left','center','right','right'};
dirs=repmat(dirs,1,11);
sides=repmat(sides,1,11);
totaldata=reshape(zscore(FRmeanWAM),1,55);
PFNtab=table(categorical(sides)',categorical(flyIDs)',totaldata');%wind data



%after making tables: 
tables.dPFNa.wind=PFNtab
tables.dPFNa.odour=PFNtab
tables.dPFNa.windoff=PFNtab




%% oraganize for PFN odour data
%for regular
keepdirs=[2,3,4];
meanWAM=meanW(keepdirs,:);
meanOAM=meanO(keepdirs,:);
allmean=[meanWAM;meanOAM];
zmean=zscore(allmean);
totaldata=reshape(zmean,1,36);

flyIDs=[1:1:6];
flyIDs=repelem(flyIDs,6);
odour=[0 0 0 1 1 1];
odour=repmat(odour,1,6);

odourtables.dPFNa=table(categorical(odour)',categorical(flyIDs)',totaldata');

%for baseline
keepdirs=[2,3,4];
meanBAM=meanB(keepdirs,:);
meanOAM=meanO(keepdirs,:);
allmeanB=[meanBAM;meanOAM];
zmeanB=zscore(allmeanB);
totaldataB=reshape(zmeanB,1,36);

flyIDs=[1:1:6];
flyIDs=repelem(flyIDs,6);
odour=[0 0 0 1 1 1];
odour=repmat(odour,1,6);

odourbasetables.dPFNa=table(categorical(odour)',categorical(flyIDs)',totaldataB');


