% have the locations of all the data.
% want to extract and store all the useful parameters,
% Keep this all extracted then make a function to plot the relevant ones.
%Save the extracted parameters so I don't have to keep dealing with this.
%be able to take a flag just to extract a certain type of anatomy.
%Make the flags variable arguments so that one can add as many as they want

function [parameterslight,parametersodour]=orcoacvextract(atlaspath,condition1,condition2)
%atlas is the path to the spreadsheet containing all of the file locations
%for the genotypes. Give this this one just the orco acv data

atlas=readtable(atlaspath);%read in the atlas
atlas=rmmissing(atlas);
atlas=table2struct(atlas); %convert the atlas from a table to struct for easier access

%all data organized first by parameter then by genotype

parameterslight={};
parametersodour={};



%load all - this is the default
for k=1:numel(atlas)
    genoname=atlas(k).genotype;%get the genotype name as a string
    genoname=strcat('d', genoname); %in case the name starts with a number
    try
        genotypedata=load(atlas(k).datafilename);%load each genotype
        
        fn=fieldnames(genotypedata);%get the first field which is the genotype
        genotypedata=genotypedata.(fn{1});
        resdatalight=genotypedata.(condition1);%get the right condition
        resdataodour=genotypedata.(condition2);
        resdatalight=preparedata(resdatalight,[30 35],0.25,0);
        resdataodour=preparedata(resdataodour,[30 35],0.25,0);% going to need to turn on the on/off filtering from avels - code wont do it automatically
        
        %for chrimson activation the alignment of the data is the same for
        %onset/offset so does not need to be prepared differently as it
        %would for odour (other than orco-acv)
        %don't double extract the baseline - even though looking at
        %different periods don't need the same baseline values twice.
        [pmove,pmovebase]=flybyflyparams('pmove',[10 25 30 35],resdatalight,0); %0 means use the mode where they return base and extracted, not the difference
        [groundspeed,groundspeedbase]=flybyflyparams('vmove',[10 25 32 35],resdatalight,0);
        [groundspeedoff,~]=flybyflyparams('vmove',[10 25 40 42],resdatalight,0);
        [upwind,upwindbase]=flybyflyparams('vymove',[10 25 30 35],resdatalight,0);
        [upwindoff,~]=flybyflyparams('vymove',[10 25 40 42],resdatalight,0);
        [angv,angvbase]=flybyflyparams('angv',[10 25 32 35],resdatalight,0);
        [angvoff,~]=flybyflyparams('angv',[10 25 40 42],resdatalight,0);
        [angvon,~]=flybyflyparams('angv',[10 25 30 31],resdatalight,0);
        [curvature,curvaturebase]=flybyflyparams('curvature',[10 25 32 35],resdatalight,0);
        [curvatureoff,~]=flybyflyparams('curvature',[10 25 40 42],resdatalight,0);
        [curvatureon,~]=flybyflyparams('curvature',[10 25 30 31],resdatalight,0);
        [placepref,basepref]=flybyflyparams('yfilt',[25 30 37.5 42.5],resdatalight,0);
        
        [pmoveodour,pmovebaseodour]=flybyflyparams('pmove',[10 25 30 35],resdataodour,0); %0 means use the mode where they return base and extracted, not the difference
        [groundspeedodour,groundspeedbaseodour]=flybyflyparams('vmove',[10 25 32 35],resdataodour,0);
        [groundspeedoffodour,~]=flybyflyparams('vmove',[10 25 40 42],resdataodour,0);
        [upwindodour,upwindbaseodour]=flybyflyparams('vymove',[10 25 30 35],resdataodour,0);
        [upwindoffodour,~]=flybyflyparams('vymove',[10 25 40 42],resdataodour,0);
        [angvodour,angvbaseodour]=flybyflyparams('angv',[10 25 32 35],resdataodour,0);
        [angvoffodour,~]=flybyflyparams('angv',[10 25 40 42],resdataodour,0);
        [angvonodour,~]=flybyflyparams('angv',[10 25 30 31],resdataodour,0);
        [curvatureodour,curvaturebaseodour]=flybyflyparams('curvature',[10 25 32 35],resdataodour,0);
        [curvatureoffodour,~]=flybyflyparams('curvature',[10 25 40 42],resdataodour,0);
        [curvatureonodour,~]=flybyflyparams('curvature',[10 25 30 31],resdataodour,0);
        [placeprefodour,baseprefodour]=flybyflyparams('yfilt',[25 30 37.5 42.5],resdataodour,0);
        %[Bdur,BINTdur,Rdur,RINTdur,Boff,BINToff,Roff,RINToff]=getcurveslopefull(resdata);
        
        %save all the parameters as individual genotypes to be accessed
        %later. This can be output (and hopefully) read by python or used
        %for plotting.
        parameterslight.pmove.(genoname)=pmove;
        parameterslight.pmovebase.(genoname)=pmovebase;
        parameterslight.groundspeed.(genoname)=groundspeed;
        parameterslight.groundspeedbase.(genoname)=groundspeedbase;
        parameterslight.groundspeedoff.(genoname)=groundspeedoff;
        parameterslight.upwind.(genoname)=upwind;
        parameterslight.upwindbase.(genoname)=upwindbase;
        parameterslight.upwindoff.(genoname)=upwindoff;
        parameterslight.angv.(genoname)=angv;
        parameterslight.angvbase.(genoname)=angvbase;
        parameterslight.angvoff.(genoname)=angvoff;
        parameterslight.angvon.(genoname)=angvon;
        parameterslight.curvature.(genoname)=curvature;
        parameterslight.curvaturebase.(genoname)=curvaturebase;
        parameterslight.curvatureoff.(genoname)=curvatureoff;
        parameterslight.curvatureon.(genoname)=curvatureon;
        parameterslight.placepref.(genoname)=placepref;
        parameterslight.basepref.(genoname)=basepref;
        %parameters.Bdur.(genoname)=Bdur;
        %parameters.Boff.(genoname)=Boff;
        %parameters.BINTdur.(genoname)=BINTdur;
        %parameters.BINToff.(genoname)=BINToff;
        %parameters.Rdur.(genoname)=Rdur;
        %parameters.Roff.(genoname)=Roff;
        %parameters.RINTdur.(genoname)=RINTdur;
        %parameters.RINToff.(genoname)=RINToff;
        parametersodour.pmove.(genoname)=pmoveodour;
        parametersodour.pmovebase.(genoname)=pmovebaseodour;
        parametersodour.groundspeed.(genoname)=groundspeedodour;
        parametersodour.groundspeedbase.(genoname)=groundspeedbaseodour;
        parametersodour.groundspeedoff.(genoname)=groundspeedoffodour;
        parametersodour.upwind.(genoname)=upwindodour;
        parametersodour.upwindbase.(genoname)=upwindbaseodour;
        parametersodour.upwindoff.(genoname)=upwindoffodour;
        parametersodour.angv.(genoname)=angvodour;
        parametersodour.angvbase.(genoname)=angvbaseodour;
        parametersodour.angvoff.(genoname)=angvoffodour;
        parametersodour.angvon.(genoname)=angvonodour;
        parametersodour.curvature.(genoname)=curvatureodour;
        parametersodour.curvaturebase.(genoname)=curvaturebaseodour;
        parametersodour.curvatureoff.(genoname)=curvatureoffodour;
        parametersodour.curvatureon.(genoname)=curvatureonodour;
        parametersodour.placepref.(genoname)=placeprefodour;
        parametersodour.basepref.(genoname)=baseprefodour;
        
    catch
        disp(['could not load ' atlas(k).datafilename]);
    end
    
end

try
    savename='Fig1parameters.mat';
    save(savename,'parameterslight','parametersodour');
catch
end

end





