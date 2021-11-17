function [files] = jdir(folder, regexp)
    %[files] = jdir(folder, regexp)
    home = pwd;
    cd(folder);
    files = dir(regexp);
    cd(home);
end