function initialize_output_file(Hds)
%Simple script that outputs file with alignment tags
%   Alignment information are stored for each sample in a single CSV file.
%   For each, the frame for vicon and kinect are stored. From this frame,
%   it is assumed that the two samples line up with vicon captured at 100
%   fps and kinect at 30 fps. Initially, samples are stored with '0' zeros
%   type int. This indicates that the sample has yet to be aligned, as
%   frame ID 0 does not exist by convention (Frame 1-N, where N is the
%   number of frames captured by the device).
if exist(Hds.outcsv, 'file')
    fprintf(1, 'Alignmnet File Exists: %s', Hds.outcsv)
    return;
end

str_samples = Hds.menu_samples.String;
nsamples = length(sample_strings);

vicon_frame = zeros(nsamples, 1);
kinect_frame = zeros(nsamples, 1);
T = table(str_samples, vicon_frame, kinect_frame);

fprintf(1, 'Initializing Table: %s', Hds.outcsv)
writetable(T, Hds.outcsv, 'Delimiter', ',')
