function initialize_cuts_file(Hds)
%Simple script that outputs file difference (offset) between kinect and
%vicon data.
if exist(Hds.outcsv2, 'file')
    fprintf(1, '\nAlignmnet File Exists: %s\n', Hds.outcsv2)
    return;
end

str_samples = Hds.menu_samples.String;
nsamples = length(str_samples);

offsets = zeros(nsamples, 1);
T = table(str_samples, offsets);

fprintf(1, '\nInitializing Table: %s\n', Hds.outcsv2)
writetable(T, Hds.outcsv2, 'Delimiter', ',')
