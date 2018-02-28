%% demo:  Simple script visualizing skeleton data as captured by 
%     AUTHOR    : Joseph Robinson
%     DATE      : February-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : demo_visualize_vicon.m
%

% instantiate ViconSkeleton object
root_dir = mocap_setup();
v_skeleton = ViconSkeleton([root_dir 'demo/data/vicon/skeleton/Allyson-1-devel.csv']);

frame_step = 100; % number of frames to skip between steps in visualization
v_skeleton.scatter_plot(frame_step);