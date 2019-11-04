function Hds = display_data(hObject, Hds, current_sample)
%DISPLAY_DATA loads and displays samples from both devices and for proper
%modalities. Specifically, left axis shows RGB data as seen by the Kinect
%sensor and right axis shows skeleton data as scattered points as seen by
%the Vicon system.


%% Check that both data files exist before loading either
kinectdir = [Hds.loaddir filesep 'action_data' filesep];
fpath = [kinectdir current_sample '.mat'];
do_escape = 0;
if ~exist(fpath, 'file')
    %% Check kinect
    fprintf(2, '\nKinect Data File Missing:\n\t%s\n', fpath); 	
    do_escape = 1;
end
vicondir = [Hds.loaddir filesep 'vicon_data' filesep 'skeleton' filesep];
fpath = [vicondir current_sample '.csv'];

if ~exist(fpath, 'file')
    %% Check vicon
    fprintf(2, '\nVicon Data File Missing:\n\t%s\n', fpath); 	
    do_escape = 1;
end
%% Return if either or both data files do not exist
if do_escape,   return; end

%% Load data
Hds = load_kinect(hObject, Hds, current_sample);
display_frame(Hds);
Hds = load_vicon(hObject, Hds, current_sample);
display_vicon_frame(Hds);

end

