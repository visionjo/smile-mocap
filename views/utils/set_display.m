function  set_display (handles)
%SET_DISPLAY_INFO Displays info on GUI for current exemplar under review.
%
if handles.video_data.display
    % display index over total
    t_cur_index = num2str(handles.video_data.current_index);
    t_count_total = num2str(handles.video_data.nframes);
    
    t_frame_count = [t_cur_index '/' t_count_total];
    set(handles.t_cur_exemplar, 'String',t_frame_count);
end