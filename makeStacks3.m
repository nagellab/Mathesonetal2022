function [Ygreen, Yred] = makeStacks3(folder, pctUpdate)

    if(nargin<2)
        pctUpdate = [];
        flag = false;
    else
        flag = true;
    end

    
    files = jdir(folder,'ChanA_*.tif');
    if(~isempty(files))
        r = imread(fullfile(folder,files(1).name));        
    else
        r = NaN(512,512);
    end
    N = length(files);
    Ygreen = zeros(size(r,1),size(r,2),N,'uint16');
    
    if(flag==1)
        npoints = ceil(100/pctUpdate);
        checkpoints = ceil(linspace(0,N,npoints+1));
        checkpoints = checkpoints(2:end);
    else
        checkpoints = [];
    end
    count = 1;
    for i=1:N
        if(flag && i>=checkpoints(count))
            count = count+1;
            fprintf('%d%%...',ceil(100*i/N));
        end
        r = imread(fullfile(folder,files(i).name));        
        Ygreen(:,:,i) = r;
    end
    
    
    files = jdir(folder,'ChanB*.tif');
    if(~isempty(files))
        r = imread(fullfile(folder,files(1).name));        
    else
        r = NaN(512,512);
    end
    N = length(files);
    Yred = zeros(size(r,1),size(r,2),N,'uint16');
    
    if(flag==1)
        npoints = ceil(100/pctUpdate);
        checkpoints = ceil(linspace(0,N,npoints+1));
        checkpoints = checkpoints(2:end);
    else
        checkpoints = [];
    end
    count = 1;
    for i=1:N
        if(flag && i>=checkpoints(count))
            count = count+1;
            fprintf('%d%%...',ceil(100*i/N));
        end
        r = imread(fullfile(folder,files(i).name));        
        Yred(:,:,i) = r;
    end

end
