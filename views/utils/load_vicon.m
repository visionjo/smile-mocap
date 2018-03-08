function Hds = load_vicon(hObject, Hds, current_sample)
%LOAD_VICON reads and displays vicon skeleton data in axis on right.

vicondir = [Hds.loaddir filesep 'vicon_data' filesep 'skeleton' filesep];
fpath = [vicondir current_sample '.csv'];

if ~exist(fpath, 'file'), return; 	end

fprintf(1, 'loading vicon (skeleton) data: %s\n', fpath);
Hds.v_skeleton = ViconSkeleton(fpath);

Hds.v_skeleton.scatter_plot2(Hds);%,cut_sec);

guidata(hObject, Hds);              % Update Hds structure
end

