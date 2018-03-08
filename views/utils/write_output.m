function [outputArg1,outputArg2] = write_output(inputArg1,inputArg2)
%%WRITE_OUTPUT Simply updates the alignment file. Specifically, the function
%reads in alignment file, rewrites its contents entirely, with exception of
%newly added alignment data (i.e., annotations for current sample).
%Additionally, 2 backup files are written: (1) backup is made of file
%before anything is done to or with it (i.e., first thing is a copy is
%made); (2) copy is made after newly added information is added.

if ~exist(Hds.outcsv, 'file')
    %% check if file exists, if not, initialize file and exit function
    fprintf(2, 'Alignmnet File not found: %s', Hds.outcsv)
    initialize_output_file(Hds);
    return;
end

%% create backup of existing file
f_csvtemp = strreo(Hds.outcsv, '.csv', '-backup.csv');
fprintf(1, 'Creating Backup before updating: %s', f_csvtemp)
copyfile(Hds.csvout, f_csvtemp);

%% read in current alignment file as type Table
csvcontents = readtable(Hds.outcsv, 'Delimiter', ',');
fprintf(1, 'Writing Out: %s', Hds.outcsv)

%% TODO write added tags


%% copy file with updated information
f_csvtemp2 = strreo(Hds.outcsv, '.csv', '-backup-current.csv');
fprintf(1, 'Creating Backup post update: %s', f_csvtemp2)
copyfile(Hds.csvout, f_csvtemp2);