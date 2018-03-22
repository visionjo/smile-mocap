outbin = 'data/vicon_data/skel_missing_ref/';

utils.checkdir(outbin);

f_vicon = 'data/kate-1.csv';

token = 'Field #';
token2 = 'ANALOG';

% read contents of vicon file
contents= utils.csv2cell(f_vicon, 'fromfile');

%% Parse EMG data and store as table object
% determine where skeleton rows begin
ids_traj = find(strcmp(contents(:,1), token), 1, 'first');
ids_emg = find(strcmp(contents(:,1), token2), 1, 'first') - 2;
skeleton_cell = contents(ids_traj+1:ids_emg,1:38*3+1);

skel_table = cell2table(skeleton_cell(:,2:end));

writetable(skel_table, [outbin utils.basename(f_vicon)], 'VariableNames',false);