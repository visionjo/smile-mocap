function Hds = load_video(hObject, Hds, current_sample)
%LOAD_VIDEO reads and displays kinect data in axis left side of GUI.

kinectdir = [Hds.loaddir filesep 'action_data' filesep];
fpath = [kinectdir current_sample '.mat'];

if ~exist(fpath, 'file'), return; 	end

fprintf(1, 'loading kinect (rgb) data: %s\n', fpath);
data_in = load(fpath, 'image_record', 'time_record');

Hds.video_data = Video(data_in.image_record, fpath);
Hds.kinect_tstamp = data_in.time_record;
guidata(hObject, Hds);              % Update Hds structure

end

