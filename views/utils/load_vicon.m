function Hds = load_vicon(hObject, Hds, current_sample)
%LOAD_VICON reads and displays vicon skeleton data in axis on right.

vicondir = [Hds.loaddir filesep 'vicon_data' filesep 'skeleton' filesep];
fpath = [vicondir current_sample '.csv'];

if ~exist(fpath, 'file'), return; 	end

fprintf(1, 'loading vicon (skeleton) data: %s\n', fpath);
Hds.v_skeleton = ViconSkeleton(fpath);

% Hds.v_skeleton.scatter_plot2(Hds);%,cut_sec);
colors=[];
colors(1:3)='k';
colors(4:9)='y';
colors(10:16)='r';
colors(17:23)='g';
colors(24:27)='y';
colors(28:38)='b';

parts = Hds.v_skeleton.get_parts_str();
axes(Hds.axis_vicon);

hold on;
grid on;
%                 axis([-1000,1500,-500,1500,0,2000]);

for r = 1:Hds.v_skeleton.nparts
    % for each marker
    
    coords = Hds.v_skeleton.(parts{r})(1,:);
    scatter3(coords(1), coords(2), coords(3),char(colors(r)),'filled');
end
view(135,30)
hold off;

guidata(hObject, Hds);              % Update Hds structure
end

