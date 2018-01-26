%% demo: parse single vicon file as exported from system.
rdir = mocap_setup();
obins = strcat(rdir, '/demo/results/', {'emg/', 'skeleton/'});
fin = [rdir '/data/Allyson-1-devel.csv'];

fbase = utils.basename(fin);
% create directories if do not exist
cellfun(@utils.checkdir, obins)
% parse vicon data
[emg_table, skel_table] = parse_vicon(fin);
writetable(emg_table, [obins{1}, fbase], 'Delimiter',',');

writetable(skel_table, [obins{2}, fbase], 'Delimiter',',');
