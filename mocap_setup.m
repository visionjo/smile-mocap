function DIR_ROOT =  mocap_setup()
%%
%     Sets up workspace for motion capture and emg data.
%           - adds directories to path.
%
%     AUTHOR    : Joseph Robinson
%     DATE      : January-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : mocap_setup.m
%
dirnames = {'scripts','dataprocess', 'demo', 'include',};

fpath = which ('mocap_setup');

if isempty(fpath)
    fprintf(2,'ERROR: Could not determine ROOT_DIR of project');
    return;
end

if ispc,    tmp = strfind(fpath,'\');   else,    tmp = strfind(fpath,'/');
end

warning('OFF', 'MATLAB:dispatcher:nameConflict') 
cur_root = pwd;
DIR_ROOT = fpath(1:tmp(end));   

addpath(DIR_ROOT);

cd (DIR_ROOT);

for indx = 1:length(dirnames)
    addpath(genpath(strcat(DIR_ROOT,dirnames{indx})));
end

cd (cur_root);

fprintf(1,'\nMocap Tools: Done configuring workspace!\n');
if nargout == 0,    DIR_ROOT = '';  end


end