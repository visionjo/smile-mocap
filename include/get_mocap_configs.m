function out = get_mocap_configs(str)
%MOCAP_CONFIGS Simple means of setting, storing, and fetching project
%configurations
out = [];
switch lower(str)
    case 'vicon'
        out.nsensors = 38;
        out.ref = 'vicon';
    case 'kinext'
        out.nsensors = 16;
        out.ref = 'kinect';
end