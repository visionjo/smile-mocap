outbin = 'data/vicon_data/skel_missing_ref/';

utils.checkdir(outbin);

f_vicon = 'data/kate-1.csv';

token = 'Field #';

% read contents of vicon file
contents= utils.csv2cell(f_vicon, 'fromfile');

%% Parse EMG data and store as table object
% determine where skeleton rows begin
ids_traj = find(strcmp(contents(:,1), token), 1, 'first');
skeleton_data = contents(ids_traj+1:end,1:38*3+1);
skel_table = cell2table(skeleton_data);

writetable(skel_table, [outbin utils.basename(f_vicon)])