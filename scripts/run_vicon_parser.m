%% Script to process entire collection of vicon data
%     AUTHOR    : Joseph Robinson
%     DATE      : January-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : run_vicon_parser.m
d1 = dir('../Vicon_data_csv_Feb10/*.csv');
obin = '../parsed_vicon_new/';
obins = strcat(obin, {'emg/', 'skeleton/'});

% make output directories
cellfun(@utils.checkdir, obins)

% prepare filepaths for skeleton and emg data extracted from each file
nfiles = length(d1);
fpaths = strcat({d1.folder}, '/', {d1.name});
fout_emg = strcat(obins{1}, {d1.name});
fout_skel = strcat(obins{2}, {d1.name});


f_skeleton_exists = cellfun(@exist,fout_skel);
f_emg_exists = cellfun(@exist,fout_emg);

do_exist =  f_skeleton_exists | f_emg_exists;

parfor x = 1:nfiles
    %% each vicon file
    
    if do_exist(x)
        %% if either exist, skip
        fprintf('\nNot processing %s\n', fpaths{x})
        fprintf('\n%s exists: (%d)\n%s exists: (%d)\n', fout_skel{x}, ...
            f_skeleton_exists(x), fout_emg{x}, f_emg_exists(x));
        
        continue
    end
    try
        % try-catch 
        [emg_table, skel_table] = parse_vicon(fpaths{x});
        
        % write-out parsed tables
        writetable(emg_table, fout_emg{x}, 'Delimiter',',');
        writetable(skel_table, fout_skel{x}, 'Delimiter',',');
    catch e
        % print warning if exception thrown
        fprintf(1, 'WARNING: [%d] %s thrown exception', x, fpaths{x});
    end
    
end

