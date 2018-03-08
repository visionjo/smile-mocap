function Hds = display_data(hObject, Hds, current_sample)
%DISPLAY_DATA loads and displays samples from both devices and for proper
%modalities. Specifically, left axis shows RGB data as seen by the Kinect
%sensor and right axis shows skeleton data as scattered points as seen by
%the Vicon system.


Hds = load_video(hObject, Hds, current_sample);
end

