function write_output(Hds)
%%WRITE_OUTPUT Simply updates the alignment file. Specifically, the function
%reads in alignment file, rewrites its contents entirely, with exception of
%newly added alignment data (i.e., annotations for current sample).
%Additionally, 2 backup files are written: (1) backup is made of file
%before anything is done to or with it (i.e., first thing is a copy is
%made); (2) copy is made after newly added information is added.

if ~exist(Hds.outcsv, 'file')
    %% check if file exists, if not, initialize file and exit function
    fprintf(2, '\nAlignmnet File not found: %s\n', Hds.outcsv)
    initialize_output_file(Hds);
    %     return;
end

if ~exist(Hds.outcsv2, 'file')
    %% check if file exists, if not, initialize file and exit function
    fprintf(2, '\nAlignmnet File not found: %s\n', Hds.outcsv)
    initialize_cuts_file(Hds);
    %     return;
end




%% create backup of existing file
f_csvtemp = strrep(Hds.outcsv, '.csv', '-backup.csv');
fprintf(1, 'Creating Backup before updating: %s\n', f_csvtemp)
copyfile(Hds.outcsv, f_csvtemp);

f_csvtemp2 = strrep(Hds.outcsv2, '.csv', '-backup.csv');
fprintf(1, 'Creating Backup before updating: %s\n', f_csvtemp2)
copyfile(Hds.outcsv2, f_csvtemp2);


%% read in current alignment file as type Table
csvcontents = readtable(Hds.outcsv, 'Delimiter', ',');
fprintf(1, 'Writing Out: %s', Hds.outcsv)

%% write added tags
str_samples = Hds.menu_samples.String;
ids = Hds.menu_samples.Value;
str_sample = str_samples{ids};


%% read in current offsets file
cids = find(strcmp(csvcontents.str_samples, str_sample));
csvcontents.kinect_frame(cids) = Hds.v_current_index;
csvcontents.vicon_frame(cids) = Hds.video_data.current_index;

fprintf(1, 'Updating Table: %s\n', Hds.outcsv)
writetable(csvcontents, Hds.outcsv, 'Delimiter', ',')


%% read in current offsets file
csvcontents2 = readtable(Hds.outcsv2, 'Delimiter', ',');
fprintf(1, 'Writing Out: %s', Hds.outcsv2)

csvcontents2.offsets(cids) = str2double(Hds.tf_offset.String);

fprintf(1, 'Updating Table: %s\n', Hds.outcsv2)
writetable(csvcontents2, Hds.outcsv2, 'Delimiter', ',')



%% copy file with updated information
f_csvtemp3 = strrep(Hds.outcsv, '.csv', '-backup-current.csv');
fprintf(1, 'Creating Backup post update: %s\n\n', f_csvtemp3)
copyfile(Hds.outcsv, f_csvtemp3);

f_csvtemp4 = strrep(Hds.outcsv2, '.csv', '-backup-current.csv');
fprintf(1, 'Creating Backup post update: %s\n\n', f_csvtemp4)
copyfile(Hds.outcsv2, f_csvtemp4);
