%% demo:  Simple script visualizing skeleton data as captured by 
%     AUTHOR    : Joseph Robinson
%     DATE      : February-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : demo_visualize_vicon.m
%

% instantiate ViconSkeleton object
root_dir = mocap_setup();
v_skeleton = ViconSkeleton([root_dir 'data/Allyson-2.csv']);

% frame_step = 100; % number of frames to skip between steps in visualization
% v_skeleton.scatter_plot2(frame_step);
rgb_data=load([root_dir 'data/Allyson_2.mat']);
  
cut_sec = 2.5;

%if cut_sec > 0, means cut several start frames of rgb;
%if cut_sec < 0, means cut several start frames from vicon;

frame_step = 5; % number of frames to skip between steps in visualization
v_skeleton.scatter_plot2(frame_step,rgb_data,cut_sec);

