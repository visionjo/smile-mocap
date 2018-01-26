%% demo: parse single vicon file as exported from system.
%     AUTHOR    : Joseph Robinson
%     DATE      : January-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : demo_parse_vicon.m
%
disp('Demo: BEGIN')
rdir = mocap_setup();
obins = strcat(rdir, '/demo/results/', {'emg/', 'skeleton/'});
fin = [rdir '/data/Allyson-1-devel.csv'];

fbase = utils.basename(fin);
% create directories if do not exist
cellfun(@utils.checkdir, obins)
% parse vicon data
[emg_table, skel_table] = parse_vicon(fin);
disp('EMG DATA:')
disp(head(emg_table))
disp('')

disp('SKELETON DATA:')
disp(head(skel_table))


writetable(emg_table, [obins{1}, fbase], 'Delimiter',',');

writetable(skel_table, [obins{2}, fbase], 'Delimiter',',');
disp('Demo: END')