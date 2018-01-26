function [emg_table, skel_table] = parse_vicon(f_vicon)
%PARSE_VICON Function that loads, parses, and saves files from vicon.
%   Function takes in a filepath to csv file exported via vicon system SW.
%   With this both the EMG and skeleton data are parsed and formatted into
%   tables seperately, and the saved under the same basename of the input
%   file, just in the proper directory
%
%     AUTHOR    : Joseph Robinson
%     DATE      : January-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : parse_vicon.m
%
% TODO dynamically set output directory
%

token = 'Frame';
n_emg_sensors = 4;

% read contents of vicon file
contents= utils.csv2cell(f_vicon, 'fromfile');

%% Parse EMG data and store as table object
% determine where emg and skeleton rows begin, assumption is EMG is above.
ids_emg = find(strcmp(contents(:,1), token), 1, 'first');   
ids_traj = find(strcmp(contents(:,1), token), 1, 'last');

% slice out emg and
emg_rows = [ids_emg, ids_emg+2:ids_traj-2];

emg_data = contents(emg_rows, 1:(n_emg_sensors+2));
header = strrep(contents(emg_rows(1), 1:(n_emg_sensors+2)),' ','');
emg_data(cellfun(@isempty,emg_data)) = {nan};
% convert emg data to formatted table to return
emg_table = cell2table(emg_data,'VariableNames',[header(1:2) strcat('s', header(3:n_emg_sensors+2))]);


%% Skeleton
% slice out skeleton data
skeleton_data = contents(ids_traj-1:end, :);

while isempty([skeleton_data{:,end}])
    % check that extra (empty) columns were not read in; if so, remove
    skeleton_data = skeleton_data(:,1:end-1);
end

% parse location labels (i.e., column header). Each part is tagged
% <subject name>:PART where PART represents the body part corresponding to
% the location data in column + proceeding 2 columns (i.e., x, y, z)
loc = skeleton_data(1,3:end-2);

% determine the indices to start slicing each (x,y,z) point from
ids=cell2mat(cellfun(@(x) any(~isempty(x)), loc,'uni',false));
% account for 1st two columns being frame ID and relative subframe count
xcols = find(ids)+2;

skeleton = cell(1, length(xcols)-1);
for x = 1:length(xcols)-1
    % store (x,y,z) points for each part in cell array (i.e., each item is
    % of size Nx3, where N is the number of frames and 3 is the (x,y,z)
    skeleton{x} = cellfun(@str2double,skeleton_data(4:end, xcols(x):xcols(x)+2));
end

% prepare part tags
tags = strrep(loc(xcols(1:end-1)+1), ':','_');
sr_refs = cellfun(@(x) x(2), cellfun(@(x) strsplit(x, '_'), tags,'uni', false), 'uni', false);
parts = cat(1, sr_refs{:});

nparts = length(parts);
ncoords = nparts*3; % allocate enough for x, y, and z for each part

s_header = cell(1, ncoords);
counter = 1;
for x = 1:nparts
    cpart = parts{x};
    %append coordinate axis variable to each part corresponding to points
    s_header{counter} = strcat(cpart, '_X');
    s_header{counter+1} = strcat(cpart, '_Y');
    s_header{counter+2} = strcat(cpart, '_Z');
    counter = counter + 3;
    
end
% prepare frame ID and Track ID
frame_id = cellfun(@str2num,(skeleton_data(4:end, 1)));
traj_id = cellfun(@str2num,(skeleton_data(4:end, end)));

% convert skeleton cell to formatted table to return
skeleton = skeleton(cellfun(@isempty,skeleton)==0);
skeleton_array = cat(2, skeleton{:});
skel_table = array2table([frame_id, traj_id skeleton_array], 'VariableNames',['Frame', 'TrackID', s_header]);
