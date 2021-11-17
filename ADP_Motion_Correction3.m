function [] = ADP_Motion_Correction3(inFolder, outFolder, rigid)

    if(nargin<3)
        rigid = true;
    end

    fprintf('\nFolder %s\n',inFolder);
%     outFolder = strrep(inFolder,'RawData','MotionCorrected');
    
    fprintf('\nLoading...');
    [Y, Yred] = makeStacks3(inFolder, 10);
    fprintf('Done!\n');
    
    FOV = [size(Y,1),size(Y,2)];
    if(rigid)
        options = NoRMCorreSetParms('d1',FOV(1),'d2',FOV(2),'bin_width',200,'max_shift',30,'us_fac',50, 'init_batch', 200); %are these parameters really what I want for the motion correction?
    else
        options = NoRMCorreSetParms('d1',FOV(1),'d2',FOV(2),'grid_size',[128,128],'mot_uf',4,'bin_width',200,'max_shift',30,'max_dev',3,'us_fac',50,'init_batch',200);
    end
    tsub=20; % temporal downsampling factor 

    [M,shifts,template] = normcorre_batch(Y,options);
    %clear Y;
    [Mred,shifts_red,template_red] = normcorre_batch(Yred,options);
    %clear Yred;
    
    M_final = apply_shifts(Y,shifts_red,options);
    M_final_red = apply_shifts(Yred,shifts_red,options);
    
    if(~exist(outFolder,'dir'))
        mkdir(outFolder);
    end
    
    save(fullfile(outFolder,'MC_Parameters'),'shifts', 'options', 'template', 'shifts_red', 'template_red');
    if(rigid)
        file_name = fullfile(outFolder,'MC_Video.tif');
        file_name_red = fullfile(outFolder,'MC_Video_Red.tif');
    else
        file_name = fullfile(outFolder,'MC_Video_nonrigid.tif');
    end
    options.overwrite = true;
    saveastiff(int16(M_final), file_name, options);
    saveastiff(int16(M_final_red), file_name_red, options);
    
    ndimsY = ndims(M_final)-1;
    sY = size(M_final);
    ds = sY(1:ndimsY);
    T = sY(end);
    Ts = floor(T/tsub);   
    Y_ds = squeeze(mean(reshape(M_final(:, :, 1:(Ts*tsub)),ds(1), ds(2), tsub, Ts), 3));
    if(rigid)
        file_name = fullfile(outFolder,'MC_Video_TSub.tif');
    else
        file_name = fullfile(outFolder,'MC_Video_TSub_nonrigid.tif');
    end
    saveastiff(int16(Y_ds), file_name, options);
end