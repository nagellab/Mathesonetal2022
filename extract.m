% have the locations of all the data.
% want to extract and store all the useful parameters,
% Keep this all extracted then make a function to plot the relevant ones.
%Save the extracted parameters so I don't have to keep dealing with this.
%be able to take a flag just to extract a certain type of anatomy.
%Make the flags variable arguments so that one can add as many as they want

function parameters=extract(atlaspath,condition,varargin)
%atlas is the path to the spreadsheet containing all of the file locations
%for the genotypes.
%varargin should be any specific types you wish to do the extraction for
%(if not all of them)

%should create a version where you pass a set of parameters and can tell it
%just to extract ones that haven't been done already

atlas=readtable(atlaspath);%read in the atlas
atlas=rmmissing(atlas);
atlas=table2struct(atlas); %convert the atlas from a table to struct for easier access

%all data organized first by parameter then by genotype

parameters={};


if length(varargin)>2
    %do individual loads
else
    %load all - this is the default
    for k=1:numel(atlas)
        genoname=atlas(k).genotype;%get the genotype name as a string
        genoname=strcat('d', genoname); %in case the name starts with a number
        try
            genotypedata=load(atlas(k).datafilename);%load each genotype
            
            fn=fieldnames(genotypedata);%get the first field which is the genotype
            genotypedata=genotypedata.(fn{1});
            try
            resdata=genotypedata.(condition);%get the right condition
            catch
                resdata=genotypedata.('resblankalwaysonhigh');
            end
            resdata=preparedata(resdata,[30 35],0.25,0);
            %for chrimson activation the alignment of the data is the same for
            %onset/offset so does not need to be prepared differently as it
            %would for odour (other than orco-acv)
            %don't double extract the baseline - even though looking at
            %different periods don't need the same baseline values twice.
            [pmove,pmovebase]=flybyflyparams('pmove',[10 25 30 35],resdata,0); %0 means use the mode where they return base and extracted, not the difference
            [groundspeed,groundspeedbase]=flybyflyparams('vmove',[10 25 32 35],resdata,0);
            [groundspeedoff,~]=flybyflyparams('vmove',[10 25 40 42],resdata,0);
            [upwind,upwindbase]=flybyflyparams('vymove',[10 25 30 35],resdata,0);
            [upwindoff,~]=flybyflyparams('vymove',[10 25 40 42],resdata,0);
            [angv,angvbase]=flybyflyparams('angv',[10 25 32 35],resdata,0);
            [angvoff,~]=flybyflyparams('angv',[10 25 40 42],resdata,0);
            [angvon,~]=flybyflyparams('angv',[10 25 30 31],resdata,0);
            [curvature,curvaturebase]=flybyflyparams('curvature',[10 25 32 35],resdata,0);
            [curvatureoff,~]=flybyflyparams('curvature',[10 25 40 42],resdata,0);
            [curvatureon,~]=flybyflyparams('curvature',[10 25 30 31],resdata,0);
            [placepref,basepref]=flybyflyparams('yfilt',[25 30 37.5 42.5],resdata,0);
            %[Bdur,BINTdur,Rdur,RINTdur,Boff,BINToff,Roff,RINToff]=getcurveslopefull(resdata);
            
            %save all the parameters as individual genotypes to be accessed
            %later. This can be output (and hopefully) read by python or used
            %for plotting.
            parameters.pmove.(genoname)=pmove;
            parameters.pmovebase.(genoname)=pmovebase;
            parameters.groundspeed.(genoname)=groundspeed;
            parameters.groundspeedbase.(genoname)=groundspeedbase;
            parameters.groundspeedoff.(genoname)=groundspeedoff;
            parameters.upwind.(genoname)=upwind;
            parameters.upwindbase.(genoname)=upwindbase;
            parameters.upwindoff.(genoname)=upwindoff;
            parameters.angv.(genoname)=angv;
            parameters.angvbase.(genoname)=angvbase;
            parameters.angvoff.(genoname)=angvoff;
            parameters.angvon.(genoname)=angvon;
            parameters.curvature.(genoname)=curvature;
            parameters.curvaturebase.(genoname)=curvaturebase;
            parameters.curvatureoff.(genoname)=curvatureoff;
            parameters.curvatureon.(genoname)=curvatureon;
            parameters.placepref.(genoname)=placepref;
            parameters.basepref.(genoname)=basepref;
            
        catch
            disp(['could not load ' atlas(k).datafilename]);
        end
        
    end
    
    try
    savename='miniparameters.mat';
    save(savename,'parameters');
    catch
    end
    %somewhere should save the p-values?
    
    
    
    
    
    
    
    
    
    
    
end
end




